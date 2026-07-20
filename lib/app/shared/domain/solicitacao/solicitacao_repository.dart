import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../../enum/tipo_caixa.dart';
import '../../../models/documento_model.dart';

abstract class SolicitacaoRepository {
  Future<Result<List<DocumentoModel>, Failure>> carregarTodasSolicitacoes({required TipoCaixa tipoCaixa});
}
