import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/message_error.dart';
import '../../../../mock/lembretes.dart';
import '../../../../models/lembrete_model.dart';
import 'agenda_datasource.dart';

class AgendaDatasourceImpl extends AgendaDatasource {
  @override
  Future<Result<List<LembreteModel>, Failure>> carregarTodosEventos({required DateTime mes, int? idSetor}) async {
    try {
      // 1. Limpa o console atual
      log('\x1B[2J\x1B[0;0H');

      // 2. Monta e exibe a mensagem de log inicial
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
}
