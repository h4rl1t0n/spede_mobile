import 'package:flutter/material.dart';

import 'widgets/calendario_item.dart';
import 'widgets/header.dart';
import 'widgets/lista_de_enventos.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime mes = DateTime.now();
  DateTime dataSelecionada = DateTime.now();

  final meses = const [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  void previousMonth() {
    setState(() {
      mes = DateTime(mes.year, mes.month - 1);
    });
  }

  void nextMonth() {
    setState(() {
      mes = DateTime(mes.year, mes.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda', style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Header(month: '${meses[mes.month - 1]} de ${mes.year}', onPrevious: previousMonth, onNext: nextMonth),

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 15, offset: const Offset(0, 5)),
                ],
              ),
              child: SizedBox(
                height: 330,
                child: CalendarioItem(
                  mes: mes,
                  selectedDate: dataSelecionada,
                  onDateSelected: (date) {
                    setState(() {
                      dataSelecionada = date;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  child: ListaEventos(data: dataSelecionada),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
