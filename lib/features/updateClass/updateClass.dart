import 'package:assignment_task/features/auth/customWidgets/customButton.dart';
import 'package:assignment_task/features/auth/customWidgets/customText.dart';
import 'package:assignment_task/features/auth/customWidgets/customTextFormField.dart';
import 'package:assignment_task/features/auth/login/states_login.dart';
import 'package:assignment_task/features/get_classes_and_search/classModel.dart';

import 'package:assignment_task/utilities/consts.dart';
import 'package:assignment_task/utilities/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manageClass/logicClass/logicClass.dart';

class UpdateClassView extends StatefulWidget {
  const UpdateClassView(
      {super.key, required this.classs, required this.gradeId});

  final Class classs;
  final String gradeId;

  @override
  State<UpdateClassView> createState() => _UpdateGradeViewState();
}

class _UpdateGradeViewState extends State<UpdateClassView> {
  String? arName;

  String? enName;

  GlobalKey<ScaffoldMessengerState> scaffoldMessager = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: scaffoldMessager,
      child: Material(
        color: secondaryColor,
        child: SafeArea(
            child: Scaffold(
             appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
            body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomVerticalSizeBox(
                    padding: 1,
                  ),
                  CustomText(
                    text: 'Class name in arabic',
                    fontSize: 18,
                  ),
                  CustomTextFormField(
                    onChanged: (value) {
                      arName = value;
                    },
                    initValue: widget.classs.nameAr,

                    // hintTextDirection: TextDirection.rtl,
                    // textDirection:  TextDirection.rtl,
                    hintText: 'أكتب هنا',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: 'Class name in english',
                    fontSize: 18,
                  ),
                  CustomTextFormField(
                    onChanged: (value) {
                      enName = value;
                    },
                    initValue: widget.classs.nameEn,
                    hintText: 'Type here..',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  BlocProvider(
                    create: (context) => AddClassVubit(),
                    child: BlocBuilder<AddClassVubit, AuthStatee>(
                      builder: (context, state) {
                        if (state.status == AuthStatus.loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          );
                        } else {
                          return CustomButton(
                            text: 'Update Class',
                            borderRadius: 32,
                            onTap: () {
                              context.read<AddClassVubit>().updateClass(
                                  arName ?? widget.classs.nameAr,
                                  enName ?? widget.classs.nameEn,
                                  scaffoldMessager,
                                  widget.classs.id,
                                  widget.classs.schoolId,
                                  widget.gradeId,
                                  context);
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
