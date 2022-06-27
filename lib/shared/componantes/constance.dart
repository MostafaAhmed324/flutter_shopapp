//https://newsapi.org/
// v2/top-headlines?
// country=eg&category=business&apiKey=e66c497f0e974197a563f906255b2e13

//https://newsapi.org/v2/everything?q=tesla&apiKey=e66c497f0e974197a563f906255b2e13

import 'package:mos/modules/shop_app/login/shop_login_screen.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    navigateAndFinish(context, ShopLoginScreen());
  });
}

String? token =CacheHelper.getData(key: 'token');