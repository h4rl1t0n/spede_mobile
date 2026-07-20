import 'package:flutter/material.dart';

import '../core/ui/theme/styles/colors_app.dart';
import 'setor_model.dart';

class LembreteModel {
  final String id;
  final String titulo;
  final String? descricao;
  final String tipo;
  final String numero;
  final String assunto;
  final String orgao;
  final DateTime data;
  final bool isLembrete;
  final SetorModel setorModel;

  LembreteModel({
    required this.id,
    required this.titulo,
    this.descricao,
    required this.tipo,
    required this.numero,
    required this.assunto,
    required this.orgao,
    required this.data,
    this.isLembrete = false,
    required this.setorModel,
  });

  LembreteModel copyWith({
    String? id,
    String? titulo,
    String? descricao,
    String? tipo,
    String? numero,
    String? assunto,
    String? orgao,
    DateTime? data,
    bool? isLembrete,
    SetorModel? setorModel,
  }) {
    return LembreteModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
      numero: numero ?? this.numero,
      assunto: assunto ?? this.assunto,
      orgao: orgao ?? this.orgao,
      data: data ?? this.data,
      isLembrete: isLembrete ?? this.isLembrete,
      setorModel: setorModel ?? this.setorModel,
    );
  }

  Color get cor => !isLembrete ? ColorsApp.instance.primary : Colors.orange;
}
