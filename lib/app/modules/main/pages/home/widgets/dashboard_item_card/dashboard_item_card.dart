import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../models/dashboard/dashboard_setor.dart';
import '../filtro_bottom_sheet/filtro_bottom_sheet.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
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
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(color: color, fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),

                InkWell(
                  onTap: showFiltroBottomSheet,
                  borderRadius: BorderRadius.circular(50),
                  child: Observer(
                    builder: (_) {
                      return Icon(
                        Icons.tune_rounded,
                        color: store.selectedFilter != 'Todos (Detalhado)' ? color : Colors.grey.shade700,
                      );
                    },
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
                    final total = dashboards.map((e) => e.value).fold(0, (soma, valor) => soma + valor);

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
                                Expanded(child: Text(e.solicitacao.name, style: const TextStyle(fontSize: 13))),
                                Text(e.value.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        color: isActive ? color : Colors.grey.shade400,
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
    );
  }

  Future<void> showFiltroBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return FiltroBottomSheet(store: store, color: color);
      },
    );
  }
}
