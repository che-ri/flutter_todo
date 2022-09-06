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
      appBar: AppBar(
          title: Text(
        '투두리스트',
      )),
      body: Container(
        child: Center(
            child: ListView.builder(
          itemCount: todo_list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/detail',
                    arguments: {'index': index.toString()});
              },
              child: Card(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(todo_list[index].imagePath!,
                              height: 80, width: 80, fit: BoxFit.cover),
                          Column(
                            children: [
                              Text(
                                  todo_list[index].achieved == 0 ? '진행중' : '완료',
                                  style: TextStyle(
                                      color: Colors.amber[800], fontSize: 12)),
                              Text(
                                todo_list[index].todo!,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context.read<Todos>().delTodo(index);
                              },
                              child: Text('삭제'))
                        ],
                      ))),
            );
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/write', arguments: {'index': null});
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
