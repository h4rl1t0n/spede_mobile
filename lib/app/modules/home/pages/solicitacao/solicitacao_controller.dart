import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/result/result_handler.dart';
import '../../../../enum/acao_solicitacao.dart';
import '../../../../enum/page_status.dart';
import '../../../../enum/tipo_caixa.dart';
import '../../../../enum/tipo_solicitacao.dart';
import '../../../../models/documento_model.dart';
import '../../../../shared/service/solicitacao/solicitacao_service.dart';
import '../../home_controller.dart';

part 'solicitacao_controller.g.dart';

class SolicitacaoController = SolicitacaoControllerBase with _$SolicitacaoController;

abstract class SolicitacaoControllerBase with Store {
  final SolicitacaoService service;

  @observable
  AcaoSolicitacao? acao;

  @observable
  var status = PageStatus.initial;

  @observable
  var solicitacoes = ObservableList<DocumentoModel>();

  @observable
  var selecionados = ObservableList<DocumentoModel>();

  @observable
  String? errorMessage;

  @observable
  TipoSolicitacao? categoriaSelecionada;

  SolicitacaoControllerBase(this.service);

  @action
  Future<void> carregarSolicitacoes(TipoCaixa caixa) async {
    errorMessage = null;
    status = PageStatus.loading;

    await fetch(
      service.carregarTodasSolicitacoes(tipoCaixa: caixa),
      onSuccess: (result) {
        solicitacoes.clear();
        solicitacoes.addAll(result);

        final homeController = Modular.get<HomeController>();
        if (caixa == .enviadas) {
          homeController.qtdEnviadas = result.length;
        }
        if (caixa == .recebidas) {
          homeController.qtdRecebidas = result.length;
        }

        status = PageStatus.loaded;
      },
      onError: (message) {
        status = PageStatus.error;
        errorMessage = message;
      },
    );
  }

  @action
  void alterarCategoria(TipoSolicitacao? value) {
    categoriaSelecionada = value;
  }

  @computed
  bool get modoSelecao => selecionados.isNotEmpty;

  @computed
  Map<TipoSolicitacao, int> get contarCategorias {
    final mapa = {for (final tipo in TipoSolicitacao.values) tipo: 0};

    for (final documento in solicitacoes) {
      mapa.update(documento.tipoSolicitacao, (valor) => valor + 1);
    }

    return mapa;
  }

  @computed
  List<DocumentoModel> get filtrarPorCategoria {
    if (categoriaSelecionada == null) return solicitacoes;
    return solicitacoes.where((e) => e.tipoSolicitacao == categoriaSelecionada).toList();
  }
}
