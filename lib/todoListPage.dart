import 'package:app/todoItem.dart';
import 'package:flutter/material.dart';

import 'todoItem.dart';

//provider
import 'package:app/provider/todos.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    var todo_list = context.watch<Todos>().todos;

    return Scaffold(
      body: Container(
        child: Center(
            child: ListView.builder(
          itemCount: todo_list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(todo_list[index].imagePath!,
                              height: 80, width: 80, fit: BoxFit.cover),
                          Text(todo_list[index].todo!),
                          ElevatedButton(
                              onPressed: () {
                                context.read<Todos>().delTodo(index);
                              },
                              child: Text('삭제'))
                        ],
                      ))),
              onTap: () {
                AlertDialog dialog = AlertDialog(
                  content: Column(children: [
                    Image.asset(todo_list[index].imagePath!,
                        width: 100, height: 100, fit: BoxFit.cover),
                    Text(
                      todo_list[index].todo!,
                      style: TextStyle(fontSize: 30),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            context.read<Todos>().delTodo(index);
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('삭제'))
                  ]),
                );
                showDialog(
                    context: context,
                    builder: ((BuildContext context) => dialog));
              },
            );
          },
        )),
      ),
    );
  }
}
