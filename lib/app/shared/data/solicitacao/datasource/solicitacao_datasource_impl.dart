import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/custom_message_error.dart';
import '../../../../enum/tipo_caixa.dart';
import '../../../../enum/tipo_solicitacao.dart';
import '../../../../mock/documentos.dart';
import '../../../../models/documento_model.dart';
import '../../../../modules/main/pages/home/widgets/dashboard_item_card/dashboard_item_card.dart';
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

      // 3. Sucesso absoluto! Agrupamos os dados e retornamos nosso Modelo Bonitão
      final resumo = DashboardResumoModel(
        setoresRecebidos: _agruparPorSetor(recebidas),
        totalRecebidos: recebidas.length,
        setoresEnviados: _agruparPorSetor(enviadas),
        totalEnviados: enviadas.length,
      );

      return Success(resumo);
    } on DioException catch (err) {
      return Error(CustomMessageError.getMessage(err));
    }
  }

  List<DashboardSetor> _agruparPorSetor(List<DocumentoModel> documentos) {
    final contagemAgrupada = <String, Map<TipoSolicitacao, int>>{};

    for (var doc in documentos) {
      final sigla = doc.setorModel.sigla;
      final tipo = doc.tipoSolicitacao;

      contagemAgrupada.putIfAbsent(
        sigla,
        () => {TipoSolicitacao.assinatura: 0, TipoSolicitacao.ciencia: 0, TipoSolicitacao.visto: 0},
      );

      contagemAgrupada[sigla]![tipo] = (contagemAgrupada[sigla]![tipo] ?? 0) + 1;
    }

    return contagemAgrupada.entries.map((entry) {
      final contagens = entry.value;

      return DashboardSetor(
        nomeSetor: entry.key,
        dashboards: [
          DashboardItem(
            'Assinatura',
            contagens[TipoSolicitacao.assinatura].toString(),
            const Color(0xFFF44336),
          ), // Colors.red
          DashboardItem(
            'Ciência',
            contagens[TipoSolicitacao.ciencia].toString(),
            const Color(0xFFFF9800),
          ), // Colors.orange
          DashboardItem('Visto', contagens[TipoSolicitacao.visto].toString(), const Color(0xFF2196F3)), // Colors.blue
        ],
      );
    }).toList();
  }
}
