import 'package:mos/models/shop_app/change_favourites_model.dart';

abstract class ShopStates{}

class ShopIntialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavouritesState extends ShopStates{}
class ShopSuccessChangeFavouritesState extends ShopStates
{
  final ChangeFavouritesModel model;
  ShopSuccessChangeFavouritesState(this.model);
}
class ShopErrorChangeFavouritesState extends ShopStates{}

class ShopLoadingGetFavouritesState extends ShopStates{}
class ShopSuccessGetFavouritesState extends ShopStates{}
class ShopErrorGetFavouritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{}
class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{}
class ShopErrorUpdateUserState extends ShopStates{}
