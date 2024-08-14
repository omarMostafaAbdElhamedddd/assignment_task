
import 'package:assignment_task/features/auth/customWidgets/customButton.dart';
import 'package:assignment_task/features/auth/customWidgets/customText.dart';
import 'package:assignment_task/features/auth/customWidgets/customTextFormField.dart';
import 'package:assignment_task/features/auth/login/states_login.dart';
import 'package:assignment_task/utilities/consts.dart';
import 'package:assignment_task/utilities/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../get_grades_and_search/manager/grade_model.dart';
import '../manageGrade/logicGrades/manage_grade.dart';


class UpdateGradeView extends StatefulWidget {
  const UpdateGradeView({super.key, required this.grade});
final Grade grade;
  @override
  State<UpdateGradeView> createState() => _UpdateGradeViewState();
}

class _UpdateGradeViewState extends State<UpdateGradeView> {
  String? arName ;
  String? enName ;

  GlobalKey<ScaffoldMessengerState> scaffoldMessager = GlobalKey();
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: scaffoldMessager,
      child: Material(
        color: secondaryColor,
        child: SafeArea(child: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (

                ){
              Navigator.pop(context);
            },
              icon: Icon(Icons.arrow_back_outlined,color: Colors.black,),),
            backgroundColor: Colors.transparent ,
            elevation: 0,

          ),

          body:  SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomVerticalSizeBox(padding: 1,),
                  CustomText(text: 'Grade name in arabic',fontSize: 18,),
                  CustomTextFormField(
                    onChanged: (value){
                      arName = value;
                    },
                    initValue: widget.grade.nameAr ,

                    // hintTextDirection: TextDirection.rtl,
                    // textDirection:  TextDirection.rtl,
                    hintText: 'أكتب هنا',
                  ),
                  SizedBox(height: 20,),
                  CustomText(text: 'Grade name in english' , fontSize: 18,),
                  CustomTextFormField(
                    onChanged: (value){
                      enName = value;
                    },
                    initValue: widget.grade.nameEn,

                    hintText: 'Type here..',),
                  SizedBox(height: 40,),

                  BlocProvider(create: (context)=>ManageGradeCubit() , child: BlocBuilder<ManageGradeCubit ,AuthStatee>(
                    builder: (context, state){
                      if(state.status == AuthStatus.loading){
                        return Center(child: CircularProgressIndicator(color: primaryColor,),);
                      }else{
                        return CustomButton(text: 'Update Grade', borderRadius: 32,onTap: (){
                          context.read<ManageGradeCubit>().updateGrade(arName??widget.grade.nameAr,enName ?? widget.grade.nameEn,scaffoldMessager,widget.grade.id,widget.grade.schoolId, context);
                        },);
                      }
                    },
                  ),)

                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
