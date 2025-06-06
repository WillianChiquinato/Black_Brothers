//Conectar Screen com API;
import 'dart:convert';

import 'package:dio/dio.dart';
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
        Apiconstants.urlBaseAPI('$endpoint/$id'),
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
        Apiconstants.urlBaseAPI(endpoint),
        data: data,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return fromJson(response.data);
      }
    } catch (e) {
      print('Erro ao criar item: $e');
    }
    return null;
  }

  //Fazendo uma busca especifica (No caso de login e senha).
  Future<List<T>> getByQuery(String query) async {
    try {
      final response = await _api.dio.get(
        Apiconstants.urlBaseAPI('$endpoint?$query'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data;
        return dataList.map((data) => fromJson(data)).toList();
      }
    } catch (e) {
      print('Erro ao buscar por query: $e');
    }
    return [];
  }

  //Pegar o login para o menu
  Future<int?> loginUsuario(String login, String senha) async {
    try {
      final response = await _api.dio.post(
        Apiconstants.urlBaseAPI(endpoint),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: jsonEncode({
          'login': login,
          'senha': senha,
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        return data['ID_Usuario'] as int?;
      } else {
        print('Erro: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
      return null;
    }
  }
}
