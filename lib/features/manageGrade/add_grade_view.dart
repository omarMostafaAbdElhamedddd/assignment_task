
import 'package:assignment_task/features/auth/customWidgets/customButton.dart';
import 'package:assignment_task/features/auth/customWidgets/customText.dart';
import 'package:assignment_task/features/auth/customWidgets/customTextFormField.dart';
import 'package:assignment_task/features/auth/login/states_login.dart';
import 'package:assignment_task/utilities/consts.dart';
import 'package:assignment_task/utilities/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logicGrades/manage_grade.dart';


class AddGradeView extends StatefulWidget {
  const AddGradeView({super.key});

  @override
  State<AddGradeView> createState() => _AddGradeViewState();
}

class _AddGradeViewState extends State<AddGradeView> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessager = GlobalKey();
  final TextEditingController arController = TextEditingController();
  final TextEditingController enController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: scaffoldMessager,
      child: Material(
        color: secondaryColor,
        child: SafeArea(child: Form(
          key: key,
          child: Scaffold(
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
                      validator: (data){
                        if(data!.isEmpty){
                          return 'enter grade name in arabic';
                        }else{
                          return null;
                        }
                      },
                      controller: arController,
                      // hintTextDirection: TextDirection.rtl,
                      // textDirection:  TextDirection.rtl,
                      hintText: 'أكتب هنا',
                    ),
                    SizedBox(height: 20,),
                    CustomText(text: 'Grade name in english' , fontSize: 18,),
                    CustomTextFormField(
                      validator: (data){
                        if(data!.isEmpty){
                          return 'enter grade name in english';
                        }else{
                          return null;
                        }
                      },
                      controller: enController,
                      hintText: 'Type here..',),
                    SizedBox(height: 40,),

                  BlocProvider(create: (context)=>ManageGradeCubit() , child: BlocBuilder<ManageGradeCubit ,AuthStatee>(
                 builder: (context, state){
                   if(state.status == AuthStatus.loading){
                     return Center(child: CircularProgressIndicator(color: primaryColor,),);
                   }else{
                     return CustomButton(text: 'Add Grade', borderRadius: 32,onTap: (){
                       if (key.currentState!.validate()) {
                         context.read<ManageGradeCubit>().addGrade(arController.text, enController.text, scaffoldMessager, context);
                       }
                     },);
                   }
                 },
               ),)

                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
