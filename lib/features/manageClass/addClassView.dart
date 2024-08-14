
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utilities/consts.dart';
import '../../utilities/device_size.dart';
import '../auth/customWidgets/customButton.dart';
import '../auth/customWidgets/customText.dart';
import '../auth/customWidgets/customTextFormField.dart';
import '../auth/login/states_login.dart';
import '../get_grades_and_search/manager/grade_model.dart';
import 'logicClass/logicClass.dart';

class AddClassView extends StatefulWidget {
  const AddClassView({super.key, required this.grade});
 final Grade grade;
  @override
  State<AddClassView> createState() => _AddClassViewState();
}

class _AddClassViewState extends State<AddClassView> {
  TextEditingController arController= TextEditingController();
  TextEditingController enController= TextEditingController();
  GlobalKey<ScaffoldMessengerState> scaffoldMessager = GlobalKey();
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

            body:   SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomVerticalSizeBox(padding: 1,),
                    CustomText(text: 'Class name in arabic',fontSize: 18,),
                    CustomTextFormField(
                      validator: (data){
                        if(data!.isEmpty){
                          return 'enter class name in arabic';
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
                    CustomText(text: 'Class name in english' , fontSize: 18,),
                    CustomTextFormField(
                      validator: (data){
                        if(data!.isEmpty){
                          return 'enter class name in english';
                        }else{
                          return null;
                        }
                      },
                      controller: enController,
                      hintText: 'Type here..',),
                    SizedBox(height: 40,),
                    BlocProvider(create: (context)=>AddClassVubit() , child: BlocBuilder<AddClassVubit ,AuthStatee>(
                      builder: (context, state){
                        if(state.status == AuthStatus.loading){
                          return Center(child: CircularProgressIndicator(color: primaryColor,),);
                        }else{
                          return CustomButton(text: 'Add Class', borderRadius: 32,onTap: (){

                            /// here complete
                            if(key.currentState!.validate()){
                              context.read<AddClassVubit>().addClass(arController.text, enController.text, scaffoldMessager, context , widget.grade.id , widget.grade.schoolId);
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
