import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:todo/addEditTask.dart';
import 'package:todo/task.dart';

class taskPage extends StatefulWidget {
  const taskPage({Key? key}) : super(key: key);

  @override
  State<taskPage> createState() => _taskPageState();
}

class _taskPageState extends State<taskPage> {
  List<Task>? tasks = [];
  Task ts = new Task();
  @override
  void initState() {
    super.initState();
    get();
  }

  void get() async {
    tasks = await fetchProducts();
    setState(() {});
  }

  Future<List<Task>?> fetchProducts() async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response;

    Task i = new Task();
    if (response.statusCode == 200) {
      List<Task>? tasks = i.parseProducts(response.body);
      try {} catch (x) {}

      return tasks;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task List'),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded(
              //   child: Container(
              //     color: Colors.red,
              //   ),
              // ),

              Container(child: Image.asset('lib/assets/images/taskTheme.png')),

              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                child: Container(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      ts = new Task();
                      ts.name = '';

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => addEditTask(
                                tasks: tasks, savedorupdate: false, tsk: ts)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 200),
                      shape: const CircleBorder(),
                    ),
                    child: Text('New Task'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
