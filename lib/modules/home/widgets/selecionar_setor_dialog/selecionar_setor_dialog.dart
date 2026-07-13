import 'package:flutter/material.dart';

import '../../../../core/extensions/size_extension.dart';
import '../../../../core/ui/theme/styles/text_styles.dart';
import '../../../../core/ui/widgets/custom_dropdown_search/custom_dropdown_search.dart';
import '../../../../mock/setores.dart';
import '../../../../models/setores_model.dart';

class SelecionarSetorDialog extends StatefulWidget {
  const SelecionarSetorDialog({super.key});

  @override
  State<SelecionarSetorDialog> createState() => _SelecionarSetorDialogState();
}

class _SelecionarSetorDialogState extends State<SelecionarSetorDialog> {
  String nomeSetor = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(15),
      title: Text('Selecione um Setor'),
      content: SizedBox(
        width: context.widthDialog,
        child: CustomDropdownSearch<SetoresModel>(
          hintText: 'Selecione um setor',
          items: setores,
          itemString: (item) => item.sigla,
          onSelected: (item) => setState(() {
            nomeSetor = item?.sigla ?? 'Setin';
          }),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: nomeSetor.isEmpty
              ? null
              : () {
                  Navigator.of(context).pop(nomeSetor);
                },
          child: Text('Selecionar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar', style: context.textStyles.textSecondaryButtonLabel),
        ),
      ],
    );
  }
}
