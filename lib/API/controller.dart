//Conectar Screen com API;
import 'package:flutter/cupertino.dart';
import 'package:projetosflutter/API/%20Json/Api_Services.dart';
import 'modelo_User.dart';

class UserController extends ChangeNotifier {
  ApiServices apiService = ApiServices();

  ValueNotifier<UserClass?> UserAddress = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> searchApi({required String user}) async {
    isLoading.value = true;

    UserClass? Apimodel = await apiService.getUser(user: user);

    if (Apimodel != null) {
      UserAddress.value = Apimodel;
      isLoading.value = false;
      notifyListeners();
    } else {
      UserAddress.value = null;
      isLoading.value = false;
      notifyListeners();
    }
  }
}
