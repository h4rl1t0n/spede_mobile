import 'package:mobx/mobx.dart';

import '../../mock/documentos.dart';
import '../../models/documento_model.dart';
import '../../models/setor_model.dart';

part 'solicitacao_controller.g.dart';

class SolicitacaoController = SolicitacaoControllerBase with _$SolicitacaoController;

abstract class SolicitacaoControllerBase with Store {
  @observable
  var listDocumentos = ObservableList.of(documentos);

  @observable
  SetorModel? setorSelecionado;

  @observable
  String? categoriaSelecionada;

  @action
  void alterarCategoria(String? value) {
    categoriaSelecionada = value;
  }

  @computed
  List<DocumentoModel> get documentosFiltrados {
    return setorSelecionado == null
        ? listDocumentos
        : listDocumentos.where((doc) => doc.setorModel.id == setorSelecionado?.id).toList();
  }

  @computed
  Map<String, int> get contarCategorias {
    final mapa = <String, int>{};

    for (final documento in documentosFiltrados) {
      mapa[documento.tipoSolicitacao.name] = (mapa[documento.tipoSolicitacao.name] ?? 0) + 1;
    }
    return mapa;
  }

  @computed
  List<DocumentoModel> get filtrarPorCategoria {
    if (categoriaSelecionada == null) return documentosFiltrados;
    return documentosFiltrados.where((e) => e.tipoSolicitacao.name == categoriaSelecionada).toList();
  }
}
