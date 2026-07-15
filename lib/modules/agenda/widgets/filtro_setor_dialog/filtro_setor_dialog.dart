import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/extensions/size_extension.dart';
import '../../../../core/ui/widgets/custom_dropdown_search/custom_dropdown_search.dart';
import '../../../../mock/setores.dart';
import '../../../../models/setor_model.dart';
import '../../agenda_controller.dart';

class FiltroSetorDialog extends StatefulWidget {
  final AgendaController controller;
  const FiltroSetorDialog({super.key, required this.controller});

  @override
  State<FiltroSetorDialog> createState() => _FiltroSetorDialogState();
}

class _FiltroSetorDialogState extends State<FiltroSetorDialog> {
  AgendaController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtrar Por Setor'),
      insetPadding: EdgeInsets.all(15),
      content: SingleChildScrollView(
        child: SizedBox(
          width: context.widthDialog,
          child: Observer(
            builder: (context) {
              final setorFiltrado = controller.setorFiltrado;
              return CustomDropdownSearch<SetorModel>(
                hintText: 'Selecione um setor',
                initialValue: setorFiltrado,
                items: setores,
                itemString: (item) => item.sigla,
                onSelected: (item) {
                  controller.idSetorSelecionado = item?.id;
                },
                onClear: () {
                  Navigator.of(context).pop();
                  controller.limparSetor();
                },
              );
            },
          ),
        ),
      ),
      actions: [
        Row(
          spacing: 5,
          mainAxisAlignment: .end,
          children: [
            Flexible(child: SizedBox.shrink()),
            Flexible(
              child: Observer(
                builder: (context) {
                  final idSetorSelecionado = controller.idSetorSelecionado;
                  return ElevatedButton(
                    onPressed: idSetorSelecionado == null
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            controller.alterarSetor();
                          },
                    child: Text('Selecionar'),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
