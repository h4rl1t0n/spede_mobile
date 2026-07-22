import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../models/setor_model.dart';
import 'dashboard_item_card_store.dart';

class DashboardCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final List<DashboardSetor> items;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.items,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  late final DashboardItemCardStore store;
  late final PageController controller;

  String get title => widget.title;
  String get value => widget.value;
  IconData get icon => widget.icon;
  Color get color => widget.color;
  List<DashboardSetor> get items => widget.items;

  @override
  void initState() {
    super.initState();
    store = Modular.get<DashboardItemCardStore>();
    store.items.addAll(items);
    controller = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _abrirModalFiltro() {
    final listaSetores = items.map((e) => e.setor).toList();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Filtrar por Setor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const Divider(height: 1),
              // Usei Flexible ao invés de Expanded para evitar crash de layout em BottomSheets com MainAxisSize.min
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  // O tamanho é 2 (os itens "Todos") + a quantidade de setores
                  itemCount: 2 + listaSetores.length,
                  itemBuilder: (context, index) {
                    String tituloFiltro;
                    String? subtitulo;

                    // 2. Definimos as opções fixas vs setores
                    if (index == 0) {
                      tituloFiltro = 'Todos (Detalhado)';
                    } else if (index == 1) {
                      tituloFiltro = 'Todos (Visão Geral)';
                    } else {
                      // Subtraímos 2 do index para pegar o setor correto na lista
                      final setor = listaSetores[index - 2];
                      tituloFiltro = setor.sigla;
                      subtitulo = setor.nome; // Adicionamos o nome completo aqui
                    }

                    final isSelected = store.selectedFilter == tituloFiltro;

                    return ListTile(
                      dense: true,
                      title: Text(
                        tituloFiltro.toUpperCase(),
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? color : Colors.black87,
                        ),
                      ),

                      subtitle: subtitulo != null
                          ? Text(
                              subtitulo,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? color.withValues(alpha: 0.8) : Colors.grey.shade600,
                              ),
                            )
                          : null,
                      trailing: isSelected ? Icon(Icons.check_circle, color: color) : null,
                      onTap: () {
                        store.setFilter(tituloFiltro);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 15,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: color.withValues(alpha: .12),
                        child: Icon(icon, color: color, size: 25),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 12, letterSpacing: 1),
                      ),
                      Text(
                        value,
                        style: TextStyle(color: color, fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Ícone do Filtro
                  if (items.isNotEmpty && title != 'Eventos da Agenda')
                    InkWell(
                      onTap: _abrirModalFiltro,
                      borderRadius: BorderRadius.circular(50),
                      child: Observer(
                        builder: (_) => Icon(
                          Icons.tune_rounded,

                          color: store.selectedFilter != 'Todos (Detalhado)' ? color : Colors.grey.shade700,
                        ),
                      ),
                    ),
                ],
              ),

              Observer(
                builder: (context) {
                  final listToShow = store.itensFiltrados;

                  if (listToShow.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: Text('Nenhum dado encontrado')),
                    );
                  }

                  return ExpandablePageView.builder(
                    controller: controller,
                    clipBehavior: Clip.hardEdge,
                    padEnds: false,
                    itemCount: listToShow.length,
                    onPageChanged: store.setCurrentPage,
                    itemBuilder: (context, index) {
                      final dashboard = listToShow[index];
                      final dashboards = dashboard.dashboards ?? [];
                      final total = dashboards
                          .map((e) => int.parse(e.value.replaceAll('.', '')))
                          .fold(0, (soma, valor) => soma + valor);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2.5),
                          Row(
                            spacing: 5,
                            children: [
                              Text(
                                dashboard.setor.sigla.toUpperCase(),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('($total)', style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 2.5),
                          ...dashboards.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(color: e.color, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(e.title, style: const TextStyle(fontSize: 13))),
                                  Text(e.value, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 5),

              Observer(
                builder: (context) {
                  final listToShow = store.itensFiltrados;

                  // Oculta os pontos (dots) se houver apenas 1 página (Ex: Todos Geral ou Setor Específico)
                  if (title == 'Eventos da Agenda' || listToShow.length <= 1) {
                    return const SizedBox.shrink();
                  }

                  return Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(listToShow.length, (index) {
                      final currentPage = store.currentPage;
                      final isActive = currentPage == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: isActive ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive ? color : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final String value;
  final Color color;

  const DashboardItem(this.title, this.value, this.color);
}

class DashboardSetor {
  final SetorModel setor;
  final List<DashboardItem>? dashboards;

  const DashboardSetor({required this.setor, this.dashboards});
}
