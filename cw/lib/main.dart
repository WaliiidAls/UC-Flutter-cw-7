import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Diary",
      home: Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> myColors = [Colors.amber, Colors.red, Colors.blue, Colors.green];
  Map state = {
    "_text": "",
    "_color": Colors.amber,
  };
  double _opacity = 0.5;

  void _OnChange(key, value) {
    setState(() {
      state[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Diary"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Select a Color"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (Color color in myColors)
                    GestureDetector(
                      onTap: () => _OnChange("_color", color),
                      child: AnimatedOpacity(
                        opacity: state["_color"] == color ? _opacity : 1,
                        curve: Curves.bounceOut,
                        duration: Duration(milliseconds: 400),
                        child: CircleAvatar(
                          backgroundColor: color,
                        ),
                      ),
                    ),
                ],
              ),
              TextField(
                onChanged: (value) => _OnChange("_text", value),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: state["_color"]),
                        borderRadius: BorderRadius.circular(0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.5, color: state["_color"]),
                        borderRadius: BorderRadius.circular(0))),
              ),
              InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(
                                  color: state["_color"],
                                  text: state["_text"],
                                )),
                      ),
                  child: Text("Next"))
            ],
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String _text;
  final Color _color;
  const Details({
    Key? key,
    required String text,
    required Color color,
  })  : _text = text,
        _color = color,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Details")),
        backgroundColor: _color,
        body: Center(child: Text(_text)));
  }
}
