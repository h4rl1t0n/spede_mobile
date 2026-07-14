import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../models/lembrete_model.dart';
import 'builders/calendario_builders.dart';
import 'styles/calendario_styles.dart';

class CalendarioItem extends StatelessWidget {
  final DateTime mes;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<DateTime> onMonthChanged;
  final List<LembreteModel> lembretesList;

  const CalendarioItem({
    super.key,
    required this.mes,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onMonthChanged,
    required this.lembretesList,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TableCalendar<LembreteModel>(
      locale: 'pt_BR',
      firstDay: DateTime.utc(2020),
      lastDay: DateTime.utc(2035),
      focusedDay: mes,
      enabledDayPredicate: (day) => day.month == mes.month,
      selectedDayPredicate: (day) => isSameDay(day, selectedDate),
      onDaySelected: (selectedDay, focusedDay) {
        onDateSelected(selectedDay);
        onMonthChanged(focusedDay);
      },
      onPageChanged: onMonthChanged,
      eventLoader: (day) {
        return lembretesList.where((e) {
          return isSameDay(e.data, day);
        }).toList();
      },
      availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
      sixWeekMonthsEnforced: true,
      // daysOfWeekHeight: 30,
      // rowHeight: 54,
      calendarStyle: CalendarioStyles.getCalendarStyle(colorScheme),
      headerStyle: CalendarioStyles.getHeaderStyle(colorScheme),
      calendarBuilders: CalendarioBuilders.getBuilders(theme),
    );
  }
}
