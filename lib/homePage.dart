import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bengali/model/todo_model.dart';
import 'package:todo_bengali/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controler = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: const Text('Add ToDo List'),
          content: TextField(
            controller: _controler,
            decoration: const InputDecoration(
                labelText: 'Write Your ToDo Item',
                border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_controler.text.isEmpty) {
                  return;
                }
                context.read<ToDoProvider>().addToDoList(
                      ToDoModel(title: _controler.text, isCompleted: false),
                    );
                _controler.clear();
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.orangeAccent,
                Colors.green,
                Colors.red
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'To Do List ${[provider.toDoList.length]}',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: provider.toDoList.isEmpty
                      ? const SizedBox(
                          //  height: double.infinity,
                          //  width: double.infinity,
                          child: Center(
                            child: Text(
                              'Add Your ToDo Item From + Button',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, itemIndex) {
                            return ListTile(
                              onTap: () {
                                provider.toDoStatusChanges(
                                    provider.toDoList[itemIndex]);
                              },
                              leading: Checkbox(
                                value: provider.toDoList[itemIndex].isCompleted,
                                onChanged: (selected) {
                                  provider.toDoStatusChanges(
                                      provider.toDoList[itemIndex]);
                                },
                              ),
                              title: Text(
                                provider.toDoList[itemIndex].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  decoration:
                                      provider.toDoList[itemIndex].isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  provider.removeToDoList(
                                      provider.toDoList[itemIndex]);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          },
                          itemCount: provider.toDoList.length,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add ToDo Items',
        backgroundColor: Colors.green,
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
