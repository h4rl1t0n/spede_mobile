import '../../../models/documento_model.dart';

class SolicitacaoHelper {
  static Map<String, int> contarCategorias(List<DocumentoModel> lista) {
    final mapa = <String, int>{};

    for (final documento in lista) {
      mapa[documento.tipoSolicitacao.name] = (mapa[documento.tipoSolicitacao.name] ?? 0) + 1;
    }
    return mapa;
  }

  static List<DocumentoModel> filtrarPorCategoria(List<DocumentoModel> lista, String? categoria) {
    if (categoria == null) return lista;

    return lista.where((e) => e.tipoSolicitacao.name == categoria).toList();
  }
}
