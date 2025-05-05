import 'package:dio/dio.dart';
import 'package:projetosflutter/API/constans.dart';

class ApiServices {
  final Dio dio = Dio();

  Future<T?> getSingle<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await dio.get(Apiconstants.urlBaseMock(endpoint));

      if (response.statusCode == 200) {
        if (response.data is List && response.data.isNotEmpty) {
          return fromJson(response.data[0]);
        } else if (response.data is Map<String, dynamic>) {
          return fromJson(response.data);
        }
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }
    return null;
  }

  Future<List<T>> getList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await dio.get(Apiconstants.urlBaseMock(endpoint));

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Erro ao buscar lista: $e');
    }
    return [];
  }
}


