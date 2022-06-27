import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:mos/layout/shop_app/cubit/cubit.dart';
import 'package:mos/layout/shop_app/cubit/states.dart';
import 'package:mos/models/shop_app/favourites_model.dart';
import 'package:mos/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! ShopLoadingGetFavouritesState,
          widgetBuilder:  (context) => ListView.separated(
            itemBuilder: (context, index) => builedFavItem(ShopCubit.get(context).favouritesModel!.data!.data![index],context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.black,
              ),
            ),
            itemCount: ShopCubit.get(context).favouritesModel!.data!.data!.length,
          ),
          fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builedFavItem(FavouritesData model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${model.product!.image}'),
                width: 120.0,
                height: 120.0,
              ),
              if(model.product!.discount != 0)
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.2,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product!.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.2,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    if(model.product!.discount != 0)
                    Text(
                      '${model.product!.oldPrice}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.2,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favourites[model.product!.id]==true?defaultColor:Colors.grey,
                      child: IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavourites(model.product!.id);
                        },
                        icon: Icon(Icons.favorite_border,),
                        iconSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}