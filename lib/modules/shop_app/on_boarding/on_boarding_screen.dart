
import 'package:flutter/material.dart';
import 'package:mos/modules/shop_app/login/shop_login_screen.dart';
import 'package:mos/shared/componantes/componantes.dart';
import 'package:mos/shared/network/local/cache_helper.dart';
import 'package:mos/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoradingModel
{

  late String image;
  late String title;
  late String body;
  BoradingModel({required this.image,required this.title,required this.body,});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast=false;

  List<BoradingModel> boarding=[
    BoradingModel(image: 'images/female.png', title: 'Screen title 1', body: 'Screen body 1'),
    BoradingModel(image: 'images/female.png', title: 'Screen title 2', body: 'Screen body 2'),
    BoradingModel(image: 'images/female.png', title: 'Screen title 3', body: 'Screen body 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: ()
          {
            Submit();
          }
          , child: Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index) => builedBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                  if(index == boarding.length-1) {
                    setState(() {
                      isLast =true;
                    });
                  }
                  else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: ()
                    {
                      if(isLast)
                        Submit();
                      else {
                      boardController.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget builedBoardingItem(BoradingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(height: 30.0,),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0,),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );

  void Submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });

  }
}
