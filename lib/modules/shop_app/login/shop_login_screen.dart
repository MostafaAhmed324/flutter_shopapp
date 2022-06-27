import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mos/layout/shop_app/shop_layout.dart';
import 'package:mos/modules/shop_app/login/cubit/cubit.dart';
import 'package:mos/modules/shop_app/login/cubit/states.dart';
import 'package:mos/modules/shop_app/register/shop_register_screen.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.model.status)
            {
              print(state.model.message);
              print(state.model.data!.token);
              showToast(msg: state.model.message,color: Colors.green);
              CacheHelper.saveData(key: 'token', value: state.model.data!.token).then((value)
              {
                navigateAndFinish(context, ShopLayout());
              });
            }else
              {
                print(state.model.message);
                showToast(msg: state.model.message,color: Colors.red);
              }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
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
                        'Login',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        'Login Now To Browse Our Hot Offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
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
                        obscure: ShopLoginCubit.get(context).isPassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        suffixPressed: (){
                          ShopLoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      SizedBox(height: 30.0,),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) => state is! ShopLoginLoadingState,
                        widgetBuilder: (context) => defaultButton(
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                              }
                            },
                            text: 'LOGIN',
                        ),
                        fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(height: 15.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?'),
                          defaultTextButton(
                            onPressed: ()
                            {
                              navigateTo(context, ShopRegisterScreen());
                            },
                            text: 'Register Now!',
                          ),
                        ],
                      ),
                    ],
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
