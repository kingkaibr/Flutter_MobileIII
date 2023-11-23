import 'package:flutter/material.dart';
import 'package:meuapp/controller/feriado_controller.dart';
import 'package:meuapp/model/feriado_model.dart';

class FeriadoPage extends StatefulWidget {
  @override
  _FeriadoPageState createState() => _FeriadoPageState();
}

class _FeriadoPageState extends State<FeriadoPage> {
  late FeriadoController controller;

  @override
  void initState() {
    super.initState();
    controller = FeriadoController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feriados'),
      ),
      body: FutureBuilder<List<FeriadoModel>>(
        future: controller.getFeriados(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final feriado = snapshot.data![index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(feriado.nome),
                    subtitle: Text(feriado.type == 'national' ? 'Nacional' : 'Outro'),
                    leading: CircleAvatar(
                      child: Text(
                        '${feriado.data.day.toString().padLeft(2, '0')}/${feriado.data.month.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error?.toString() ?? 'Erro desconhecido'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}
