import 'package:assignment_task/features/auth/customWidgets/customText.dart';
import 'package:assignment_task/features/auth/login/storeAndRetriveToken.dart';
import 'package:assignment_task/utilities/consts.dart';
import 'package:assignment_task/utilities/device_size.dart';
import 'package:flutter/material.dart';

import '../get_grades_and_search/gradesView.dart';




class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    StoreAndRetriveToken.getAuthToken();
    StoreAndRetriveToken.getschool_id();
    SizeConfig().init(context);
    return Material(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.screenHeight! * .2),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: primaryColor),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.only(left: 20 , right:SizeConfig.screenWidth!*.16),
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                      size: 34,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(text: 'Home Page' , fontSize: 21,fontWeight: FontWeight.w500,),
                    CustomText(text: 'Head Teacher',color: Color(0xff693B3C),fontSize: 18,),
                  ],
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.push(context, PageRouteBuilder(pageBuilder: (context,an,sc){
                  return ManageGrades();
                }));
              },
              child: Card(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                margin: EdgeInsets.symmetric(horizontal: 15),
                color: Color(0xffF7F1F9),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 10),
                  child: Row(
                    children: [

                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xffEBDDFF),
                          child: Icon(Icons.table_restaurant , color: Color(0xff529AB6),)),
                      SizedBox(width: 24,),
                      CustomText(text: 'Grades' ,fontSize: 22,fontWeight: FontWeight.w400,),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded),
                      SizedBox(width: 8,),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),),
      ),
    );
  }
}
