//Conectar Screen com API;
import 'package:projetosflutter/API/Json/api_services.dart';
import 'package:projetosflutter/API/constans.dart';

class GenericController<T> {
  final String endpoint;
  final T Function(Map<String, dynamic>) fromJson;
  final ApiServices _api = ApiServices();

  //Gerando construtor.
  GenericController({required this.endpoint, required this.fromJson});

  //Consultando todos so tipo
  Future<List<T>> getAll() async {
    return await _api.getList(endpoint: endpoint, fromJson: fromJson);
  }

  //Consultando apenas 1 por ID
  Future<T?> getOne(String id) async {
    return await _api.getSingle(endpoint: '$endpoint/$id', fromJson: fromJson);
  }

  //Fazendo o Update.
  Future<T?> update(String id, Map<String, dynamic> data) async {
    try {
      final response = await _api.dio.put(
        Apiconstants.urlBaseMock('$endpoint/$id'),
        data: data,
      );

      if (response.statusCode == 200) {
        return fromJson(response.data);
      }
    } catch (e) {
      print('Erro ao atualizar item: $e');
    }
    return null;
  }

  //Fazendo o criar.
  Future<T?> create(Map<String, dynamic> data) async {
    try {
      final response = await _api.dio.post(
        Apiconstants.urlBaseMock(endpoint),
        data: data,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return fromJson(response.data);
      }
    } catch (e) {
      print('Erro ao atualizar item: $e');
    }
    return null;
  }
}
