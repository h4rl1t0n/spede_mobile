import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/message_error.dart';
import '../../../../mock/lembretes.dart';
import '../../../../models/lembrete_model.dart';
import '../dto/agenda_dto.dart';
import 'agenda_datasource.dart';

class AgendaDatasourceImpl extends AgendaDatasource {
  final DioForNative client;

  AgendaDatasourceImpl(this.client);

  @override
  Future<Result<List<LembreteModel>, Failure>> carregarTodosEventos({required DateTime mes, int? idSetor}) async {
    try {
      log('\x1B[2J\x1B[0;0H');

      String logMsg = '⏳ Carregando eventos do mês ${mes.month < 10 ? ('0${mes.month}') : mes.month}/${mes.year}';
      if (idSetor != null) {
        logMsg += ' (Filtrando pelo Setor ID: $idSetor)';
      } else {
        logMsg += ' (Buscando todos os setores)';
      }
      log(logMsg);

      await Future.delayed(const Duration(seconds: 3));

      final lista = lembretes.where((e) {
        final isMesmoMes = e.data.year == mes.year && e.data.month == mes.month;
        final isSetorCorreto = idSetor == null || e.setorModel.id == idSetor;
        return isMesmoMes && isSetorCorreto;
      }).toList();

      log('✅ Sucesso! Foram encontrados ${lista.length} eventos para este filtro.\n');

      return Success(lista);
    } on DioException catch (err) {
      return Error(MessageError.getMessage(err));
    }
  }

  @override
  Future<Result<List<AgendaDTO>, Failure>> carregarEventosPorSetor({int? idSetor}) async {
    try {
      final response = await client.get('agenda/', queryParameters: {'idLocal': idSetor ?? 8});

      if (response.statusCode == 200) {
        final result = (response.data as List).map((e) => AgendaDTO.fromJson(e)).toList();
        return Success(result);
      }

      return Error(MessageError.getMessage(response));
    } on DioException catch (err) {
      return Error(MessageError.getMessage(err));
    }
  }
}
