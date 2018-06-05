import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'player.dart';
import 'square.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextStyle style21 = new TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 21.0,
    );
    return new MaterialApp(
      title: 'SquArena',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Home Page'),
      routes: <String, WidgetBuilder> {
        "/GamePage": (BuildContext context) => new GamePage(),
      },
    );
  }
}



// <--
// HomePage here
// -->
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String p1name = '';
  String p2name = '';

List<Square> createArena()
{
  List<Square> arena = new List<Square>();
  int count = 0;

  while (arena.length < 16)
    arena.add(new Square(count++, -1, -1));

  return arena;
}

  Widget build(BuildContext context) {
          TextStyle style21 = new TextStyle(
      inherit: true,
      color: Colors.white,
      fontSize: 21.0,
    );
    TextStyle colora = new TextStyle(
      inherit: true,
      color: new Color(0xffe84c3d),
      fontSize: 21.0,
    );
    TextStyle colorb = new TextStyle(
      inherit: true,
      color: new Color(0xfff1c40f),
      fontSize: 21.0,
    );
          Text button = new Text(
                'Go',
            style: style21,
          );
//styles

    return new Scaffold(
         backgroundColor: new Color(0xff39465a),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            new Container(
              padding: const EdgeInsets.only(top: 50.0),
              child: new Image(
                image: new AssetImage('assets/images/logo2.png'),
                height: 300.00,
                width: 300.00,
              ),
            ),

            new Container(
              padding: const EdgeInsets.only(top: 35.0, left: 25.0, right: 25.0),
              child: new TextField(
                onChanged: (String text) => setState(() {
                  p1name = text;
                }),
                decoration: new InputDecoration(hintText: "Player1 name", hintStyle: colora),
                style: colora,
             ),
            ),

            new Container(
              padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
              child: new TextField(
                onChanged: (String text) => setState(() {
                  p2name = text;
                }),
                decoration: new InputDecoration(hintText: "Player2 name", hintStyle: colorb),
                style: colorb,
             ),
            ),

             new Container(
              padding: const EdgeInsets.only(top: 35.0),
              child: new FlatButton(
              child: button,
              onPressed: () { Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) =>
                     new GamePage(p1: new Player(new Color(0xffe84c3d), p1name),
                                  p2: new Player(new Color(0xfff1c40f), p2name),
                                  arena: createArena(),
                                  )
                                  ));
                },
             ),
             ),

          ],
        ),
      ),
    );
  }
}


// <--
// GamePage here
// -->
class GamePage extends StatelessWidget {
    final Player p1;
    final Player p2;
    final List<Square> arena;
    int result = -1;
GamePage({this.p1, this.p2, this.arena});

//check si c'est un côté du carré
bool isValidSuit(int toCheck, int init, int toAdd, int nbloop)
{
  int _init = init;
  int count = -1;

  while (++count < nbloop)
  {
    if (_init == toCheck)
      return (true);
    _init += toAdd;
  }
  return (false);
}

void catchSquares(Square square, int state)
{
  if (square.id >= 4 &&
      arena[square.id - 4].value < square.value &&
      arena[square.id - 4].value > -1)
    arena[square.id - 4].state = state;

  if (square.id <= 11 &&
      arena[square.id + 4].value < square.value &&
      arena[square.id + 4].value > -1)
    arena[square.id + 4].state = state;

  if (square.id >= 1 &&
      arena[square.id - 1].value < square.value &&
      arena[square.id - 1].value > -1 &&
      !isValidSuit(arena[square.id - 1].value, 0, 4, 4))
    arena[square.id - 1].state = state;

  if (square.id <= 14 &&
      arena[square.id + 1].value < square.value &&
      arena[square.id + 1].value > -1 &&
      !isValidSuit(arena[square.id + 1].value, 3, 4, 4))
    arena[square.id + 1].state = state;
}

Widget getText(String txt) {
              TextStyle style42 = new TextStyle(
      inherit: true,
      color: p1.color,
      fontSize: 42.0,
    );
  //style

  int min = randNb(0, 9);
  int max = randNb(min + 1, 10);
  result = randNb(min, max + 1);
  txt = 'Choose a case\n' + min.toString() + ' ≤ X ≤ ' + max.toString();
  
  Container container = new Container(
    child: new Text(txt, style: style42, textAlign: TextAlign.center,),
  );

  return container;
}

int randNb(int min, int max)
{
  int rand = -1;
  
  while  (rand < min || rand > max)
    rand = math.Random().nextInt(max);

  return rand;
}

Widget build(BuildContext context) {
 @override

 TextStyle txt = new TextStyle(fontSize: 42.0, fontFamily: 'Squared');

    List<Widget> children = new List<Widget>();

    Widget child;
    int count = 0;

    for (var square in arena)
    {

  if (square.state == 0) {
    ++count;
            child = RaisedButton(color: new Color(0xffe84c3d),
        highlightColor: p1.color,
        textColor: Colors.white,
        onPressed: () { ; },
        child: new Text(square.value.toString(), style: txt,)
            );
  }
  else if (square.state ==  1) {
    ++count;
            child = RaisedButton(color: new Color(0xfff1c40f),
        highlightColor: p1.color,
        textColor: Colors.white,
        onPressed: () { ; },
        child: new Text(square.value.toString(), style: txt,)
            );
  }
  else {
        child = RaisedButton(color: Colors.white,
        highlightColor: p1.color,
        textColor: Colors.white,
        onPressed: () {
square.value = result;
          if (p1.color == new Color(0xffe84c3d))
    arena[square.id].state = 0;
  else
    arena[square.id].state = 1;
  catchSquares(square, arena[square.id].state);
  Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) =>
                     new GamePage(p1: p2, p2: p1, arena: arena,)));
         },
        child: new Text(' ',)
        );
  }

   if (count == 16)
  {
    //popup
  }

  Container container = new Container(
      child: child,
      );
      children.add(container);
    }
    
  return new Scaffold(
    appBar: new AppBar(title: new Text(p1.name), backgroundColor: p1.color),
    backgroundColor: new Color(0xff39465a),
    body: 
    new Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: new GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 0.0,
          children: children,
        ),
      ),
      bottomNavigationBar: 
        getText('Choose a case\n5 < X < 9'),
  );
}
}