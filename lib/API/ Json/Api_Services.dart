import 'package:dio/dio.dart';
import 'package:projetosflutter/API/constans.dart';
import '../modelo_User.dart';

//A parte da conexao do JSON;
class ApiServices {
  Dio dio = Dio();

  Future<UserClass?> getUser({required String user}) async {
    try {
      var response = await Dio().get(Apiconstants.urlBaseMock(user));

      if (response.statusCode == 200) {
        return UserClass.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
