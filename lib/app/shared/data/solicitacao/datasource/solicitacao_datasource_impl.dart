import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/custom_message_error.dart';
import '../../../../enum/tipo_caixa.dart';
import '../../../../enum/tipo_solicitacao.dart';
import '../../../../mock/documentos.dart';
import '../../../../models/dashboard/dashboard_item.dart';
import '../../../../models/dashboard/dashboard_setor.dart';
import '../../../../models/documento_model.dart';
import '../dto/dashboard_resumo_model.dart';
import 'solicitacao_datasource.dart';

class SolicitacaoDatasourceImpl extends SolicitacaoDatasource {
  @override
  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa caixa}) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final lista = documentos.where((e) => e.tipoCaixa == caixa).toList();
      return Success(lista);
    } on DioException catch (err) {
      return Error(CustomMessageError.getMessage(err));
    }
  }

  @override
  Future<Result<DashboardResumoModel, Failure>> carregarResumoDashboard() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final recebidas = documentos.where((e) => e.tipoCaixa == .recebidas).toList();
      final enviadas = documentos.where((e) => e.tipoCaixa == .enviadas).toList();

      final resumo = DashboardResumoModel(
        setoresRecebidos: agruparPorSetor(recebidas),
        setoresEnviados: agruparPorSetor(enviadas),
        totalRecebidos: recebidas.length,
        totalEnviados: enviadas.length,
      );

      return Success(resumo);
    } on DioException catch (err) {
      return Error(CustomMessageError.getMessage(err));
    }
  }

  List<DashboardSetor> agruparPorSetor(List<DocumentoModel> documentos) {
    final group = groupBy(documentos, (doc) => doc.setor.sigla);

    return group.entries.map((entry) {
      final solicitacoes = entry.value;
      final setor = solicitacoes.first.setor;
      int contar(TipoSolicitacao tipo) {
        return solicitacoes.where((doc) => doc.tipoSolicitacao == tipo).length;
      }

      return DashboardSetor(
        setor: setor,
        dashboards: [
          DashboardItem(TipoSolicitacao.assinatura, contar(TipoSolicitacao.assinatura), const Color(0xFFF44336)),
          DashboardItem(TipoSolicitacao.ciencia, contar(TipoSolicitacao.ciencia), const Color(0xFFFF9800)),
          DashboardItem(TipoSolicitacao.visto, contar(TipoSolicitacao.visto), const Color(0xFF2196F3)),
        ],
      );
    }).toList();
  }
}
