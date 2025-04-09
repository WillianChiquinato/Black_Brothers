//Conectar Screen com API;
import 'package:flutter/cupertino.dart';
import 'package:projetosflutter/API/Json/api_services.dart';
import 'modelo_user.dart';

class UserController extends ChangeNotifier {
  ApiServices apiService = ApiServices();

  ValueNotifier<UserClass?> userAddress = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> searchApi({required String user}) async {
    isLoading.value = true;

    UserClass? apimodel = await apiService.getUser(user: user);

    if (apimodel != null) {
      userAddress.value = apimodel;
      isLoading.value = false;
      notifyListeners();
    } else {
      userAddress.value = null;
      isLoading.value = false;
      notifyListeners();
    }
  }
}
