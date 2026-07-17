import 'package:flutter/material.dart';

import 'categoria_chip.dart';

class FiltroCategorias extends StatelessWidget {
  final Map<String, int> categorias;
  final String? selecionada;
  final ValueChanged<String?> onSelecionada;

  const FiltroCategorias({super.key, required this.categorias, required this.selecionada, required this.onSelecionada});

  @override
  Widget build(BuildContext context) {
    final total = categorias.values.fold(0, (soma, valor) => soma + valor);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CategoriaChip(
            label: 'Todos',
            count: total,
            isSelected: selecionada == null,
            onTap: () => onSelecionada(null),
          ),
          SizedBox(width: 6),
          ...categorias.entries.map((entry) {
            final key = entry.key;
            final value = entry.value;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CategoriaChip(
                label: key,
                count: value,
                isSelected: selecionada == key,
                onTap: () => onSelecionada(key),
              ),
            );
          }),
        ],
      ),
    );
  }
}
