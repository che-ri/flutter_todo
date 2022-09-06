import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//widget
import 'package:app/todoListPage.dart';
import 'package:app/todoWritePage.dart';

//provider
import 'package:app/provider/todos.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Todos>(
        create: (context) => Todos(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Todo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? bottomNavigator;
  // List<TodoItem> todoList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    bottomNavigator = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    bottomNavigator?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TabBarView(
        children: <Widget>[TodoListPage(), TodoWritePage()],
        controller: bottomNavigator,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.list_rounded, color: Colors.amber),
          ),
          Tab(
            icon: Icon(Icons.edit, color: Colors.amber),
          )
        ],
        controller: bottomNavigator,
      ),
    );
  }
}
