import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // List to store todo items with a bool to track completion
  List<Map<String, dynamic>> todoItems = [];

  // Controller to handle input for new todo
  final TextEditingController _textController = TextEditingController();

  // Function to show the dialog to add a new todo
  void _addTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Todo'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: 'Enter todo item'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  todoItems
                      .add({'task': _textController.text, 'completed': false});
                  _textController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to toggle the completion of a todo item
  void _toggleCompletion(int index) {
    setState(() {
      todoItems[index]['completed'] = !todoItems[index]['completed'];
    });
  }

  // Function to remove a todo item
  void _removeTodoItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: todoItems[index]['completed'],
              onChanged: (bool? value) {
                _toggleCompletion(index);
              },
            ),
            title: Text(
              todoItems[index]['task'],
              style: TextStyle(
                decoration: todoItems[index]['completed']
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => _removeTodoItem(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoDialog,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
