import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/ui/theme/styles/text_styles.dart';
import '../dashboard_item_card/dashboard_item_card_store.dart';

class FiltroBottomSheet extends StatefulWidget {
  final DashboardItemCardStore store;
  final Color color;
  const FiltroBottomSheet({super.key, required this.store, required this.color});

  @override
  State<FiltroBottomSheet> createState() => _FiltroBottomSheetState();
}

class _FiltroBottomSheetState extends State<FiltroBottomSheet> {
  Color get color => widget.color;
  DashboardItemCardStore get store => widget.store;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: MediaQuery.of(context).padding.bottom),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scroll) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Filtrar Por',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cabin',
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                const Divider(indent: 20, endIndent: 20),
                const SizedBox(height: 4),

                Flexible(
                  child: Observer(
                    builder: (context) {
                      final setores = store.items.map((e) => e.setor).toList();

                      return ListView.builder(
                        controller: scroll,
                        shrinkWrap: true,
                        itemCount: 2 + setores.length,
                        itemBuilder: (context, index) {
                          String titulo = '';
                          String subtitulo = '';

                          if (index == 0) {
                            titulo = 'Todos (Detalhado)';
                            subtitulo = 'Exibe as solicitações separadas por setor';
                          } else if (index == 1) {
                            titulo = 'Todos (Visão Geral)';
                            subtitulo = 'Quantitativo total agrupado em um único card';
                          } else {
                            final setor = setores[index - 2];
                            titulo = setor.sigla;
                            subtitulo = setor.nome;
                          }

                          final isSelected = store.selectedFilter == titulo;

                          return ListTile(
                            dense: true,
                            leading: Icon(
                              isSelected ? Icons.check_circle : Icons.circle_outlined,
                              color: isSelected ? color : Colors.grey,
                            ),
                            title: Text(
                              titulo.toUpperCase(),
                              style: context.textStyles.textTitleItemList.copyWith(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? color : Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              subtitulo,
                              style: context.textStyles.textSubTitleItemList.copyWith(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? color.withValues(alpha: 0.8) : Colors.grey.shade600,
                              ),
                            ),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              store.setFilter(titulo);
                              Modular.to.pop();
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
