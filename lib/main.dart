import 'package:app/todoListPage.dart';
import 'package:app/todoWritePage.dart';
import 'package:flutter/material.dart';
import 'todoItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  List<TodoItem> todoList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    todoList = [
      TodoItem(
          todo: '출근하기',
          achieved: true,
          imagePath: 'assets/images/emoji_think.png')
    ];
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
        children: <Widget>[
          TodoListPage(list: todoList),
          TodoWritePage(list: todoList)
        ],
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
