import 'package:dio/dio.dart';
import 'package:projetosflutter/API/constans.dart';
import '../modelo_user.dart';

// Conexão com a API
class ApiServices {
  Dio dio = Dio();

  Future<UserClass?> getUser({required String user}) async {
    try {
      var response = await dio.get(Apiconstants.urlBaseMock(user));

      if (response.statusCode == 200) {
        if (response.data is List) {
          List<dynamic> dataList = response.data;

          if (dataList.isNotEmpty) {
            return UserClass.fromJson(dataList[0]);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

