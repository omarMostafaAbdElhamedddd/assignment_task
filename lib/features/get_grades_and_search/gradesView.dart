
import 'package:assignment_task/features/auth/customWidgets/customTextFormField.dart';
import 'package:assignment_task/features/auth/login/states_login.dart';
import 'package:assignment_task/features/updateGrade/uodateGradeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../utilities/consts.dart';
import '../../utilities/device_size.dart';
import '../auth/customWidgets/customText.dart';
import '../manageGrade/add_grade_view.dart';
import '../manageGrade/logicGrades/manage_grade.dart';
import '../get_classes_and_search/manage_class_view.dart';
import 'manager/logic_get_grades.dart';
import 'manager/states.dart';


class ManageGrades extends StatefulWidget {
  const ManageGrades({super.key});

  @override
  State<ManageGrades> createState() => _ManageGradesState();
}

class _ManageGradesState extends State<ManageGrades> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessenger = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ScaffoldMessenger(
        key: scaffoldMessenger,
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
                          padding: EdgeInsets.only(left: 20, right: 40),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            size: 30,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CustomText(
                          text: 'Grades',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              PageRouteBuilder(pageBuilder: (context, an, sc) {
                            return AddGradeView();
                          }));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                                text: 'Add Grades',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0xff64548F),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search Grades',
                    ),
                    Expanded(child: BlocBuilder<GetGradeubit, GetGradesStates>(
                        builder: (context, statee) {
                      if (statee is Loading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      } else if (statee is Success) {
                        if (statee.grades.length == 0) {
                          return Center(
                            child: CustomText(
                              text: 'No Classes yet!',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemCount: statee.grades.length,
                          // Replace with your item count
                          itemBuilder: (context, index) {
                            return CustomGradeItem(
                           
                              editOnTap: () {
                                Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (context, an, sc) {
                                  return UpdateGradeView(
                                      grade: statee.grades[index]);
                                }));
                              },
                              nextTap: () {
                                Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (context, an, sc) {
                                  return GetClassesAndSearch(
                                    grade: statee.grades[index],
                                  );
                                }));
                              },
                              text: statee.grades[index].name, 
                              
                              deleteWidget: BlocProvider(create: (context)=>ManageGradeCubit(),child: BlocBuilder<ManageGradeCubit , AuthStatee>(
                                builder: (context, state){
                                  if(state.status ==AuthStatus.loading){
                                    return CircularProgressIndicator(color: primaryColor,);
                                  }else{
                                    return IconButton(onPressed: (){
                                      context.read<ManageGradeCubit>().deleteGrade(scaffoldMessenger, statee.grades[index].id, context);

                                    }, icon: Icon(Icons.delete,color: Colors.black.withOpacity(.6),));
                                  }
                                },
                                
                              )),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CustomText(
                            text: 'Something went wrong',
                            fontSize: 20,
                          ),
                        );
                      }
                    })),
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

class CustomDeleteDialog extends StatelessWidget {
  const CustomDeleteDialog({
    super.key,
    required this.title,
    required this.deleteButton,
  });

  final String title;

// final void Function() onPressed;
  final Widget deleteButton;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Center(
          child: CustomText(
        text: title,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      )),
      content: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Icon(
          Icons.delete_forever,
          color: Colors.red,
          size: 70,
        ),
      ),
      actions: [
        deleteButton,
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: CustomText(
              text: 'Cancel',
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}

class CustomGradeItem extends StatelessWidget {
  const CustomGradeItem(
      {super.key,
      required this.text,
      this.editOnTap,
      this.nextTap, required this.deleteWidget});

  final String text;

  final Function()? editOnTap;
  final Function()? nextTap;
  final Widget deleteWidget;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffF7F1F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          children: [
            CustomText(
              text: text,
              fontSize: 18,
            ),
            Spacer(),
            IconButton(
                onPressed: editOnTap,
                icon: Icon(
                  Icons.edit,
                  color: Colors.black.withOpacity(.6),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: deleteWidget
            ),
            IconButton(
                onPressed: nextTap,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(.6),
                )),
          ],
        ),
      ),
    );
  }
}
