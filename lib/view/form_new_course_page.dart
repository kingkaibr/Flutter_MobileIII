import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';

import '../model/course_model.dart';

class FormNewCoursePage extends StatefulWidget {
  const FormNewCoursePage({super.key});

  @override
  State<FormNewCoursePage> createState() => _FormNewCoursePageState();
}

class _FormNewCoursePageState extends State<FormNewCoursePage> {
  CourseController controller = CourseController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescriptionController = TextEditingController();
  TextEditingController textStartAtController = TextEditingController();

  postNewCourse() async {
    try {
      await controller.postNewCourse(
        CourseEntity(
          name: textNameController.text,
          description: textDescriptionController.text,
          start_at: textStartAtController.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados salvos!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$e')));
    }
  }


  DateTime? selectedDate; // This will hold the selected date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textStartAtController.text = formatDate(picked); // Format the date as needed
      });
    }
  }

  String formatDate(DateTime date) {
    // Customize the date format as needed
    return "${date.day}/${date.month}/${date.year}";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Curso"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 15),
          child: Column(
            children: [
              TextFormField(
                controller: textNameController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 17),
                  filled: true,
                  hintText: 'Informe o nome',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome..';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: textDescriptionController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 17),
                  filled: true,
                  hintText: 'Informe a descrição',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a descrição..';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: textStartAtController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 17),
                  filled: true,
                  hintText: 'Informe a data início',
                ),
                onTap: () => _selectDate(context),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 45,
                child: ElevatedButton(
                  //copiar da tela de login
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      postNewCourse();
                    }
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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