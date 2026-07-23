import 'package:flutter/material.dart';

import '../../../../../../enum/tipo_solicitacao.dart';
import 'categoria_chip.dart';

class FiltroCategorias extends StatelessWidget {
  final Map<TipoSolicitacao, int> categorias;
  final TipoSolicitacao? selecionada;
  final ValueChanged<TipoSolicitacao> onSelecionada;

  const FiltroCategorias({super.key, required this.categorias, required this.selecionada, required this.onSelecionada});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categorias.entries.map((entry) {
          final categoria = entry.key;
          final label = categoria.label;
          final count = entry.value;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoriaChip(
              label: label,
              count: count,
              isSelected: selecionada == categoria,
              onTap: () => onSelecionada(categoria),
            ),
          );
        }).toList(),
      ),
    );
  }
}
