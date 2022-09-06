import 'package:app/todoItem.dart';
import 'package:flutter/material.dart';
import 'todoItem.dart';

//provider
import 'package:app/provider/todos.dart';
import 'package:provider/provider.dart';

class TodoWritePage extends StatefulWidget {
  const TodoWritePage({super.key});

  @override
  State<TodoWritePage> createState() => _TodoWritePageState();
}

class _TodoWritePageState extends State<TodoWritePage> {
  int? _radioValue;
  final todoController = TextEditingController();
  List<String> imageList = [
    "assets/images/emoji_angry.png",
    "assets/images/emoji_embarrassed.png",
    "assets/images/emoji_funny_sad.png",
    "assets/images/emoji_hard.png",
    "assets/images/emoji_lovely.png",
    "assets/images/emoji_party.png",
    "assets/images/emoji_sad.png",
    "assets/images/emoji_sleepy.png",
    "assets/images/emoji_think.png"
  ];
  String? _imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePath = imageList[0];
    _radioValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    var todo_list = context.watch<Todos>().todos;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
              controller: todoController,
              keyboardType: TextInputType.text,
              maxLines: 1),
          Row(
            children: <Widget>[
              Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange),
              Text('할일'),
              Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
              Text('메모')
            ],
          ),
          Container(
              height: 100,
              child: ListView.builder(
                itemCount: imageList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          _imagePath = imageList[index];
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.all(5),
                          color: _imagePath == imageList[index]
                              ? Colors.amber
                              : null,
                          child: Container(
                            child: Image.asset(
                              imageList[index],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )));
                },
              )),
          ElevatedButton(
              onPressed: () {
                TodoItem todoItem = TodoItem(
                    todo: todoController.value.text,
                    achieved: false,
                    imagePath: _imagePath);

                var condition = todoItem.achieved == null &&
                    todoItem.todo == null &&
                    todoItem.imagePath == null;
                condition ? null : context.read<Todos>().addTodo(todoItem);
              },
              child: Text('저장'))
        ],
      )),
    );
  }

  _radioChange(int? value) {
    setState(() {
      _radioValue = value!;
    });
  }
}
