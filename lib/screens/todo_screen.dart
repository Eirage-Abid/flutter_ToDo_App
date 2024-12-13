/**import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid; // Get user ID

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks from Firestore
  }

  Future<void> _loadTasks() async {
    if (userId == null) return;

    try {
      final snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .get();

      setState(() {
        tasks.clear();
        tasks.addAll(snapshot.docs.map((doc) {
          return {'id': doc.id, ...doc.data()};
        }));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load tasks: $e')),
      );
    }
  }

  Future<void> addTask() async {
    if (taskController.text.isNotEmpty && userId != null) {
      try {
        final taskData = {'title': taskController.text, 'completed': false};
        final docRef = await firestore
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .add(taskData);

        setState(() {
          tasks.add({'id': docRef.id, ...taskData});
          taskController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add task: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task cannot be empty!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> toggleTaskCompletion(int index) async {
    if (userId == null) return;

    try {
      final taskId = tasks[index]['id'];
      final updatedStatus = !tasks[index]['completed'];

      await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update({'completed': updatedStatus});

      setState(() {
        tasks[index]['completed'] = updatedStatus;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task: $e')),
      );
    }
  }

  Future<void> deleteTask(int index) async {
    if (userId == null) return;

    try {
      final taskId = tasks[index]['id'];

      await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();

      setState(() {
        tasks.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task deleted!'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task: $e')),
      );
    }
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
}**/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid; // Get user ID

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks with a real-time listener
  }

  void _loadTasks() {
    if (userId == null) return;

    // Real-time listener for tasks
    firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('timestamp', descending: true) // Sort tasks by newest first
        .snapshots()
        .listen((snapshot) {
      setState(() {
        tasks.clear();
        tasks.addAll(snapshot.docs.map((doc) {
          return {'id': doc.id, ...doc.data()};
        }));
      });
    });
  }

  Future<void> addTask() async {
    if (taskController.text.isNotEmpty && userId != null) {
      try {
        final taskData = {
          'title': taskController.text,
          'completed': false,
          'timestamp': FieldValue.serverTimestamp(), // Add timestamp for sorting
        };

        await firestore
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .add(taskData);

        taskController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add task: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task cannot be empty!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> toggleTaskCompletion(int index) async {
    if (userId == null) return;

    try {
      final taskId = tasks[index]['id'];
      final updatedStatus = !tasks[index]['completed'];

      await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update({'completed': updatedStatus});

      // No need to call setState here; the real-time listener handles it
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task: $e')),
      );
    }
  }

  Future<void> deleteTask(int index) async {
    if (userId == null) return;

    try {
      final taskId = tasks[index]['id'];

      await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();

      // No need to call setState here; the real-time listener handles it

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task deleted!'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task: $e')),
      );
    }
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

