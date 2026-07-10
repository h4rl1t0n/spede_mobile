import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../models/documento_model.dart';
import 'widgets/item_solicitacao_rejeitado_card.dart';
import 'widgets/secao_header.dart';

class RejeitarSolicitacao extends StatefulWidget {
  final List<DocumentoModel> solicitacoes;

  const RejeitarSolicitacao({super.key, required this.solicitacoes});

  @override
  State<RejeitarSolicitacao> createState() => _RejeitarSolicitacaoState();
}

class _RejeitarSolicitacaoState extends State<RejeitarSolicitacao> {
  final _formKey = GlobalKey<FormState>();
  final _observacaoController = TextEditingController();
  final _motivoController = TextEditingController();

  final List<String> _motivos = [
    'Ausência de Informação',
    'Devolução',
    'Inobservância do Modelo Padrão',
    'Solicitação indevida',
  ];

  @override
  void dispose() {
    _observacaoController.dispose();
    _motivoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Rejeitar Solicitações')),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
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
                        controller: _motivoController,
                        width: MediaQuery.of(context).size.width - 32,
                        hintText: 'Selecione...',
                        enableSearch: true,
                        enableFilter: true,
                        dropdownMenuEntries: _motivos.map((motivo) {
                          return DropdownMenuEntry<String>(value: motivo, label: motivo);
                        }).toList(),
                        onSelected: (String? value) {
                          setState(() {});
                        },
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
                        controller: _observacaoController,
                        maxLines: 4,
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

                SecaoHeader(title: 'Solicitações Selecionados'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: widget.solicitacoes.map((doc) {
                      return ItemSolicitacaoRejeitadoCard(solicitacao: doc);
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: FilledButton(onPressed: _rejeitar, child: const Text('Rejeitar')),
                      ),
                      Expanded(
                        child: FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Voltar')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _rejeitar() {
    if (_motivoController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Por favor, selecione um motivo.'), backgroundColor: Colors.red));
      return;
    }

    if (_formKey.currentState!.validate()) {
      log('Motivo: ${_motivoController.text}');
      log('Observação: ${_observacaoController.text}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Solicitação rejeitada com sucesso!')));
    }
  }
}
