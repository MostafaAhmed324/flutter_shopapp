import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:mos/layout/shop_app/cubit/cubit.dart';
import 'package:mos/layout/shop_app/cubit/states.dart';
import 'package:mos/models/shop_app/categories_model.dart';
import 'package:mos/models/shop_app/home_model.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavouritesState)
        {
          if(state.model.status==false)
          {
            showToast(msg: state.model.message, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          widgetBuilder: (context) => productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
          fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model,CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items: model!.data.banners.map<Widget>((e)
          {
            return Image(
              image: NetworkImage('${e['image']}'),
              width: double.infinity,
            );
          }).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            reverse: false,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,

          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          'Categories',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          height: 100.0,
          child: ListView.separated(
              itemBuilder: (context, index) => buildCategoriesItem(categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => SizedBox(width: 10.0,),
              itemCount: categoriesModel!.data.data.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          'New Products',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          color: Colors.white,
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1/1.58,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            crossAxisCount: 2,
            children: List.generate(
              model.data.products.length,
                  (index)=>buildGridProduct(model.data.products[index],context),
            ),
          ),
        ),
      ],
    ),
  );
  
  Widget buildCategoriesItem(DataModel model) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        fit: BoxFit.cover,
        height: 100.0,
        width: 100.0,
      ),
      Container(
        width: 100.0,
        height: 20.0,
        color: Colors.black.withOpacity(.7),
        child: Center(
          child: Text(
            model.name,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
  
  Widget buildGridProduct(Map<String,dynamic> model,context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image(
            image: NetworkImage('${model['image']}'),
            width: double.infinity,
            height: 200.0,
          ),
          if(model['price'] != model['old_price'])
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
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model['name'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                height: 1.2,
              ),
            ),
            Row(
              children: [
                Text(
                  '${model['price']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.2,
                    color: defaultColor,
                  ),
                ),
                SizedBox(width: 5.0,),
                if(model['price'] != model['old_price'])
                  Text(
                    '${model['old_price']}',
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
                  backgroundColor: ShopCubit.get(context).favourites[model['id']]==true? defaultColor:Colors.grey,
                  child: IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavourites(model['id']);
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
  );
}