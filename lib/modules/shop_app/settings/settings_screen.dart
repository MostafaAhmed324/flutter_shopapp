import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:mos/layout/shop_app/cubit/cubit.dart';
import 'package:mos/layout/shop_app/cubit/states.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/componantes/constance.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var model = ShopCubit.get(context).userModel;
        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => ShopCubit.get(context).userModel != null,
            widgetBuilder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(height: 20.0,),
                      defaultFormField(
                        controller: nameController,
                        textType: TextInputType.text,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'name Must not be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(height: 10.0,),
                      defaultFormField(
                        controller: emailController,
                        textType: TextInputType.emailAddress,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'email Must not be empty';
                          }
                          return null;
                        },
                        label: 'Email',
                        prefix: Icons.email,
                      ),
                      SizedBox(height: 10.0,),defaultFormField(
                        controller: phoneController,
                        textType: TextInputType.phone,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Phone Must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      SizedBox(height: 20.0,),
                      defaultButton(
                          onPressed: ()
                          {
                            if(formKey.currentState!.validate())
                              {
                                ShopCubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);
                              }
                          },
                          text: 'Update'
                      ),

                      SizedBox(height: 20.0,),
                      defaultButton(
                          onPressed: ()
                          {
                            signOut(context);
                          },
                          text: 'Logout'
                      ),

                    ],
                  ),
                ),
              ),
            ),
            fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
