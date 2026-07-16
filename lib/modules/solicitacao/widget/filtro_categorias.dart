import 'package:flutter/material.dart';

class FiltroCategorias extends StatelessWidget {
  final int total;
  final Map<String, int> categorias;
  final String? selecionada;
  final ValueChanged<String?> onSelecionada;

  const FiltroCategorias({
    super.key,
    required this.categorias,
    required this.selecionada,
    required this.onSelecionada,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    //final total = categorias.values.fold(0, (soma, valor) => soma + valor);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _CategoriaChip(
            label: 'Todos',
            count: total,
            isSelected: selecionada == null,
            onTap: () => onSelecionada(null),
            colorScheme: cs,
          ),

          const SizedBox(width: 8),

          ...categorias.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _CategoriaChip(
                label: entry.key,
                count: entry.value,
                isSelected: selecionada == entry.key,
                onTap: () => onSelecionada(entry.key),
                colorScheme: cs,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriaChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _CategoriaChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? colorScheme.primary : Colors.grey.shade300),
        ),
        child: Text(
          '$label ($count)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
