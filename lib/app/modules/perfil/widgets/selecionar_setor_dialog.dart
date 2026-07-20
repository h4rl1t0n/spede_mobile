import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/extensions/size_extension.dart';
import '../../../core/ui/widgets/custom_dropdown_search/custom_dropdown_search.dart';
import '../../../mock/setores.dart';
import '../../../models/setor_model.dart';
import '../controller/perfil_controller.dart';

class SelecionarSetorDialog extends StatefulWidget {
  final PerfilController controller;
  const SelecionarSetorDialog({super.key, required this.controller});

  @override
  State<SelecionarSetorDialog> createState() => _SelecionarSetorDialogState();
}

class _SelecionarSetorDialogState extends State<SelecionarSetorDialog> {
  PerfilController get controller => widget.controller;

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
                  label: 'Selecione um setor',
                  title: 'Selecione um setor',
                  selectedItem: setorSelecionado,
                  items: setores,
                  itemAsString: (item) => item.sigla,
                  // subtitle: (item) => item.nome,
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
        TextButton(
          onPressed: () {
            if (mounted) Navigator.of(context).pop(false);
          },
          child: Text('Cancelar'),
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
