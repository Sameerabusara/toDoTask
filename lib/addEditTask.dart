import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo/task.dart';

class addEditTask extends StatefulWidget {
  final List<Task>? tasks;
  final bool? savedorupdate;
  final Task? tsk;
  addEditTask({Key? key, this.tasks, this.savedorupdate, this.tsk})
      : super(key: key);

  @override
  State<addEditTask> createState() => _addEditTaskState();
}

class _addEditTaskState extends State<addEditTask> {
  TextEditingController txtName = new TextEditingController();

  late FocusNode focus;

  @override
  void initState() {
    super.initState();
    txtName.text = widget.tsk!.name.toString();
    focus = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add & Edit'),
          centerTitle: true,
        ),
        body: Center(
          // child: Image.asset('lib/assets/images/taskTheme.png'),
          child: Column(
            children: [
              // TextField(
              //   controller: txtName,
              //   autofocus: true,
              //   decoration: const InputDecoration(hintText: 'Name'),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txtName,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
              ),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    Task ts = new Task();
                    if (widget.savedorupdate == true) {
                      ts.id = widget.tsk!.id.toString();
                      ts.name = txtName.text;

                      TaskDal dl = new TaskDal();
                      dl.editTask(ts);
                    } else {
                      ts = new Task();
                      ts.id = widget.tsk!.id.toString();
                      ts.name = txtName.text;

                      TaskDal dl = new TaskDal();
                      dl.addTask(ts);
                    }
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
