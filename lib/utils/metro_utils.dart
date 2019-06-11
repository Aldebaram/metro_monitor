import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MetroUtils {
  String getNome(int id) {
    List lines = [
      'Desconhecida',
      'Azul',
      'Verde',
      'Vermelha',
      'Amarela',
      'Lilas',
      'Desconhecida',
      'Rubi',
      'Diamante',
      'Esmeralda',
      'Turquesa',
      'Coral',
      'Safira',
      'Jade',
      'Desconhecida',
      'Prata'
    ];

    if (id >= lines.length) return 'Linha Desconhecida';

    return 'Linha $id - ' + lines[id];
  }

  String formatDate(date) {
    initializeDateFormatting("pt_BR", null);
    return DateFormat("HH:mm", "pt_BR").format(DateTime.parse(date).toLocal());
  }

  List iconHandler(icon) {
    icon = icon.toLowerCase();

    if (icon.contains('normal')) return [Icons.check, Colors.green];

    if (icon.contains("diferenciada") ||
        icon.contains("parcial") ||
        icon.contains("velocidade reduzida"))
      return [Icons.warning, Colors.yellow];

    if (icon.contains("paralisada")) return [Icons.report, Colors.red];

    if (icon.contains("encerrada")) return [Icons.block, Colors.black];

    return [Icons.block, Colors.pink];
  }
}
