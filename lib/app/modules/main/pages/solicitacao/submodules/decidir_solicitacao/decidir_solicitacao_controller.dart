import 'package:mobx/mobx.dart';

import '../../../../../../enum/page_status.dart';

part 'decidir_solicitacao_controller.g.dart';

class DecidirSolicitacaoController = DecidirSolicitacaoControllerBase with _$DecidirSolicitacaoController;

abstract class DecidirSolicitacaoControllerBase with Store {
  @observable
  var status = PageStatus.initial;

  @observable
  String? errorMessage;

  @observable
  bool obscureText = true;

  @observable
  String senha = '';

  @observable
  String? motivo;

  @observable
  String observacao = '';

  @action
  void togglePassword() => obscureText = !obscureText;

  @action
  void setSenha(String valor) => senha = valor;

  @action
  void setMotivo(String? valor) => motivo = valor;

  @action
  void setObservacao(String valor) => observacao = valor;
}
