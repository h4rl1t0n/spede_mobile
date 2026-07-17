import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/extensions/size_extension.dart';
import '../../../../core/ui/widgets/custom_dropdown_search/custom_dropdown_search.dart';
import '../../../../mock/setores.dart';
import '../../../../models/setor_model.dart';
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
        title: Text('Selecione um Setor'),
        content: SizedBox(
          width: context.widthDialog,
          child: Observer(
            builder: (context) {
              final setorSelecionado = controller.setorSelecionado;
              return CustomDropdownSearch<SetorModel>(
                hintText: 'Selecione um setor',
                initialValue: setorSelecionado,
                items: setores,
                itemString: (item) => item.sigla,
                onSelected: (item) {
                  controller.idSetorSelecionado = item?.id;
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () {}, child: Text('data')),
          Observer(
            builder: (context) {
              final idSetorSelecionado = controller.idSetorSelecionado;
              return ElevatedButton(
                onPressed: idSetorSelecionado == null ? null : selecionarSetor,
                child: Text('Selecionar'),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> selecionarSetor() async {
    final bool selecionou = await controller.salvarSetorSelecionado();

    if (selecionou && mounted) {
      Navigator.of(context).pop(true);
    }
  }
}
