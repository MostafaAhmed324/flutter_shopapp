import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/models/shop_app/login_model.dart';
import 'package:mos/modules/shop_app/login/cubit/states.dart';
import 'package:mos/modules/shop_app/register/cubit/states.dart';
import 'package:mos/shared/network/end_points.dart';
import 'package:mos/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterIntialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? registerModel;

  void userLogin({required String email,required String password,required String phone,required String name})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData
      (
        url: REGISTER,
        data: {'email':email,'password':password,'phone':phone,'name':name,},
    ).then((value)
    {
      print(value.data);
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel!));
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopIsRegisterPasswordVisibilityState());

  }

}