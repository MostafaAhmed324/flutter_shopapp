
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mos/layout/shop_app/cubit/cubit.dart';
import 'package:mos/models/shop_app/search_model.dart';
import 'package:mos/modules/shop_app/search/cubit/cubit.dart';
import 'package:mos/modules/shop_app/search/cubit/states.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        textType: TextInputType.text,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return 'Please enter text to search';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onSubmit:(String text)
                        {
                          SearchCubit.get(context).Search(text);
                        } ,
                    ),
                    SizedBox(height: 10.0,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => builedSearchItem(SearchCubit.get(context).searchModel!.data!.data![index],context,isOldPrice: false),
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget builedSearchItem(Product model,context,{bool isOldPrice=false}) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120.0,
                height: 120.0,
              ),
              if(model.discount != 0 && isOldPrice==true)
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
                  '${model.name}',
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
                      '${model.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.2,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    if(model.discount != 0 && isOldPrice==true)
                      Text(
                        '${model.oldPrice}',
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
                      backgroundColor: ShopCubit.get(context).favourites[model.id]==true?defaultColor:Colors.grey,
                      child: IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavourites(model.id);
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