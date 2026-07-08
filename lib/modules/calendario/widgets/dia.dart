import 'package:flutter/material.dart';

class Dia extends StatelessWidget {
  final DateTime date;
  final int currentMonth;
  final bool selected;
  final int eventCount;
  final VoidCallback? onTap;

  const Dia({
    super.key,
    required this.date,
    required this.currentMonth,
    required this.selected,
    this.eventCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final now = DateTime.now();

    final isToday = now.year == date.year && now.month == date.month && now.day == date.day;

    final isCurrentMonth = date.month == currentMonth;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primaryContainer
                : isCurrentMonth
                ? Colors.white
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : isToday
                  ? theme.colorScheme.primary.withValues(alpha: .5)
                  : Colors.grey.shade200,
              width: selected ? 2 : (isToday ? 1.5 : 1),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected || isToday ? FontWeight.bold : FontWeight.w600,
                    color: selected
                        ? theme.colorScheme.primary
                        : isCurrentMonth
                        ? Colors.black87
                        : Colors.grey,
                  ),
                ),
              ),

              if (eventCount > 0) Flexible(child: _EventBadge(eventCount: eventCount)),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventBadge extends StatelessWidget {
  final int eventCount;

  const _EventBadge({required this.eventCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        eventCount.toString(),
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
      ),
    );
  }
}
