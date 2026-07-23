import 'package:mobx/mobx.dart';

part 'decidir_solicitacao_controller.g.dart';

class DecidirSolicitacaoController = DecidirSolicitacaoControllerBase with _$DecidirSolicitacaoController;

abstract class DecidirSolicitacaoControllerBase with Store {
  @observable
  bool obscureText = true;

  @action
  void togglePassword() => obscureText = !obscureText;

  @observable
  String usuario = '';

  @observable
  String senha = '';

  @observable
  String? motivo;

  @observable
  String observacao = '';

  @action
  void setUsuario(String valor) => usuario = valor;

  @action
  void setSenha(String valor) => senha = valor;

  @action
  void setMotivo(String? valor) => motivo = valor;

  @action
  void setObservacao(String valor) => observacao = valor;
}
