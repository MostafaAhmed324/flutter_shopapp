import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/layout/shop_app/cubit/cubit.dart';
import 'package:mos/layout/shop_app/cubit/states.dart';
import 'package:mos/models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => cartBuilder(ShopCubit.get(context).categoriesModel!.data.data[index]),
        separatorBuilder: (context, index) => SizedBox(height: 5.0,),
        itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}

Widget cartBuilder(DataModel model) => Row(
  children: [
    Image(
      image: NetworkImage(model.image),
      fit: BoxFit.cover,
      height: 100.0,
      width: 100.0,
    ),
    SizedBox(width: 10.0,),
    Text(
      model.name,
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    Spacer(),
    Icon(
      Icons.arrow_forward_ios,
    ),
  ],
);