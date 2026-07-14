import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  @observable
  bool obscureText = true;

  @action
  void changeObscureText() {
    obscureText = !obscureText;
  }
}
