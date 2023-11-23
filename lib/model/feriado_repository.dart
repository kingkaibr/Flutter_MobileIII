import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:meuapp/model/feriado_model.dart';

class FeriadoRepository {
  Future<List<FeriadoModel>> getFeriados() async {
    final url = Uri.parse('https://brasilapi.com.br/api/feriados/v1/2023');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final feriados = <FeriadoModel>[];

      for (final feriado in json) {
        feriados.add(FeriadoModel(
          nome: feriado['name'],
          data: DateTime.parse(feriado['date']),
          type: feriado['type'],
        ));
      }
      return feriados;
    } else {
      throw Exception('Erro ao acessar a API');
    }
  }
}
