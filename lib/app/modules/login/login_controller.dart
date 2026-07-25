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
  var auth = AuthRequestDto(login: '', senha: '');

  @observable
  bool saveData = false;

  @observable
  bool existeDados = false;

  @observable
  bool obscureText = true;

  LoginControllerBase(this.service);

  @action
  Future<void> initLogin() async {
    final login = await LocalStorageUtils.getLogin();
    final senha = await LocalStorageUtils.getSenha();

    if (login.isNotEmpty && senha.isNotEmpty) {
      setAuth(login: login, senha: senha);
      setExisteDados(true);
      saveData = true;
    }
  }

  @action
  Future<bool> login() async {
    bool result = false;
    _errorMessage = null;
    _status = PageStatus.loading;

    await fetch(
      service.login(auth: auth),
      onSuccess: (value) async {
        result = value;
        await LocalStorageUtils.saveDataLogin(auth: auth, saveData: saveData);
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
  void setAuth({String? login, String? senha}) {
    auth = auth.setAuth(login: login, senha: senha);
  }

  @action
  void setExisteDados(bool value) => existeDados = value;

  @action
  void setSaveData(bool value) => saveData = value;

  @action
  void changeObscureText() => obscureText = !obscureText;

  @computed
  bool get showManterDados => [auth.login, auth.senha].every((value) => value.isNotEmpty);
}
