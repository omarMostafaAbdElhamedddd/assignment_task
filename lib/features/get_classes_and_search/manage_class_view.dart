import 'package:assignment_task/features/updateClass/updateClass.dart';
import 'package:assignment_task/utilities/device_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utilities/consts.dart';
import '../auth/customWidgets/customText.dart';
import '../auth/customWidgets/customTextFormField.dart';
import '../auth/login/states_login.dart';
import '../manageClass/addClassView.dart';
import '../manageClass/logicClass/logicClass.dart';
import 'manager/logic.dart';
import 'manager/states.dart';
import '../get_grades_and_search/gradesView.dart';
import '../get_grades_and_search/manager/grade_model.dart';




class GetClassesAndSearch extends StatefulWidget {
  const GetClassesAndSearch({super.key, required this.grade});
  final Grade grade;

  @override
  State<GetClassesAndSearch> createState() => _GetClassesAndSearchState();
}

class _GetClassesAndSearchState extends State<GetClassesAndSearch> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessager = GlobalKey();
  @override
  Widget build(BuildContext context) {
    GetClassesCubit().getClasses();
    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: scaffoldMessager,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Material(
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
                          padding: EdgeInsets.only(left: 20, right: 20),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                            size: 30,
                          )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CustomText(
                            text: widget.grade.name,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, PageRouteBuilder(pageBuilder: (context,an,sc){
                            return AddClassView(grade:widget.grade,);
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffF7F1F9)),
                          margin: EdgeInsets.only(right: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 30,
                                color: Color(0xff64548F),
                              ),
                              SizedBox(width: 10),
                              CustomText(
                                text: 'Add Classes',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0xff64548F),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search Classes',
                    ),
                    Expanded(
                        child: BlocBuilder<GetClassesCubit , GetClassesStates>(
                            builder: (context,statee){

                              if(statee is LoadingClass){
                                return Center(child: CircularProgressIndicator(color: primaryColor,),);
                              }
                              else if(statee is SuccessClass){

                                if(statee.classes.length==0){
                                  return Center(
                                    child: CustomText(text: 'No Classes yet!',fontSize: 25,fontWeight: FontWeight.w500,),
                                  );
                                }

                                return ListView.builder(

                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  itemCount: statee.classes.length, // Replace with your item count
                                  itemBuilder: (context, index) {
                                    return CustomGradeItem(

                                      editOnTap: (){
                                       Navigator.push(context, PageRouteBuilder(pageBuilder: (context,an,sc){
                                         return UpdateClassView(classs: statee.classes[index] , gradeId: widget.grade.id,);
                                       }));

                                      },
                                      nextTap: (){



                                      },
                                      text:  statee.classes[index].name, deleteWidget:  BlocProvider(create: (context)=>AddClassVubit(),child: BlocBuilder<AddClassVubit , AuthStatee>(
                                      builder: (context, state){
                                        if(state.status ==AuthStatus.loading){
                                          return CircularProgressIndicator(color: primaryColor,);
                                        }else{
                                          return IconButton(onPressed: (){
                                            context.read<AddClassVubit>().deleteClass(scaffoldMessager, statee.classes[index].id, context);

                                          }, icon: Icon(Icons.delete,color: Colors.black.withOpacity(.6),));
                                        }
                                      },

                                    )),
                                    );
                                  },
                                );
                              }else{
                                return Center(child: CustomText(text: 'Something went wrong',fontSize: 20,),);
                              }
                            }
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
