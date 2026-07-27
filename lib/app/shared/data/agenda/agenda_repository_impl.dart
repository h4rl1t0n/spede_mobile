import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../../models/lembrete_model.dart';
import '../../domain/agenda/agenda_repository.dart';
import 'datasource/agenda_datasource.dart';
import 'dto/agenda_dto.dart';

class AgendaRepositoryImpl extends AgendaRepository {
  final AgendaDatasource datasource;

  AgendaRepositoryImpl(this.datasource);

  @override
  Future<Result<List<LembreteModel>, Failure>> carregarTodosEventos({required DateTime mes, int? idSetor}) async {
    final result = await datasource.carregarTodosEventos(mes: mes, idSetor: idSetor);

    return result.when(
      (success) {
        return Success(success);
      },
      (error) {
        return Error(error);
      },
    );
  }

  @override
  Future<Result<List<AgendaDTO>, Failure>> carregarEventosPorSetor({int? idSetor}) async {
    final result = await datasource.carregarEventosPorSetor(idSetor: idSetor);

    return result.when(
      (success) {
        return Success(success);
      },
      (error) {
        return Error(error);
      },
    );
  }
}
