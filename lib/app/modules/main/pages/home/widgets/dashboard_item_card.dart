import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

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
  late final PageController controller;

  String get title => widget.title;
  String get value => widget.value;
  IconData get icon => widget.icon;
  Color get color => widget.color;
  List<DashboardSetor> get items => widget.items;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
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
                  Spacer(),
                  InkWell(onTap: () {}, child: Icon(Icons.tune_rounded)),
                ],
              ),
              ExpandablePageView.builder(
                controller: controller,
                clipBehavior: Clip.hardEdge,
                padEnds: false,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final dashboard = items[index];
                  final dashboards = dashboard.dashboards ?? [];
                  final total = dashboards
                      .map((e) => int.parse(e.value.replaceAll('.', '')))
                      .fold(0, (soma, valor) => soma + valor);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.5),
                      Row(
                        spacing: 5,
                        children: [
                          Text(dashboard.nomeSetor.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('($total)', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      SizedBox(height: 2.5),
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
              ),
              SizedBox(height: 5),
              if (title != 'Eventos da Agenda')
                Row(
                  spacing: 5,
                  mainAxisAlignment: .center,
                  children: items.map((e) {
                    return Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                    );
                  }).toList(),
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
  final String nomeSetor;
  final List<DashboardItem>? dashboards;

  const DashboardSetor({required this.nomeSetor, this.dashboards});
}
