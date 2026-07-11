import 'package:flutter/material.dart';

import 'secao_header.dart';

class SecaoRejeicao extends StatelessWidget {
  final TextEditingController motivoController;
  final TextEditingController observacaoController;
  final List<String> motivos;
  final ValueChanged<String?>? onMotivoSelected;

  const SecaoRejeicao({
    super.key,
    required this.motivoController,
    required this.observacaoController,
    required this.motivos,
    this.onMotivoSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SecaoHeader(title: 'Informações da Rejeição'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Motivo:',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                  children: [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              DropdownMenu<String>(
                controller: motivoController,
                width: MediaQuery.of(context).size.width - 32,
                hintText: 'Selecione...',
                enableSearch: true,
                enableFilter: true,
                dropdownMenuEntries: motivos.map((motivo) {
                  return DropdownMenuEntry<String>(value: motivo, label: motivo);
                }).toList(),
                onSelected: onMotivoSelected,
              ),

              const SizedBox(height: 20),

              RichText(
                text: TextSpan(
                  text: 'Observação:',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                  children: [
                    TextSpan(
                      text: '*',
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: observacaoController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: 'Digite a observação...', alignLabelWithHint: true),
                validator: (value) {
                  final observacao = value ?? '';
                  if (observacao.trim().isEmpty) {
                    return 'A observação é obrigatória.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
