import 'package:meuapp/model/feriado_model.dart';
import 'package:meuapp/model/feriado_repository.dart';

class FeriadoController {
  final repository = FeriadoRepository();

  Future<List<FeriadoModel>> getFeriados() async {
    return await repository.getFeriados();
  }
}