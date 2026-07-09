import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../mock/mock.dart';
import '../../../models/documento_model.dart';
import 'widget/filtro_categorias.dart';
import 'widget/item_solicitacao.dart';

class SolicitacaoPage extends StatefulWidget {
  final String title;
  const SolicitacaoPage({super.key, required this.title});

  @override
  State<SolicitacaoPage> createState() => _SolicitacaoPageState();
}

class _SolicitacaoPageState extends State<SolicitacaoPage> {
  String? _categoriaSelecionada;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final eventosFuturos = documentos;

    // Contagem de categorias (sempre sobre todos os eventos, não os filtrados)
    final contagemCategorias = _contarCategorias(eventosFuturos);

    // Filtra por categoria selecionada
    final eventosFiltrados = _filtrarPorCategoria(eventosFuturos, _categoriaSelecionada);

    final agrupados = _agruparPorData(eventosFiltrados);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título fixo: "Caixa de Entrada"
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            spacing: 5,
            children: [
              Icon(
                widget.title.contains('Pessoal') ? Icons.person : Icons.business_center,
                color: cs.primary,
                size: 20,
              ),
              Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        // Barra de filtros por categoria (chips horizontais)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FiltroCategorias(
            categorias: contagemCategorias,
            selecionada: _categoriaSelecionada,
            onSelecionada: (categoria) {
              setState(() => _categoriaSelecionada = categoria);
            },
          ),
        ),

        const Divider(height: 1),

        // Lista de processos agrupados por data (scrollável)
        Expanded(child: agrupados.isEmpty ? const _EmptyState() : _buildListaProcessos(agrupados)),
      ],
    );
  }

  /// Monta o ListView.builder com headers de data e cards de processo.
  Widget _buildListaProcessos(Map<DateTime, List<DocumentoModel>> agrupados) {
    final itensFlat = <_ListItem>[];

    for (final entry in agrupados.entries) {
      itensFlat.add(_ListItem.header(entry.key, entry.value.length));

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
          return _HeaderData(data: item.data!, quantidade: item.quantidade);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ItemSolicitacao(item: item.evento!),
        );
      },
    );
  }

  /// Conta quantos processos existem por categoria.
  Map<String, int> _contarCategorias(List<DocumentoModel> lista) {
    final mapa = <String, int>{};
    for (final e in lista) {
      mapa[e.tipoSolicitacao.name] = (mapa[e.tipoSolicitacao.name] ?? 0) + 1;
    }
    return mapa;
  }

  /// Filtra a lista por categoria. Se `categoria` for null, retorna todos.
  List<DocumentoModel> _filtrarPorCategoria(List<DocumentoModel> lista, String? categoria) {
    if (categoria == null) return lista;
    return lista.where((e) => e.tipoSolicitacao.name == categoria).toList();
  }


  Map<DateTime, List<DocumentoModel>> _agruparPorData(List<DocumentoModel> lista) {
    final map = <DateTime, List<DocumentoModel>>{};

    for (final evento in lista) {
      // Chave normalizada: apenas ano/mês/dia (sem hora/minuto/segundo)
      final chave = DateTime(evento.dataSolicitacao.year, evento.dataSolicitacao.month, evento.dataSolicitacao.day);
      map.putIfAbsent(chave, () => []).add(evento);
    }

    // Ordena as chaves cronologicamente (mais próximo primeiro)
    return Map.fromEntries(map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }
}


class _ListItem {
  final bool isHeader;
  final DateTime? data;
  final int quantidade;
  final DocumentoModel? evento;

  // Construtor para header de seção
  _ListItem.header(this.data, this.quantidade) : isHeader = true, evento = null;

  // Construtor para card de processo
  _ListItem.card(this.evento) : isHeader = false, data = null, quantidade = 0;
}

class _HeaderData extends StatelessWidget {
  final DateTime data;
  final int quantidade;

  const _HeaderData({required this.data, required this.quantidade});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("EEEE, d 'de' MMMM 'de' y", 'pt_BR');
    final textoFormatado = formatter.format(data);

    final texto = '${textoFormatado[0].toUpperCase()}${textoFormatado.substring(1)}';

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Data por extenso
          Text(texto, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),

          // Contagem de eventos naquele dia
          Text(
            '$quantidade processo${quantidade > 1 ? "s" : ""}',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
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
            const Text('Nenhum processo pendente', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
