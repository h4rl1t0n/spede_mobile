import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

// Certifique-se de ajustar os imports abaixo conforme o caminho real no seu projeto
import '../../../../../../core/constants/images.dart';
import '../../../../../../core/extensions/string_extension.dart';
import '../../../../../../core/global/local_storage_utils.dart';
import '../../../../../../core/helpers/loader.dart';
import '../../../../../../core/helpers/messages.dart';
import '../../../../../../core/ui/theme/styles/button_styles.dart';
import '../../../../../../core/ui/widgets/custom_dropdown_search/custom_dropdown_search.dart';
import '../../../../../../enum/acao_solicitacao.dart';
import '../../../../../../enum/tipo_solicitacao.dart';
import '../../../../../../mock/motivos_rejeicao.dart';
import '../../../../../../models/documento_model.dart';
import 'decidir_solicitacao_controller.dart';
import 'widgets/item_solicitacao_decidir_card.dart';
import 'widgets/required_label.dart';
import 'widgets/secao_header.dart';

class DecidirSolicitacaoPage extends StatefulWidget {
  final AcaoSolicitacao acao;
  final List<DocumentoModel> selecionados;

  const DecidirSolicitacaoPage({super.key, required this.acao, required this.selecionados});

  @override
  State<DecidirSolicitacaoPage> createState() => _DecidirSolicitacaoPageState();
}

class _DecidirSolicitacaoPageState extends State<DecidirSolicitacaoPage> with Loader, Messages {
  final controller = Modular.get<DecidirSolicitacaoController>();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _usuarioTEC;
  late final TextEditingController _senhaTEC;
  late final TextEditingController _observacaoTEC;

  AcaoSolicitacao get acao => widget.acao;
  bool get rejeitar => acao == AcaoSolicitacao.rejeitar;
  TipoSolicitacao get solicitacao => selecionados.first.tipoSolicitacao;
  List<DocumentoModel> get selecionados => widget.selecionados;

  @override
  void initState() {
    super.initState();
    _usuarioTEC = TextEditingController();
    _senhaTEC = TextEditingController();
    _observacaoTEC = TextEditingController(text: controller.observacao);

    if (acao == AcaoSolicitacao.atender && solicitacao != TipoSolicitacao.ciencia) {
      WidgetsBinding.instance.addPostFrameCallback((_) async => _carregarUsuario());
    }
  }

  @override
  void dispose() {
    _usuarioTEC.dispose();
    _senhaTEC.dispose();
    _observacaoTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${rejeitar ? 'Rejeitar' : 'Atender'} '
            '${selecionados.length == 1 ? 'Solicitação' : 'Solicitações'}',
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Images.logoTCE), fit: BoxFit.cover),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFormularioAcao(),
                SecaoHeader(title: 'Solicitações Selecionadas | ${solicitacao.label}'),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: selecionados.length,
                    itemBuilder: (context, index) {
                      return ItemSolicitacaoDecidirCard(solicitacao: selecionados[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
          ),
          child: BottomAppBar(
            color: Colors.white,
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyles.instance.primary.copyWith(
                        backgroundColor: WidgetStatePropertyAll(Colors.grey.shade300),
                        foregroundColor: WidgetStatePropertyAll(Colors.grey.shade900),
                      ),
                      child: const Text('Voltar'),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyles.instance.primary.copyWith(
                        backgroundColor: WidgetStatePropertyAll(rejeitar ? colorScheme.error : colorScheme.secondary),
                      ),
                      onPressed: _executarAcaoPrincipal,
                      child: Text(acao.name.capitalize()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAtenderForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SecaoHeader(title: 'Assinatura'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RequiredLabel(label: 'Usuário'),
              const SizedBox(height: 8),
              TextFormField(
                enabled: false,
                controller: _usuarioTEC,
                onChanged: controller.setUsuario,
                decoration: const InputDecoration(hintText: 'Digite seu usuário'),
                validator: Validatorless.required('O usuário é obrigatório'),
              ),
              const SizedBox(height: 20),
              const RequiredLabel(label: 'Senha'),
              const SizedBox(height: 8),
              Observer(
                builder: (_) {
                  return TextFormField(
                    controller: _senhaTEC,
                    onChanged: controller.setSenha,
                    obscureText: controller.obscureText,
                    decoration: InputDecoration(
                      hintText: 'Digite sua senha',
                      suffixIcon: IconButton(
                        icon: Icon(controller.obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: controller.togglePassword,
                      ),
                    ),
                    validator: Validatorless.multiple([Validatorless.required('A senha é obrigatória')]),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRejeitarForm() {
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
                    validator: Validatorless.required('A observação é obrigatória para rejeição'),
                    items: motivos,
                    title: (item) => item,
                    onSelected: (value) => controller.setMotivo(value),
                  );
                },
              ),
              const SizedBox(height: 20),
              const RequiredLabel(label: 'Observação:'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _observacaoTEC,
                onChanged: controller.setObservacao,
                maxLines: 3,
                decoration: const InputDecoration(hintText: 'Digite a observação...', alignLabelWithHint: true),
                validator: Validatorless.required('A observação é obrigatória para rejeição'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormularioAcao() {
    if (rejeitar) {
      return _buildRejeitarForm();
    }

    if (acao == AcaoSolicitacao.atender && solicitacao != TipoSolicitacao.ciencia) {
      return _buildAtenderForm();
    }

    return const SizedBox.shrink();
  }

  Future<void> _carregarUsuario() async {
    final usuario = await LocalStorageUtils.getUsuario();
    _usuarioTEC.text = usuario.username;
    controller.setUsuario(usuario.username);
  }

  void _executarAcaoPrincipal() {
    FocusScope.of(context).unfocus();

    // Se for ciência e atendimento, não há inputs para validar
    if (acao == AcaoSolicitacao.atender && solicitacao == TipoSolicitacao.ciencia) {
      _darCiencia();
      return;
    }

    // Validação dos TextFormFields via Validatorless
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (isFormValid) {
      if (rejeitar) {
        _rejeitar();
      } else {
        _assinar();
      }
    }
  }

  void _assinar() {
    log('Usuário: ${_usuarioTEC.text}');
    log('Senha: ${_senhaTEC.text}');
    log('Assinando ${selecionados.length} solicitação(ões)');
    showSuccess('Solicitação assinada com sucesso!');
  }

  void _darCiencia() {
    log('Dando ciência em ${selecionados.length} solicitação(ões)');
    showSuccess('Ciência registrada com sucesso!');
  }

  void _rejeitar() {
    log('Motivo: ${controller.motivo}');
    log('Observação: ${_observacaoTEC.text}');
    log('Rejeitando ${selecionados.length} solicitação(ões)');
    showSuccess('Solicitação rejeitada com sucesso!');
  }
}
