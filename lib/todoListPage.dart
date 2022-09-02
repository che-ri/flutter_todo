import 'package:app/todoItem.dart';
import 'package:flutter/material.dart';
import 'todoItem.dart';

class TodoListPage extends StatefulWidget {
  List<TodoItem> list;
  TodoListPage({Key? key, required this.list}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) => GestureDetector(
            child: Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.list[index].imagePath!,
                    height: 100, width: 100, fit: BoxFit.contain),
                Text(widget.list[index].todo!),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.list.removeAt(index);
                      });
                    },
                    child: Text('삭제'))
              ],
            )),
            onTap: () {
              AlertDialog dialog = AlertDialog(
                content: Column(children: [
                  Image.asset(widget.list[index].imagePath!),
                  Text(widget.list[index].todo!)
                ]),
              );
              showDialog(
                  context: context,
                  builder: ((BuildContext context) => dialog));
            },
          ),
        )),
      ),
    );
  }
}
