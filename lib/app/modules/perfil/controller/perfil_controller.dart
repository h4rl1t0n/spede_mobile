import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../core/global/local_storage_utils.dart';
import '../../../mock/setores.dart';
import '../../../models/setor_model.dart';
import '../../../models/usuario_model.dart';

part 'perfil_controller.g.dart';

class PerfilController = PerfilControllerBase with _$PerfilController;

abstract class PerfilControllerBase with Store {
  @observable
  SetorModel? setorSelecionado;

  @observable
  UsuarioModel? usuario;

  @observable
  int? idSetorSelecionado;

  @action
  Future<void> initController() async {
    await carregarSetor();
  }

  @action
  Future<bool> salvarSetorSelecionado() async {
    final int idSetor = idSetorSelecionado ?? setorSelecionado?.id ?? -1;
    setorSelecionado = setores.firstWhereOrNull((element) => element.id == idSetor);
    await LocalStorageUtils.salvarSetor(setor: setorSelecionado);
    return true;
  }

  @action
  Future<void> carregarSetor() async {
    setorSelecionado = await LocalStorageUtils.carregarSetorSelecionado();
    idSetorSelecionado = setorSelecionado?.id;
  }
}
