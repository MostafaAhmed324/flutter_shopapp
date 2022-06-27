import 'package:mos/models/shop_app/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterIntialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates
{
  ShopLoginModel model;
  ShopRegisterSuccessState(this.model);
}
class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopIsRegisterPasswordVisibilityState extends ShopRegisterStates{}
