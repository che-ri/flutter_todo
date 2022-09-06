import 'package:flutter/foundation.dart';
import '../todoItem.dart';

//스토어에 있는 값이 변했을 때, UI도 변경시켜주고싶다면, ChangeNotifierProvider을 이용해야한다.
//ChangeNotifierProvider는 ChangeNotifier의 notifyListeners()를 기다리다가,
//notifyListeners()가 호출되면, 자신의 자식을 재빌드하여 UI를 업데이트해주기 때문이다.
//ChangeNotifier는 with(믹스인) 또는 extends(상속)할 수 있다.
class Todos extends ChangeNotifier {
  final List<TodoItem> _todos = [
    TodoItem(
        todo: '출근하기',
        achieved: true,
        imagePath: 'assets/images/emoji_think.png')
  ];

  List<TodoItem> get todos => _todos;

  void addTodo(TodoItem todo) {
    _todos.add(todo);
    // notifyListeners(); //상태가 변했다는 것을 ChangeNotifierProvider에 알려주기 위해 notifyListeners()을 호출한다.
  }

  void delTodo(int index) {
    _todos.removeAt(index);
    // notifyListeners(); //상태가 변했다는 것을 ChangeNotifierProvider에 알려주기 위해 notifyListeners()을 호출한다.
  }
}
