import 'package:flutter/material.dart';

class FiltroCategorias extends StatelessWidget {
  final Map<String, int> categorias;

  final String? selecionada;

  final ValueChanged<String?> onSelecionada;

  const FiltroCategorias({super.key, required this.categorias, required this.selecionada, required this.onSelecionada});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Total de processos para o chip "Todos"
    final total = categorias.values.fold<int>(0, (sum, v) => sum + v);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Chip "Todos" — sempre primeiro
          _buildChip(
            context: context,
            label: 'Todos',
            count: total,
            isSelected: selecionada == null,
            onTap: () => onSelecionada(null),
            cs: cs,
          ),

          const SizedBox(width: 8),

          // Chips dinâmicos por categoria
          ...categorias.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildChip(
                context: context,
                label: entry.key,
                count: entry.value,
                isSelected: selecionada == entry.key,
                onTap: () => onSelecionada(entry.key),
                cs: cs,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip({
    required BuildContext context,
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
    required ColorScheme cs,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? cs.primary : Colors.grey.shade300),
        ),
        child: Text(
          '$label ($count)',
          style: TextStyle(
            color: isSelected ? cs.onPrimary : cs.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
