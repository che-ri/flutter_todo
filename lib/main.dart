import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//widget
import 'package:app/todoListPage.dart';
import 'package:app/todoWritePage.dart';
import 'package:app/todoDetailPage.dart';

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
      // home: const MyHomePage(title: 'Flutter Todo'),
      initialRoute: '/',
      routes: {
        '/': (context) => TodoListPage(),
        '/write': (context) => TodoWritePage(
            args: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/detail': (context) => TodoDetailPage(
            args: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)
      },
    );
  }
}
