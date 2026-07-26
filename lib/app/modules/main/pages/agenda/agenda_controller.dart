import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/result/result_handler.dart';
import '../../../../enum/page_status.dart';
import '../../../../mock/setores.dart';
import '../../../../models/lembrete_model.dart';
import '../../../../models/setor_model.dart';
import '../../../../shared/service/agenda/agenda_service.dart';

part 'agenda_controller.g.dart';

class AgendaController = AgendaControllerBase with _$AgendaController;

abstract class AgendaControllerBase with Store {
  final AgendaService service;

  @observable
  var status = PageStatus.initial;

  @observable
  var messageLoader = '';

  @observable
  String? errorMessage;

  @observable
  var listEventos = ObservableList<LembreteModel>();

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

  AgendaControllerBase(this.service);

  @action
  Future<void> carregarEventos() async {
    status = PageStatus.loading;
    messageLoader = 'Carregando eventos..';
    errorMessage = null;

    await fetch(
      service.carregarTodosEventos(mes: mes, idSetor: setorFiltrado?.id),
      onSuccess: (result) {
        listEventos.clear();
        listEventos.addAll(result);
        status = PageStatus.loaded;
        messageLoader = '';
      },
      onError: (message) {
        status = PageStatus.error;
        errorMessage = message;
        messageLoader = '';
      },
    );
  }

  @action
  Future<void> alterarSetor() async {
    // mes = DateTime.now();
    // data = DateTime.now();
    final int idSetor = idSetorSelecionado ?? setorFiltrado?.id ?? -1;
    setorFiltrado = setores.firstWhereOrNull((element) => element.id == idSetor);

    await carregarEventos();
  }

  @action
  Future<void> limparSetor() async {
    // mes = DateTime.now();
    // data = DateTime.now();
    setorFiltrado = null;
    idSetorSelecionado = null;

    await carregarEventos();
  }

  @action
  void alterarFormato(CalendarFormat formato) => calendarFormat = formato;

  @computed
  List<LembreteModel> get listEventosPorDia {
    return listEventos.where((evento) {
      return isSameDay(evento.data, data);
    }).toList();
  }
}
