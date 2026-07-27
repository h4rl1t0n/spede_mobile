import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../domain/agenda/agenda_repository.dart';
import '../../domain/agenda/entities/agenda_entity.dart';
import 'datasource/agenda_datasource.dart';

class AgendaRepositoryImpl extends AgendaRepository {
  final AgendaDatasource datasource;

  AgendaRepositoryImpl(this.datasource);

  @override
  Future<Result<List<AgendaEntity>, Failure>> carregarEventosPorSetor({required int idSetor}) async {
    final result = await datasource.carregarEventosPorSetor(idSetor: idSetor);

    return result.when(
      (success) {
        final entities = success.map((e) => e.toEntity()).toList();
        return Success(entities);
      },
      (error) {
        return Error(error);
      },
    );
  }
}
