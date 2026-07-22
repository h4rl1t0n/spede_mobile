import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../enum/tipo_caixa.dart';
import '../../../../models/documento_model.dart';
import '../dto/dashboard_resumo_model.dart';

abstract class SolicitacaoDatasource {
  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa caixa});
  Future<Result<DashboardResumoModel, Failure>> carregarResumoDashboard();
}
