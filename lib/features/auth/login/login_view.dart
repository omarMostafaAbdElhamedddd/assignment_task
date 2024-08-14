import 'package:assignment_task/features/auth/login/logic_login.dart';
import 'package:assignment_task/features/auth/login/states_login.dart';
import 'package:assignment_task/features/home/home_view.dart';
import 'package:assignment_task/utilities/consts.dart';
import 'package:assignment_task/utilities/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../customWidgets/customButton.dart';
import '../customWidgets/customText.dart';
import '../customWidgets/customTextFormField.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
  bool passwordState = true;
  GlobalKey <ScaffoldMessengerState> scaffoldMessenger = GlobalKey();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // this line for responsive UI
    return ScaffoldMessenger(
      key: scaffoldMessenger,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: key,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                   const CustomVerticalSizeBox(padding: 3,),
                    const CustomText(text: 'Login' , fontSize: 30,fontWeight: FontWeight.w400,),
                    const CustomVerticalSizeBox(padding: 2,),
                    const CustomText(text: 'Mobile number',fontSize: 18,),
                    const SizedBox(height: 12,),
                    CustomTextFormField(
                      validator: (data){
                        if(data!.isEmpty){
                          return 'Please enter mobile nuember';
                        }else{
                          return null;
                        }
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: 'Enter phone number',
                      prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Image.asset('assets/images/saudi.jpg' , height: 35 , width: 40,),
                          SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: CustomText(text:'+966'),
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),),
                    const SizedBox(height: 30,),
                    const CustomText(text: 'Password' , fontSize: 18,),
                     const SizedBox(height: 10,),
                    TextFormField(
                      validator: (data){
                        if(data!.isEmpty){
                          return 'Please enter password';
                        }else{
                          return null;
                        }
                      },
                      controller: passwordController,
                  style: TextStyle(
                    fontSize: 18
                  ),
                  obscureText: passwordState,
                  cursorColor: primaryColor,

                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: IconButton(

                        onPressed: (){
                      setState(() {
                        passwordState = !passwordState;
                      });
                    }, icon: passwordState ? Icon(Icons.visibility_off,color: Colors.grey,):Icon(Icons.visibility ,color: Colors.grey,)),
                      hintText: 'Enter password',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder()

                  ),

                ),
                    const SizedBox(height: 30,),
                    BlocProvider(
                      create: (context) => SignInCubit(),
                      child: BlocBuilder<SignInCubit,AuthStatee>(
                        builder: (context, state) {
                          if (state.status == AuthStatus.loading) {
                            return Center(child: CircularProgressIndicator(color: primaryColor,));
                          } else {
                            return CustomButton(
                              text: 'Login',
                              onTap: () {
                                // Navigator.push(context, PageRouteBuilder(pageBuilder: ))
                                if (key.currentState!.validate()) {
                                  context.read<SignInCubit>().login(
                                    phoneController.text,
                                    passwordController.text,
                                    scaffoldMessenger,
                                    context,
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

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









