import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/calendario.dart';
import '../../../mock/mock.dart';
import 'item_processo.dart';


class ListaProcessos extends StatelessWidget {
  const ListaProcessos({super.key});

  @override
  Widget build(BuildContext context) {
    
    final hoje = DateTime.now();
    final inicioDoDia = DateTime(hoje.year, hoje.month, hoje.day);

    final eventosFuturos = eventos.where((evento) {
      final dataEvento = DateTime(evento.date.year, evento.date.month, evento.date.day);
      return !dataEvento.isBefore(inicioDoDia);
    }).toList();


    final agrupados = _agruparPorData(eventosFuturos);

    if (agrupados.isEmpty) {
      return const _EmptyState();
    }

    // 4. Monta uma lista "flat" intercalando headers e cards.
    //    Cada entrada é um _ListItem que pode ser header ou card.
    //    Isso permite usar ListView.builder (lazy) ao invés de Column (eager).
    final itensFlat = <_ListItem>[];

    for (final entry in agrupados.entries) {
      // Adiciona o header da data
      itensFlat.add(_ListItem.header(entry.key, entry.value.length));

      // Adiciona cada evento como card
      for (final evento in entry.value) {
        itensFlat.add(_ListItem.card(evento));
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itensFlat.length,
      itemBuilder: (context, index) {
        final item = itensFlat[index];

        if (item.isHeader) {
          return _HeaderData(
            data: item.data!,
            quantidade: item.quantidade,
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ItemProcesso(item: item.evento!),
        );
      },
    );
  }

  /// Agrupa uma lista de eventos por data (ignorando hora).
  /// Retorna um Map ordenado cronologicamente.
  Map<DateTime, List<Calendario>> _agruparPorData(List<Calendario> lista) {
    final map = <DateTime, List<Calendario>>{};

    for (final evento in lista) {
      // Chave normalizada: apenas ano/mês/dia (sem hora/minuto/segundo)
      final chave = DateTime(evento.date.year, evento.date.month, evento.date.day);
      map.putIfAbsent(chave, () => []).add(evento);
    }

    // Ordena as chaves cronologicamente (mais próximo primeiro)
    return Map.fromEntries(
      map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }
}

// ---------------------------------------------------------------------------
// Tipos auxiliares internos (privados ao arquivo)
// ---------------------------------------------------------------------------

/// Representa um item na lista flat: pode ser um header de data ou um card.
/// Isso evita usar tipos dinâmicos ou listas heterogêneas sem tipagem.
class _ListItem {
  final bool isHeader;
  final DateTime? data;
  final int quantidade;
  final Calendario? evento;

  // Construtor para header de seção
  _ListItem.header(this.data, this.quantidade)
      : isHeader = true,
        evento = null;

  // Construtor para card de processo
  _ListItem.card(this.evento)
      : isHeader = false,
        data = null,
        quantidade = 0;
}


class _HeaderData extends StatelessWidget {
  final DateTime data;
  final int quantidade;

  const _HeaderData({required this.data, required this.quantidade});

  @override
  Widget build(BuildContext context) {

    final formatter = DateFormat("EEEE, d 'de' MMMM 'de' y", 'pt_BR');
    final textoFormatado = formatter.format(data);

    final texto =
        '${textoFormatado[0].toUpperCase()}${textoFormatado.substring(1)}';

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Data por extenso
          Text(
            texto,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Contagem de eventos naquele dia
          Text(
            '$quantidade processo${quantidade > 1 ? "s" : ""}',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text(
              'Nenhum processo pendente',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              'Não há processos agendados a partir de hoje.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
