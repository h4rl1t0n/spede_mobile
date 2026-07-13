import 'package:flutter/material.dart';

class LembreteModel {
  final String id;
  final String titulo;
  final String? descricao;
  final String tipo;
  final String numero;
  final String assunto;
  final String orgao;
  final DateTime data;
  final Color cor;
  final bool isLembrete;

  const LembreteModel({
    required this.id,
    required this.titulo,
    this.descricao,
    required this.tipo,
    required this.numero,
    required this.assunto,
    required this.orgao,
    required this.data,
    required this.cor,
    this.isLembrete = false,
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
    Color? cor,
    bool? isLembrete,
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
      cor: cor ?? this.cor,
      isLembrete: isLembrete ?? this.isLembrete,
    );
  }
}
