import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String normalizar() {
    String texto = this;
    const comAcento = 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ';
    const semAcento = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';

    for (int i = 0; i < comAcento.length; i++) {
      texto = texto.replaceAll(comAcento[i], semAcento[i]);
    }

    return texto.toLowerCase();
  }

  String formatarData() {
    final String data = this;

    final DateTime dateTime = DateTime.parse(data);
    return DateFormat('dd/MM/yyyy', 'pt-BR').format(dateTime).trim();
  }
}
