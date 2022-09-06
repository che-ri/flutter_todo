import 'package:flutter/material.dart';

//provider
import 'package:app/provider/todos.dart';
import 'package:provider/provider.dart';

class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    int todo_index = int.parse(args);
    var todo_list = context.read<Todos>().todos;
    var todo_item = todo_list[todo_index];

    return Scaffold(
      appBar: AppBar(
        title: Text('투두 상세페이지'),
      ),
      body: Container(
          child: Center(
        child: Column(children: <Widget>[
          Image.asset(
            todo_item.imagePath!,
            width: 200,
            height: 200,
          ),
          Text(
            todo_item.todo!,
            style: TextStyle(fontSize: 30),
          ),
          Text(
            todo_item.achieved! ? '진행중' : '완료',
            style: TextStyle(color: Colors.amber[900]),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/write', arguments: todo_index);
                  },
                  child: Text('수정')),
              Padding(padding: EdgeInsets.all(5)),
              ElevatedButton(
                  onPressed: () {
                    delTodo(todo_index);
                  },
                  child: Text('삭제')),
            ],
          )
        ]),
      )),
    );
  }

  void delTodo(int index) {
    context.read<Todos>().delTodo(index);
    Navigator.of(context).pop();
  }
}
