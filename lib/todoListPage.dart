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
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(widget.list[index].imagePath!,
                              height: 80, width: 80, fit: BoxFit.cover),
                          Text(widget.list[index].todo!),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.list.removeAt(index);
                                });
                              },
                              child: Text('삭제'))
                        ],
                      ))),
              onTap: () {
                AlertDialog dialog = AlertDialog(
                  content: Column(children: [
                    Image.asset(widget.list[index].imagePath!,
                        width: 100, height: 100, fit: BoxFit.cover),
                    Text(
                      widget.list[index].todo!,
                      style: TextStyle(fontSize: 30),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.list.removeAt(index);
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


// Container(
//             child: ListView.builder(
//           itemCount: todoList.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               child: Card(
//                   child: Container(
//                       height: 50,
//                       padding: EdgeInsets.only(
//                           left: 20, right: 20, top: 10, bottom: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(todoList[index].todo!),
//                           ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   todoList.removeAt(index);
//                                 });
//                               },
//                               child: Icon(Icons.delete))
//                         ],
//                       ))),
//             );
//           },
//         ))