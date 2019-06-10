import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'metro.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'detailsView.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'common.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linhas do Metrô',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueGrey),
      home: MyHomePage(title: 'Linhas do Metrô'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String texto = "";

  Future<MetroList> fetchPost() async {
    final response =
        await http.get('https://www.diretodostrens.com.br/api/status');

    if (response.statusCode == 200) {
      // If server returns an OK response
      final jsonResponse = json.decode(response.body);
      MetroList lista = new MetroList.fromJson(jsonResponse);
      return lista;
    } else {
      // If that response was not OK
      Future<MetroList> lista;
      return lista;
    }
  }


  Future<void> refresh() async {
    await fetchPost();
    setState(() {});
  }


  Container card(Metro linha) {

    return new Container(
      height: 100,
      child: Card(
        child: ListTile(
          leading: iconHandler(linha.situacao),
          title: getNome(linha.codigo),
          subtitle: Text(linha.situacao),
          isThreeLine: true,
          dense: true,
          trailing: Text(DateFormat("HH:mm", "pt_BR")
              .format(DateTime.parse(linha.modificado).toLocal())),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new Details(linha.codigo)));
          },
        ),
      ),
    );
  }

  List<Container> cardlist(MetroList lista) {
    List<Container> cards =  new List();
    for (var metro in lista.metros) {
    cards.add(cardTile(metro, context));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            FutureBuilder<MetroList>(
              future: fetchPost(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Widget> lista = cardlist(snapshot.data);
                  return Column(
                    children: lista.map((Widget item) => item).toList(),
                  );
                } else if (snapshot.hasError) {
                  return new Text("${snapshot.error}");
                }
                return Container(
                  padding: EdgeInsets.only(left: 185, right: 185, top: 20),
                  child: new CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: refresh,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),
      */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
