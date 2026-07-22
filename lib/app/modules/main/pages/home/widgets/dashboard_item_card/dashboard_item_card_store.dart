import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../models/setor_model.dart';
import 'dashboard_item_card.dart';

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
    } else if (filtro == 'Todos (Visão Geral)') {
      if (items.isEmpty) return [];

      final Map<String, int> somaAgrupada = {};
      final Map<String, Color> mapaDeCores = {};

      for (var dashSetor in items) {
        for (var dash in (dashSetor.dashboards ?? <DashboardItem>[])) {
          final valorLimpo = int.tryParse(dash.value.replaceAll('.', '')) ?? 0;
          somaAgrupada[dash.title] = (somaAgrupada[dash.title] ?? 0) + valorLimpo;
          mapaDeCores[dash.title] = dash.color; // Salva a cor original
        }
      }

      final listaAgrupada = somaAgrupada.entries.map((entry) {
        return DashboardItem(entry.key, entry.value.toString(), mapaDeCores[entry.key] ?? Colors.grey);
      }).toList();

      final setorTotal = SetorModel(id: 0, sigla: 'GERAL', nome: 'Total Geral');

      return [DashboardSetor(setor: setorTotal, dashboards: listaAgrupada)];
    } else {
      return items.where((e) => e.setor.sigla == filtro).toList();
    }
  }
}
