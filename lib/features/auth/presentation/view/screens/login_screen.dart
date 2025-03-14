import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:shop_app/features/auth/presentation/view_model/cubit/auth_states.dart';

import '../../../../../core/utils/helper/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_email_field.dart';
import '../widgets/custom_password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit , AuthStates>(
      listener:(context , state){
        if(state is LoginLoadingState){
          const Center(child: CircularProgressIndicator(),);
        }
        else if(state is LoginSuccessState){
          Navigator.pushReplacementNamed(context, MyRoutes.layoutScreenRoute);
        }
        else if(state is LoginFailedState){
          showDialog(context: context, builder: (context) => AlertDialog(
            backgroundColor: Colors.red,
            content: Text(state.message , style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          ),);
        }
      },
      builder:(context , state){
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 150),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomEmailField(
                          hint: "email",
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your email";
                            }
                            if (!value.contains('@')) {
                              return "not valid email you missing @";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomPasswordField(
                          hint: "password",
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your password";
                            }
                            if (value.length < 8) {
                              return "your password less than 8 characters";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).login(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          text:state is  LoginLoadingState ? "Loading..." : "Login"
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Text(
                              "Don't have an account ? ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacementNamed(context, MyRoutes.signupScreenRoute);
                              },
                              customBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              splashColor: Colors.black,
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orangeAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
