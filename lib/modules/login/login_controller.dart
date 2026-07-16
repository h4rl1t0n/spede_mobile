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

  @readonly
  String? _successMessage;

  @observable
  String login = '';

  @observable
  String senha = '';

  @observable
  bool obscureText = true;

  LoginControllerBase(this.service);

  @action
  Future<bool> auth() async {
    bool result = false;
    _errorMessage = null;
    _status = PageStatus.loading;

    final auth = AuthRequestDto(login: login, senha: senha);

    await fetch(
      service.login(auth: auth),
      onSuccess: (username) async {
        result = true;
        await _saveTokens(username);
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
  void changeObscureText() {
    obscureText = !obscureText;
  }

  Future<void> _saveTokens(String username) async {
    await LocalStorageUtils.setValue(SessionStorageKeys.username.key, username);
  }
}
