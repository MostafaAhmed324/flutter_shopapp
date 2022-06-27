import 'package:mos/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginIntialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates
{
  ShopLoginModel model;
  ShopLoginSuccessState(this.model);
}
class ShopLoginErrorState extends ShopLoginStates
{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopIsPasswordVisibilityState extends ShopLoginStates{}