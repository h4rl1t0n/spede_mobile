import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../models/dashboard/dashboard_item.dart';
import '../../../../../../models/dashboard/dashboard_setor.dart';
import '../../../../../../models/setor_model.dart';

part 'dashboard_item_card_store.g.dart';

class DashboardItemCardStore = DashboardItemCardStoreBase with _$DashboardItemCardStore;

abstract class DashboardItemCardStoreBase with Store {
  @observable
  int currentPage = 0;

  @observable
  String selectedFilter = 'Todos (Detalhado)';

  @action
  void setCurrentPage(int value) {
    currentPage = value;
  }

  @action
  void setFilter(String value) {
    selectedFilter = value;
    currentPage = 0;
  }

  @observable
  var items = ObservableList<DashboardSetor>();

  @computed
  List<DashboardSetor> get itensFiltrados {
    final filtro = selectedFilter;

    if (filtro == 'Todos (Detalhado)') {
      return items;
    }

    if (filtro == 'Todos (Visão Geral)') {
      if (items.isEmpty) return [];

      final dashboards = items.expand((setor) => setor.dashboards ?? <DashboardItem>[]).toList();
      final group = groupBy(dashboards, (dash) => dash.solicitacao);

      final listaAgrupada = group.entries.map((entry) {
        final solicitacao = entry.key;
        final listaDashes = entry.value;
        final totalSomado = listaDashes.map((d) => d.value).sum;
        final cor = listaDashes.first.color;
        return DashboardItem(solicitacao, totalSomado, cor);
      }).toList();

      final setorTotal = SetorModel(id: 0, sigla: 'GERAL', nome: 'Total Geral');
      return [DashboardSetor(setor: setorTotal, dashboards: listaAgrupada)];
    }

    return items.where((e) => e.setor.sigla == filtro).toList();
  }
}
