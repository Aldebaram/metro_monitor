import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'detailsView.dart';
import 'metro.dart';

Text getNome(num linhaId) {
  String texto;
  switch (linhaId) {
    case 1:
      texto = 'Linha 1 - Azul';
      break;
    case 2:
      texto = 'Linha 2 - Verde';
      break;
    case 3:
      texto = 'Linha 3 - Vermelha';
      break;
    case 4:
      texto = 'Linha 4 - Amarela';
      break;
    case 5:
      texto = 'Linha 5 - Lilás';
      break;
    case 6:
      texto = 'Linha 6 - ????';
      break;
    case 7:
      texto = 'Linha 7 - Rubi';
      break;
    case 8:
      texto = 'Linha 8 - Diamante';
      break;
    case 9:
      texto = 'Linha 9 - Esmeralda';
      break;
    case 10:
      texto = 'Linha 10 - Turquesa';
      break;
    case 11:
      texto = 'Linha 11 - Coral';
      break;
    case 12:
      texto = 'Linha 12 - Safira';
      break;
    case 13:
      texto = 'Linha 13 - Jade';
      break;
    case 14:
      texto = 'Linha 14 - ??????';
      break;
    case 15:
      texto = 'Linha 15 - Prata';
      break;
    default:
      return Text(
        'Uma linha nova?',
        textAlign: TextAlign.center,
        textScaleFactor: 1.5,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
  }
  return Text(
    texto,
    textAlign: TextAlign.center,
    textScaleFactor: 1.5,
    style: TextStyle(fontWeight: FontWeight.w500),
  );
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
  else{
    return Icon(
      Icons.block,
      color: Colors.pink,
      size: 40.0,
    );
  }
}

Widget cardTile(Metro linha, BuildContext context) {
  initializeDateFormatting("pt_BR", null);
  return new Container(
    height: 100,
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new Details(linha.codigo)));
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              child: iconHandler(linha.situacao),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: getNome(linha.codigo),
                ),
                Text(linha.situacao,textAlign: TextAlign.start,),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
            child:
            Text(
              DateFormat("HH:mm", "pt_BR")
                  .format(DateTime.parse(linha.modificado).toLocal()),
              textAlign: TextAlign.end,
            ),
            ),
          ],
        ),
      ),
    ),
  );
}
