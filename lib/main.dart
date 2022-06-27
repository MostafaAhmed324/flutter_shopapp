import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mos/layout/shop_app/cubit/cubit.dart';
import 'package:mos/layout/shop_app/cubit/states.dart';
import 'package:mos/layout/shop_app/shop_layout.dart';
import 'package:mos/modules/shop_app/login/shop_login_screen.dart';
import 'package:mos/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:mos/shared/bloc_observer.dart';
import 'package:mos/shared/network/local/cache_helper.dart';
import 'package:mos/shared/network/remote/dio_helper.dart';
import 'package:mos/shared/styles/themes.dart';


void main() async {
  BlocOverrides.runZoned(
        () async{
      // Use blocs...
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      String? token = CacheHelper.getData(key: 'token');
      print(token);
      Widget widget=ShopLoginScreen();
      if(onBoarding != null)
      {
        if(token != null) widget = ShopLayout();
        else{
          widget=ShopLoginScreen();
        }
      }else
      {
        widget = OnBoardingScreen();
      }
      runApp(MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  final Widget startWidget;


  MyApp({required this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavourites()..getUserData()),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighttheme,
            home: startWidget,
          );
        },
      ),
    );
  }

}