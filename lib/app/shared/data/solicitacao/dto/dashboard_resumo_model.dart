import '../../../../modules/main/pages/home/widgets/dashboard_item_card/dashboard_item_card.dart';

class DashboardResumoModel {
  final List<DashboardSetor> setoresRecebidos;
  final int totalRecebidos;

  final List<DashboardSetor> setoresEnviados;
  final int totalEnviados;

  const DashboardResumoModel({
    required this.setoresRecebidos,
    required this.totalRecebidos,
    required this.setoresEnviados,
    required this.totalEnviados,
  });
}
