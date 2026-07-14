import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../core/global/local_storage_utils.dart';
import '../../mock/setores.dart';
import '../../models/setor_model.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  List<SetorModel> listaDeSetores = [...setores];

  @observable
  SetorModel? setorSelecionado;

  @observable
  int? idSetorSelecionado;

  @action
  Future<void> initController() async {
    setorSelecionado = await LocalStorageUtils.carregarSetorSelecionado();
  }

  @action
  Future<bool> salvarSetorSelecionado() async {
    final int filter = idSetorSelecionado ?? setorSelecionado?.id ?? -1;
    setorSelecionado = listaDeSetores.firstWhereOrNull((element) => element.id == filter);
    await LocalStorageUtils.salvarSetor(setor: setorSelecionado);
    return true;
  }
}
