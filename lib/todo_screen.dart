import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks when the app starts
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');

    if (tasksString != null) {
      final List<dynamic> tasksJson = jsonDecode(tasksString);
      setState(() {
        tasks.clear();
        tasks.addAll(tasksJson.map((task) => Map<String, dynamic>.from(task)));
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksString = jsonEncode(tasks);
    await prefs.setString('tasks', tasksString);
  }

  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add({'title': taskController.text, 'completed': false});
        taskController.clear();
      });
      _saveTasks(); // Save tasks after adding
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task cannot be empty!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
    _saveTasks(); // Save tasks after updating completion status
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks(); // Save tasks after deleting
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do App')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => Card(
                color: tasks[index]['completed']
                    ? Colors.grey.shade300
                    : Colors.primaries[index % Colors.primaries.length]
                    .shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: tasks[index]['completed'],
                    onChanged: (_) => toggleTaskCompletion(index),
                  ),
                  title: Text(
                    tasks[index]['title'],
                    style: TextStyle(
                      decoration: tasks[index]['completed']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTask(index),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Enter task',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: addTask,
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
