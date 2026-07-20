// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../models/documento_model.dart';

class SolicitacoesResponse {
  final List<DocumentoModel> enviadas;
  final List<DocumentoModel> recebidas;

  int get total => enviadas.length + recebidas.length;

  const SolicitacoesResponse({required this.enviadas, required this.recebidas});

  SolicitacoesResponse copyWith({List<DocumentoModel>? enviadas, List<DocumentoModel>? recebidas}) {
    return SolicitacoesResponse(enviadas: enviadas ?? this.enviadas, recebidas: recebidas ?? this.recebidas);
  }
}
