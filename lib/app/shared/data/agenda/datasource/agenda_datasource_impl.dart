import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/rest_client/error/message_error.dart';
import '../dto/agenda_dto.dart';
import 'agenda_datasource.dart';

class AgendaDatasourceImpl extends AgendaDatasource {
  final DioForNative client;

  AgendaDatasourceImpl(this.client);

  @override
  Future<Result<List<AgendaDTO>, Failure>> carregarEventosPorSetor({required int idSetor}) async {
    try {
      final response = await client.get('agenda/', queryParameters: {'idLocal': idSetor});

      if (response.statusCode == 200) {
        final result = (response.data as List).map((e) => AgendaDTO.fromJson(e)).toList();
        log('✅ Sucesso! Foram encontrados ${result.length} eventos para este filtro.\n');
        return Success(result);
      }

      return Error(MessageError.getMessage(response));
    } on DioException catch (err) {
      return Error(MessageError.getMessage(err));
    }
  }
}
