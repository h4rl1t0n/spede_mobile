import '../setor_model.dart';
import 'dashboard_item.dart';

class DashboardSetor {
  final SetorModel setor;
  final List<DashboardItem>? dashboards;

  const DashboardSetor({required this.setor, this.dashboards});
}