import 'package:flutter/material.dart';

Text getNome(num linhaId) {
      switch (linhaId) {
        case 1:
          return Text('Linha 1 - Azul');
          break;
        case 2:
          return Text('Linha 2 - Verde');
          break;
        case 3:
          return Text('Linha 3 - Vermelha');
          break;
        case 4:
          return Text('Linha 4 - Amarela');
          break;
        case 5:
          return Text('Linha 5 - Lilás');
          break;
        case 6:
          return Text('Linha 6 - ????');
          break;
        case 7:
          return Text('Linha 7 - Rubi');
          break;
        case 8:
          return Text('Linha 8 - Diamante');
          break;
        case 9:
          return Text('Linha 9 - Esmeralda');
          break;
        case 10:
          return Text('Linha 10 - Turquesa');
          break;
        case 11:
          return Text('Linha 11 - Coral');
          break;
        case 12:
          return Text('Linha 12 - Safira');
          break;
        case 13:
          return Text('Linha 13 - Jade');
          break;
        case 14:
          return Text('Linha 14 - ??????');
          break;
        case 15:
          return Text('Linha 15 - Prata');
          break;
        default:
          return Text('Linha ?');
      }
    }

    
    Icon iconHandler(String situacao) {
      situacao = situacao.toLowerCase();
      if (situacao.contains("normal")) {
        return Icon(
          Icons.check,
          color: Colors.green,
          size: 40.0,
        );
      }

      if (situacao.contains("diferenciada") ||
          situacao.contains("parcial") ||
          situacao.contains("velocidade reduzida")) {
        return Icon(
          Icons.warning,
          color: Colors.yellow,
          size: 40.0,
        );
      }

      if (situacao.contains("paralisada")) {
        return Icon(
          Icons.report,
          color: Colors.red,
          size: 40.0,
        );
      }

      if (situacao.contains("encerrada")) {
        return Icon(
          Icons.block,
          color: Colors.black,
          size: 40.0,
        );
      }
    }