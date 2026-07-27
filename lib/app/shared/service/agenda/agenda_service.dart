import 'package:multiple_result/multiple_result.dart';

import '../../../core/exceptions/failure.dart';
import '../../domain/agenda/agenda_repository.dart';
import '../../domain/agenda/entities/agenda_entity.dart';

class AgendaService {
  final AgendaRepository repository;

  AgendaService(this.repository);

  Future<Result<List<AgendaEntity>, Failure>> carregarEventosPorSetor({required int idSetor}) async {
    return repository.carregarEventosPorSetor(idSetor: idSetor);
  }
}
