import 'dart:ui';

import '../../enum/tipo_solicitacao.dart';

class DashboardItem {
  final TipoSolicitacao solicitacao;
  final int value;
  final Color color;

  const DashboardItem(this.solicitacao, this.value, this.color);
}
