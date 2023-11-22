import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CourseEntity>> coursesFuture;
  CourseController controller = CourseController();

  Future<List<CourseEntity>> getCourses() async {
    return await controller.getCourseList();
  }

  @override
  void initState() {
    super.initState();
    coursesFuture = getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meu app"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: coursesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Slidable(
                      endActionPane:
                          ActionPane(motion: ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: null,
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                          icon: Icons.edit,
                          label: 'Alterar',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Confirmação"),
                                content: const Text(
                                    "Deseja realmente excluir esse curso?"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancelar")),
                                  TextButton(
                                      onPressed: () async {
                                        await controller.deleteCourse(
                                            snapshot.data![index].id!);
                                        Navigator.pop(context);
                                        //
                                      },
                                      child: Text("OK"))
                                ],
                              ),
                            ).then((value) async {
                              coursesFuture = getCourses();
                              setState(() { });
                            });
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Excluir',
                        ),
                      ]),
                      child: ListTile(
                        title: Text(snapshot.data![index].name ?? ''),
                        leading: const CircleAvatar(
                          child: Text("CS"),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        subtitle: Text(snapshot.data![index].description ?? ''),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
