import 'package:app/todoItem.dart';
import 'package:flutter/material.dart';
import 'todoItem.dart';

class TodoWritePage extends StatefulWidget {
  List<TodoItem> list;
  TodoWritePage({Key? key, required this.list}) : super(key: key);

  @override
  State<TodoWritePage> createState() => _TodoWritePageState();
}

class _TodoWritePageState extends State<TodoWritePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('작성페이지'),
    );
  }
}
