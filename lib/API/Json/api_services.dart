import 'package:dio/dio.dart';
import 'package:projetosflutter/API/constans.dart';
import 'package:projetosflutter/API/Storage/JWT-Auth.dart';

class ApiServices {
  final Dio dio = Dio();
  final TokenStorage _tokenStorage = TokenStorage();

  ApiServices() {
    // Interceptor para adicionar o token JWT automaticamente
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await _tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  Future<T?> getSingle<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await dio.get(Apiconstants.urlBaseAPI(endpoint));

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
      final response = await dio.get(Apiconstants.urlBaseAPI(endpoint));

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List).map((json) => fromJson(json)).toList();
      }
    } catch (e) {
      print('Erro ao buscar lista: $e');
    }
    return [];
  }
}
