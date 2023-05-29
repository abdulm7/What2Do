import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:what2do_app/services/api_service.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  
  Widget build(BuildContext context) {

    var time = DateTime.now();
    
    return MaterialApp(
      
      title: time.toString(),
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
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      
      home: const MyHomePage(title: 'What2Do - Today'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  
  List<String>? activities;
  var isLoaded = false;

  void _getActivities(occupation, goal) async {

    activities = await ApiService().getActivities(occupation, goal);

    if (activities != null){
      setState(() {
        isLoaded = true;
        _counter++;
      });
    }
  }

  bool value = false;
  var bodyText = "No Activities Found :(";
  
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
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: activities?.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(activities![index]),
              trailing: Checkbox(
                value: false, 
                onChanged: (bool? value) {
                  if (value == true){
                    value = false;
                  }else{
                    value = true;
                  }
                },
              ),
              tileColor: const Color.fromARGB(255, 212, 211, 206),
            );
          }
        ),
        replacement: Center(child: Text(bodyText),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showDialogWithFields,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        // child: const Text('Generate Tasks')
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

void showDialogWithFields() {
  showDialog(
    context: context,
    builder: (_) {

      var occController = TextEditingController();
      var goalController = TextEditingController();
      return Center(
        child: AlertDialog(
          title: const Text('Set Your Goal!'),
          content: Container(
            height: 150,
            child: Column(
              children: [ 
                TextFormField(
                  controller: occController,
                  decoration: const InputDecoration(hintText: 'Occupation'),
                ),
                TextFormField(
                  controller: goalController,
                  decoration: const InputDecoration(hintText: 'Goal'),
                ),
              ]
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Send them to your email maybe?
                var occupation = occController.text;
                var goal = goalController.text;

                print(occupation);
                print(goal);

                setState(() {
                  activities = [];
                  bodyText = "Loading...";
                });

                _getActivities(occupation, goal);
                Navigator.pop(context);
              },
              child: const Text('Send'),
            )
          ],
        ),
      );

    },
  );
}
}


