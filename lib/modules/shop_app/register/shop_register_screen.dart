import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:mos/layout/shop_app/shop_layout.dart';
import 'package:mos/modules/shop_app/login/cubit/cubit.dart';
import 'package:mos/modules/shop_app/login/cubit/states.dart';
import 'package:mos/modules/shop_app/login/shop_login_screen.dart';
import 'package:mos/modules/shop_app/register/cubit/cubit.dart';
import 'package:mos/modules/shop_app/register/cubit/states.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener: (context, state)
          {
            if(state is ShopRegisterSuccessState)
            {
              if(state.model.status)
              {
                print(state.model.message);
                print(state.model.data!.token);
                showToast(msg: state.model.message,color: Colors.green);
                CacheHelper.saveData(key: 'token', value: state.model.data!.token).then((value)
                {
                  navigateAndFinish(context, ShopLoginScreen());
                });
              }else
              {
                print(state.model.message);
                showToast(msg: state.model.message,color: Colors.red);
              }
            }
          },
          builder: (context, state) => Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          'Register Now To Browse Our Hot Offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                          controller: nameController,
                          textType: TextInputType.emailAddress,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Enter Your Name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                          controller: phoneController,
                          textType: TextInputType.phone,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Enter Your Phone';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                          controller: emailController,
                          textType: TextInputType.emailAddress,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Enter Email Address';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email,
                        ),
                        SizedBox(height: 10.0,),
                        defaultFormField(
                          controller: passwordController,
                          textType: TextInputType.visiblePassword,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          obscure: ShopRegisterCubit.get(context).isPassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(height: 30.0,),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) => state is! ShopRegisterLoadingState,
                          widgetBuilder: (context) => defaultButton(
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userLogin(email: emailController.text, password: passwordController.text,phone: phoneController.text, name: nameController.text);
                              }
                            },
                            text: 'Register',
                          ),
                          fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
