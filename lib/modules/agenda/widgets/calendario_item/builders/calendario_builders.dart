import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/extensions/string_extension.dart';
import '../../../../../models/lembrete_model.dart';

class CalendarioBuilders {
  static CalendarBuilders<LembreteModel> getBuilders(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return CalendarBuilders<LembreteModel>(
      dowBuilder: (context, day) {
        final text = DateFormat.E('pt_BR').format(day).toLowerCase();

        Color corTexto = colorScheme.onSurfaceVariant;
        if (day.weekday == DateTime.sunday) corTexto = Colors.red;
        if (day.weekday == DateTime.saturday) corTexto = Colors.grey.shade900;

        return Center(
          child: Text(
            text.capitalize(),
            style: TextStyle(color: corTexto, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        );
      },

      defaultBuilder: (context, day, focusedDay) => _buildCelulaDia(day, colorScheme),
      outsideBuilder: (context, day, focusedDay) => _buildCelulaDia(day, colorScheme, isOutside: true),
      disabledBuilder: (context, day, focusedDay) => _buildCelulaDia(day, colorScheme, isOutside: true),

      markerBuilder: (context, day, events) {
        if (events.isEmpty) return const SizedBox.shrink();

        return Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: theme.colorScheme.surface, width: 1.5),
            ),
            child: Text(
              '${events.length}',
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, height: 1),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildCelulaDia(DateTime day, ColorScheme colorScheme, {bool isOutside = false}) {
    Color corTexto = colorScheme.onSurface;

    if (day.weekday == DateTime.sunday) {
      corTexto = Colors.red;
    } else if (day.weekday == DateTime.saturday) {
      corTexto = Colors.grey.shade600;
    }

    if (isOutside) {
      corTexto = corTexto.withValues(alpha: .3);
    }

    return Container(
      margin: const EdgeInsets.all(6.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Text(
        '${day.day}',
        style: TextStyle(color: corTexto, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
