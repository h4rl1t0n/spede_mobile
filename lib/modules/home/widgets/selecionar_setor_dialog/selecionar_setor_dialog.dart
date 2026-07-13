import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/extensions/size_extension.dart';
import '../../../../core/ui/widgets/custom_dropdown_search/custom_dropdown_search.dart';
import '../../../../mock/setores.dart';
import '../../../../models/setores_model.dart';
import '../../home_controller.dart';

class SelecionarSetorDialog extends StatefulWidget {
  final HomeController controller;
  const SelecionarSetorDialog({super.key, required this.controller});

  @override
  State<SelecionarSetorDialog> createState() => _SelecionarSetorDialogState();
}

class _SelecionarSetorDialogState extends State<SelecionarSetorDialog> {
  HomeController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        insetPadding: EdgeInsets.all(15),
        title: Text('Selecione um Setor'),
        content: SizedBox(
          width: context.widthDialog,
          child: CustomDropdownSearch<SetoresModel>(
            hintText: 'Selecione um setor',
            items: setores,
            itemString: (item) => item.sigla,
            onSelected: (item) {
              controller.setSetor(item);
            },
          ),
        ),
        actions: [
          Observer(
            builder: (context) {
              final setor = controller.setorSelecionado;
              return Row(
                mainAxisAlignment: .end,
                children: [
                  Expanded(child: SizedBox.shrink()),
                  Expanded(
                    child: FilledButton(
                      onPressed: setor == null ? null : () => Navigator.of(context).pop(),
                      child: Text('Selecionar'),
                    ),
                  ),
                ],
              );
            },
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   child: Text('Cancelar', style: context.textStyles.textSecondaryButtonLabel),
          // ),
        ],
      ),
    );
  }
}
