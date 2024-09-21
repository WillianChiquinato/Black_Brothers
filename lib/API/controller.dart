//Conectar Screen com API;
import 'package:flutter/cupertino.dart';
import 'package:projetosflutter/API/%20Json/Api_Services.dart';
import 'modelo_User.dart';

class Controller extends ChangeNotifier {
  ApiServices apiService = ApiServices();

  ValueNotifier<ApiModel?> UserAddress = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> searchApi({required String user}) async {
    isLoading.value = true;

    ApiModel? Apimodel = await apiService.getUser(user: user);

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
