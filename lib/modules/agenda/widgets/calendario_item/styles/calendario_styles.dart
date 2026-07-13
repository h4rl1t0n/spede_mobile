import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioStyles {
  static CalendarStyle getCalendarStyle(ColorScheme colorScheme) {
    return CalendarStyle(
      outsideDaysVisible: false,
      cellMargin: const EdgeInsets.all(6.0),
      selectedDecoration: BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.circular(12)),
      todayDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.primary, width: 1.5),
      ),
      selectedTextStyle: TextStyle(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 16),
      todayTextStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  static HeaderStyle getHeaderStyle(ColorScheme colorScheme) {
    return HeaderStyle(
      titleCentered: true,
      formatButtonVisible: true,
      titleTextFormatter: (date, locale) {
        return DateFormat(
          'MMMM \'de\' yyyy',
          'pt_BR',
        ).format(date).replaceFirstMapped(RegExp(r'^\w'), (match) => match.group(0)!.toUpperCase());
      },
      // headerPadding: const EdgeInsets.only(bottom: 0),
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: colorScheme.onSurface),
      leftChevronIcon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: colorScheme.shadow.withValues(alpha: 0.19), blurRadius: 3, offset: const Offset(0, 1)),
          ],
        ),
        child: Icon(Icons.chevron_left_rounded, color: colorScheme.primary, size: 24),
      ),
      rightChevronIcon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: colorScheme.shadow.withValues(alpha: 0.19), blurRadius: 3, offset: const Offset(0, 1)),
          ],
        ),
        child: Icon(Icons.chevron_right_rounded, color: colorScheme.primary, size: 24),
      ),
    );
  }
}
