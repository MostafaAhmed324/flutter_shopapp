import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/layout/shop_app/cubit/states.dart';
import 'package:mos/models/shop_app/categories_model.dart';
import 'package:mos/models/shop_app/change_favourites_model.dart';
import 'package:mos/models/shop_app/favourites_model.dart';
import 'package:mos/models/shop_app/home_model.dart';
import 'package:mos/models/shop_app/profile_model.dart';
import 'package:mos/modules/shop_app/categories/categories_screen.dart';
import 'package:mos/modules/shop_app/favorites/favorites_screen.dart';
import 'package:mos/modules/shop_app/products/products_screen.dart';
import 'package:mos/modules/shop_app/settings/settings_screen.dart';
import 'package:mos/shared/componantes/constance.dart';
import 'package:mos/shared/network/end_points.dart';
import 'package:mos/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopIntialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
  List<Widget> bottomScreens=
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int,bool> favourites={};


  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,

    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element)
      {
        favourites.addAll(
            {
              element['id']:element['in_favorites']
            });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,

    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;

  void changeFavourites(int productId)
  {
    if(favourites[productId] ==true)
    {
      favourites[productId] = false;
    }else {
      favourites[productId] =true;
    }

    emit(ShopChangeFavouritesState());

    DioHelper.postData
      (url: FAVORITES,
        data:
        {
          'product_id':productId
        },
      token: token,
    ).then((value)
    {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      if(!changeFavouritesModel!.status)
      {
        if(favourites[productId] ==true)
        {
          favourites[productId] = false;
        }else {
          favourites[productId] =true;
        }
      }else{
        getFavourites();
      }

      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError((erorr)
    {
      if(favourites[productId] ==true)
      {
        favourites[productId] = false;
      }else {
        favourites[productId] =true;
      }
      emit(ShopErrorChangeFavouritesState());
      print(erorr.toString());
    });
  }

  FavouritesModel? favouritesModel;

  void getFavourites()
  {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,

    ).then((value)
    {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavouritesState());
    });
  }

  ProfileModel? userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,

    ).then((value)
    {
      userModel = ProfileModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
})
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:{
        'email':email,
        'phone':phone,
        'name':name,
      }

    ).then((value)
    {
      userModel = ProfileModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}