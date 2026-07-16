import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../mock/lembretes.dart';
import '../../mock/setores.dart';
import '../../models/lembrete_model.dart';
import '../../models/setor_model.dart';

part 'agenda_controller.g.dart';

class AgendaController = AgendaControllerBase with _$AgendaController;

abstract class AgendaControllerBase with Store {
  @observable
  var listLembretes = ObservableList.of(lembretes);

  @observable
  SetorModel? setorFiltrado;

  @observable
  int? idSetorSelecionado;

  @observable
  var calendarFormat = CalendarFormat.month;

  @observable
  DateTime mes = DateTime.now();

  @observable
  DateTime data = DateTime.now();

  @action
  void alterarFormato(CalendarFormat formato) {
    calendarFormat = formato;
  }

  @action
  Future<void> alterarSetor() async {
    mes = DateTime.now();
    data = DateTime.now();
    final int idSetor = idSetorSelecionado ?? setorFiltrado?.id ?? -1;
    setorFiltrado = setores.firstWhereOrNull((element) => element.id == idSetor);
  }

  @action
  Future<void> limparSetor() async {
    mes = DateTime.now();
    data = DateTime.now();
    setorFiltrado = null;
    idSetorSelecionado = null;
  }

  @computed
  List<LembreteModel> get lembretesFiltrados {
    final filtro = setorFiltrado;
    if (filtro == null) return listLembretes;
    return listLembretes.where((e) => e.setorModel.id == filtro.id).toList();
  }

  @computed
  List<LembreteModel> get lista {
    return lembretesFiltrados.where((evento) {
      return isSameDay(evento.data, data);
    }).toList();
  }
}
