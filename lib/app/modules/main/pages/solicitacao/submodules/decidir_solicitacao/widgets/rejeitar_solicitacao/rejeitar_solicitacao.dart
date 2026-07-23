import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../../../core/ui/widgets/custom_dropdown_search/custom_dropdown_search.dart';
import '../../../../../../../../mock/motivos_rejeicao.dart';
import '../../decidir_solicitacao_controller.dart';
import '../required_label.dart';
import '../secao_header.dart';

class RejeitarSolicitacao extends StatelessWidget {
  final DecidirSolicitacaoController controller;
  const RejeitarSolicitacao({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SecaoHeader(title: 'Informações da Rejeição'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RequiredLabel(label: 'Motivo:'),
              const SizedBox(height: 8),

              Observer(
                builder: (_) {
                  return CustomDropdownSearch<String>(
                    label: 'Selecione um motivo',
                    titleDialog: 'Selecione um motivo',
                    selectedItem: controller.motivo,
                    items: motivos,
                    title: (item) => item,
                    onSelected: controller.setMotivo,
                  );
                },
              ),

              const SizedBox(height: 20),

              const RequiredLabel(label: 'Observação:'),
              const SizedBox(height: 8),

              Observer(
                builder: (_) {
                  return TextFormField(
                    initialValue: controller.observacao,
                    onChanged: controller.setObservacao,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Digite a observação...',
                      alignLabelWithHint: true,
                      errorText: controller.observacaoErro,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
