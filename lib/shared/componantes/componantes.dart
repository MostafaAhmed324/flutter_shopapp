

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback onPressed,
  required String text,
}) => Container(
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      '${text.toUpperCase()}',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: background,
  ),
);

Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType textType,
  Function(String)? onSubmit,
  VoidCallback? onTap,
  required String? Function(String?) validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool obscure=false,
  Function(String)? onChange,
  void Function()? suffixPressed


}) => TextFormField(
  controller: controller,
  keyboardType: textType,
  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefix),
    suffixIcon: suffix !=null? IconButton(onPressed: suffixPressed, icon: Icon(suffix,),):null,
  ),
  validator: validator,
  onFieldSubmitted: onSubmit,
  obscureText: obscure,
  onTap: onTap,
  onChanged: onChange,
);



void navigateTo(context , widget) => Navigator.push(
    context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
    (route){return false;},
);

Widget defaultTextButton({required void Function()? onPressed,required String text}) => TextButton(onPressed: onPressed, child: Text('$text'),);

void showToast({
  required String msg,
  required Color? color,
}) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);