import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/layout/shop_app/cubit/cubit.dart';
import 'package:mos/layout/shop_app/cubit/states.dart';
import 'package:mos/modules/shop_app/login/shop_login_screen.dart';
import 'package:mos/modules/shop_app/search/search_screen.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps,),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: 'Favorite'),
              BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Settings'),
            ],
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
