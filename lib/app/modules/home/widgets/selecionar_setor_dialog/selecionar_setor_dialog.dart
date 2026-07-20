import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/extensions/size_extension.dart';
import '../../../../core/ui/widgets/custom_dropdown_search/custom_dropdown_search.dart';
import '../../../../mock/setores.dart';
import '../../../../models/setor_model.dart';
import '../../home_controller.dart';

class SelecionarSetorDialog extends StatefulWidget {
  final HomeController controller;
  final bool initializer;
  const SelecionarSetorDialog({super.key, required this.controller, required this.initializer});

  @override
  State<SelecionarSetorDialog> createState() => _SelecionarSetorDialogState();
}

class _SelecionarSetorDialogState extends State<SelecionarSetorDialog> {
  HomeController get controller => widget.controller;
  bool get initializer => widget.initializer;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Selecione um Setor'),
      content: SizedBox(
        width: context.widthDialog,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Observer(
              builder: (context) {
                final setorSelecionado = controller.setorSelecionado;
                return CustomDropdownSearch<SetorModel>(
                  hintText: 'Selecione um setor',
                  initialValue: setorSelecionado,
                  items: setores,
                  title: (item) => item.sigla,
                  subtitle: (item) => item.nome,
                  onSelected: (item) {
                    controller.idSetorSelecionado = item?.id;
                  },
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        Visibility(
          visible: !initializer,
          child: TextButton(
            onPressed: () {
              if (mounted) Navigator.of(context).pop(false);
            },
            child: Text('Cancelar'),
          ),
        ),
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
    );
  }

  Future<void> selecionarSetor() async {
    final bool selecionou = await controller.salvarSetorSelecionado();

    if (selecionou && mounted) {
      Navigator.of(context).pop(true);
    }
  }
}
