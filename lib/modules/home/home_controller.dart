import 'package:mobx/mobx.dart';

import '../../models/setores_model.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @observable
  SetoresModel? setorSelecionado;

  @action
  void setSetor(SetoresModel? value) {
    setorSelecionado = value;
  }
}
