import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../shared/domain/agenda/entities/agenda_entity.dart';
import 'builders/calendario_builders.dart';
import 'styles/calendario_styles.dart';

class CalendarioItem extends StatelessWidget {
  final CalendarFormat calendarFormat;
  final DateTime mes;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<DateTime> onMonthChanged;
  final List<AgendaEntity> lembretesList;
  final ValueChanged<CalendarFormat> onFormatChanged;

  const CalendarioItem({
    super.key,
    required this.mes,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onMonthChanged,
    required this.lembretesList,
    required this.calendarFormat,
    required this.onFormatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar<AgendaEntity>(
      locale: 'pt_BR',
      firstDay: DateTime.utc(2020),
      lastDay: DateTime.utc(2035),
      focusedDay: mes,
      enabledDayPredicate: (day) => day.month == mes.month,
      selectedDayPredicate: (day) => isSameDay(day, selectedDate),
      onDaySelected: (selectedDay, focusedDay) {
        final mesmoDia = isSameDay(selectedDate, selectedDay);

        if (!mesmoDia) {
          onDateSelected(selectedDay);
        }
      },
      onPageChanged: onMonthChanged,
      eventLoader: (day) {
        return lembretesList.where((e) {
          return isSameDay(e.dataAgenda, day);
        }).toList();
      },
      calendarFormat: calendarFormat,
      onFormatChanged: onFormatChanged,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {CalendarFormat.month: 'Mês', CalendarFormat.week: 'Semana'},
      sixWeekMonthsEnforced: true,
      rowHeight: 45,
      calendarStyle: CalendarioStyles.getCalendarStyle(),
      headerStyle: CalendarioStyles.getHeaderStyle(),
      calendarBuilders: CalendarioBuilders.getBuilders(),
    );
  }
}
