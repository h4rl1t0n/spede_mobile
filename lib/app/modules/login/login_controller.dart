import 'package:mobx/mobx.dart';

import '../../core/global/local_storage_utils.dart';
import '../../core/result/result_handler.dart';
import '../../enum/page_status.dart';
import '../../shared/data/auth/dto/auth_request_dto.dart';
import '../../shared/service/auth/auth_service.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final AuthService service;

  @readonly
  var _status = PageStatus.initial;

  @readonly
  String? _errorMessage;

  @observable
  String login = '';

  @observable
  String senha = '';

  @observable
  bool manterDados = false;

  @observable
  bool existeDados = false;

  @observable
  bool obscureText = true;

  LoginControllerBase(this.service);

  Future<void> initLogin() async {
    final login = await LocalStorageUtils.getLogin();
    final senha = await LocalStorageUtils.getSenha();

    if (login.isNotEmpty && senha.isNotEmpty) {
      setLogin(login);
      setSenha(senha);
      setExisteDados(true);
      manterDados = true;
    }
  }

  @action
  Future<bool> auth() async {
    bool result = false;
    _errorMessage = null;
    _status = PageStatus.initial;

    final auth = AuthRequestDto(login: login, senha: senha);

    await fetch(
      service.login(auth: auth),
      onSuccess: (value) async {
        result = value;
        await LocalStorageUtils.saveDataLogin(auth: auth, saveData: manterDados);
        _status = PageStatus.loaded;
      },
      onError: (message) {
        result = false;
        _status = PageStatus.error;
        _errorMessage = message;
      },
    );

    return result;
  }

  @action
  void setExisteDados(bool value) => existeDados = value;

  @action
  void setManterDados(bool value) => manterDados = value;

  @action
  void setLogin(String value) => login = value;

  @action
  void setSenha(String value) => senha = value;

  @action
  void changeObscureText() => obscureText = !obscureText;

  @computed
  bool get showManterDados => login.isNotEmpty && senha.isNotEmpty;
}
