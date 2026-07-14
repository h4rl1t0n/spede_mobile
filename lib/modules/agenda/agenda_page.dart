import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../mock/lembretes.dart';
import '../../mock/setores.dart';
import '../../models/setor_model.dart';
import 'widgets/calendario_item/calendario_item.dart';
import 'widgets/lembrete_item/header_lembrete.dart';
import 'widgets/lembrete_item/lembrete_item.dart';
import 'widgets/lembrete_item/nenhum_lembrete_container.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime mes = DateTime.now();
  DateTime data = DateTime.now();
  SetorModel? setorFiltrado;

  @override
  Widget build(BuildContext context) {
    final lembretesFiltrados = setorFiltrado == null
        ? lembretes
        : lembretes.where((e) => e.setorModel.id == setorFiltrado!.id).toList();

    final lista = lembretesFiltrados.where((evento) {
      return isSameDay(evento.data, data);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              setorFiltrado == null ? Icons.filter_alt_outlined : Icons.filter_alt,
              color: Colors.white,
            ),
            onPressed: () => _abrirFiltroSetor(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          spacing: 10,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 15, offset: const Offset(0, 5)),
                ],
              ),
              child: CalendarioItem(
                mes: mes,
                selectedDate: data,
                lembretesList: lembretesFiltrados,
                onMonthChanged: (novoMes) {
                  setState(() {
                    mes = novoMes;
                  });
                },
                onDateSelected: (novaData) {
                  setState(() {
                    data = novaData;
                  });
                },
              ),
            ),

            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    children: [
                      HeaderLembrete(data: data, quantidade: lista.length),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (lista.isEmpty) {
                              return const NenhumLembreteContainer();
                            }

                            return ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: lista.length,
                              separatorBuilder: (_, _) => const SizedBox(height: 12),
                              itemBuilder: (_, index) {
                                return LembreteItem(lembrete: lista[index]);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirFiltroSetor(BuildContext context) {
    showDialog<SetorModel?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filtrar Agenda por Setor'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Todos os Setores'),
                  trailing: setorFiltrado == null
                      ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () {
                    Navigator.pop(context, null);
                  },
                ),
                ...setores.map((setor) {
                  final isSelected = setorFiltrado?.id == setor.id;
                  return ListTile(
                    title: Text(setor.sigla),
                    subtitle: Text(setor.nome, style: const TextStyle(fontSize: 12)),
                    trailing: isSelected
                        ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                        : null,
                    onTap: () {
                      Navigator.pop(context, setor);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    ).then((selectedSetor) {
      if (selectedSetor != setorFiltrado) {
        setState(() {
          setorFiltrado = selectedSetor;
        });
      }
    });
  }
}
