import 'dart:ffi';

import 'package:app/todoItem.dart';
import 'package:flutter/material.dart';
import 'todoItem.dart';

//provider
import 'package:app/provider/todos.dart';
import 'package:provider/provider.dart';

class TodoWritePage extends StatefulWidget {
  final Map<String, dynamic>? args;
  const TodoWritePage({Key? key, required this.args}) : super(key: key);

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
  var todo_list;
  int? todo_index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo_list = context.read<Todos>().todos;

    // 초기값 설정
    if (widget.args!["index"] is Null) {
      _imagePath = imageList[0];
      _radioValue = 0;
    } else {
      todo_index = widget.args!['index'];

      _imagePath = todo_list[todo_index].imagePath!;
      _radioValue = todo_list[todo_index].achieved!;
      todoController.text = todo_list[todo_index].todo;
    }

/**
 * Question!
 * 💩Error! iniState에서는 사용할 수 없음. 그렇다고 build에서 사용하면 state변경시마다 rebuild되므로, state 수정이 안먹힘 ㅠ__ㅠ;
 * 
 * FlutterError (dependOnInheritedWidgetOfExactType<_ModalScopeStatus>() or dependOnInheritedElement() was called before _TodoWritePageState.initState() completed.
When an inherited widget changes, for example if the value of Theme.of() changes, its dependent widgets are rebuilt. If the dependent widget's reference to the inherited widget is in a constructor or an initState() method, then the rebuilt dependent widget will not reflect the changes in the inherited widget.
Typically references to inherited widgets should occur in widget build() methods. Alternatively, initialization based on inherited widgets can be placed in the didChangeDependencies method, which is called after initState and whenever the dependencies change thereafter.)
 */
    // is_edit = ModalRoute.of(context)!.settings.arguments.toString();
    // todo_index = int.parse(is_edit);
    // todo_list = context.watch<Todos>().todos;

    // // 초기값 설정
    // if (is_edit is String) {
    //   _imagePath = todo_list[todo_index].imagePath!;
    //   _radioValue = todo_list[todo_index].achieved!;
    //   todoController.text = todo_list[todo_index].todo;
    // } else {
    //   _imagePath = imageList[0];
    //   _radioValue = 0;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('투두 작성')),
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
              Text('진행중'),
              Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
              Text('완료')
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
                _saveTodo();
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

  _saveTodo() {
    TodoItem todoItem = TodoItem(
        todo: todoController.value.text,
        achieved: _radioValue,
        imagePath: _imagePath);

    var condition = todoItem.achieved == null &&
        todoItem.todo == null &&
        todoItem.imagePath == null;

    if (widget.args!["index"] is Null) {
      context.read<Todos>().addTodo(todoItem);
      Navigator.of(context).pop();
    } else {
      context.read<Todos>().editTodo(todo_index!, todoItem);

      //Question!
      Navigator.of(context).pop();
      Navigator.of(context).popAndPushNamed('/detail',
          arguments: {'index': widget.args!["index"].toString()});
    }
  }
}
