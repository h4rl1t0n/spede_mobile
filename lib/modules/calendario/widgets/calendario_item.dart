import 'package:flutter/material.dart';

import '../../../mock/eventos.dart';
import 'dia.dart';
import 'dia_da_semana.dart';

class CalendarioItem extends StatelessWidget {
  final DateTime mes;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarioItem({super.key, required this.mes, required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    final days = _generateDays(mes);

    return Column(
      children: [
        Container(
          height: 42,
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              DiaDaSemana('Dom'),
              DiaDaSemana('Seg'),
              DiaDaSemana('Ter'),
              DiaDaSemana('Qua'),
              DiaDaSemana('Qui'),
              DiaDaSemana('Sex'),
              DiaDaSemana('Sáb'),
            ],
          ),
        ),

        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: .95,
            ),
            itemBuilder: (_, index) {
              final date = days[index];
              final quantidade = eventos.where((evento) {
                return evento.dataSolicitacao.year == date.year && evento.dataSolicitacao.month == date.month && evento.dataSolicitacao.day == date.day;
              }).length;

              return Dia(
                date: date,
                currentMonth: mes.month,
                selected: _isSameDay(date, selectedDate),
                eventCount: quantidade,
                onTap: () => onDateSelected(date),
              );
            },
          ),
        ),
      ],
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.day == b.day && a.month == b.month && a.year == b.year;
  }

  List<DateTime> _generateDays(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);

    final firstWeekday = firstDay.weekday % 7;

    final start = firstDay.subtract(Duration(days: firstWeekday));

    return List.generate(42, (i) => start.add(Duration(days: i)));
  }
}
