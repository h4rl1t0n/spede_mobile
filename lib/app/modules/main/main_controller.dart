import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../core/global/local_storage_utils.dart';
import '../../models/setor_model.dart';
import '../../models/usuario_model.dart' show UsuarioModel;

part 'main_controller.g.dart';

class MainController = MainControllerBase with _$MainController;

abstract class MainControllerBase with Store {
  List<SetorModel> listaDeSetores = [];

  @observable
  SetorModel? setorSelecionado;

  @observable
  UsuarioModel? usuario;

  @observable
  int? idSetorSelecionado;

  @observable
  int currentPage = 0;

  @action
  Future<void> initController() async {
    await carregarSetor();
  }

  @action
  void setPage(int page) {
    currentPage = page;
  }

  @action
  Future<bool> salvarSetorSelecionado() async {
    final int idSetor = idSetorSelecionado ?? setorSelecionado?.id ?? -1;
    setorSelecionado = listaDeSetores.firstWhereOrNull((element) => element.id == idSetor);
    await LocalStorageUtils.salvarSetor(setor: setorSelecionado);
    return true;
  }

  @action
  Future<void> carregarSetor() async {
    setorSelecionado = await LocalStorageUtils.carregarSetorSelecionado();
    idSetorSelecionado = setorSelecionado?.id;
  }
}
