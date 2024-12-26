import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/helper/app_constants.dart';
import 'package:shop_app/features/auth/presentation/view/widgets/custom_button.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_states.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  @override
  void dispose(){
    passwordController.dispose();
    newpasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      body:Padding(
        padding:EdgeInsets.symmetric(vertical: 100 , horizontal: 20),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing:50,
            children: [
              IconButton(
                onPressed:(){
                 Navigator.pop(context);
                },
                icon:Icon(Icons.arrow_back_ios_outlined),
              ),
               Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              TextFormField(
                controller:passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: "Current Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:const BorderSide(
                        width: 2.5
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller:newpasswordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: "New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:const BorderSide(
                        width: 2.5
                    ),
                  ),
                ),
              ),
             BlocConsumer<LayoutCubit , LayoutStates>(
               listener:(context , state){
                 if (state is ChangePasswordSuccessState)
                 {
                   Navigator.pop(context);
                 }
                 if (state is ChangePasswordFailedState)
                 {
                   showDialog(context: context, builder: (context) => AlertDialog(
                     backgroundColor: Colors.red,
                     content: Text(state.errorMessage , style: const TextStyle(
                         color: Colors.white,
                         fontSize: 20,
                         fontWeight: FontWeight.bold
                     ),),
                   ),);
                 }
               },
               builder:(context , state){
                 return  CustomButton(
                     onPressed:(){
                       if(passwordController.text.trim() == userPassword)
                       {
                         if (newpasswordController.text.length >= 8)
                         {
                           cubit.changePassword(
                               currentPassword:userPassword!,
                               newPassword:newpasswordController.text.trim(),
                           );
                         }
                         else
                         {
                           showDialog(context: context, builder: (context) => AlertDialog(
                             backgroundColor: Colors.red,
                             content: Text("Password must be at least 8 characters" , style: const TextStyle(
                                 color: Colors.white,
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                             ),),
                           ),);
                         }
                       }
                       else
                       {
                         showDialog(context: context, builder: (context) => AlertDialog(
                           backgroundColor: Colors.red,
                           content: Text("Please , check your current password again" , style: const TextStyle(
                               color: Colors.white,
                               fontSize: 20,
                               fontWeight: FontWeight.bold
                           ),),
                         ),);
                       }
                     },
                     text:state is ChangePasswordLoadingState ? "Loading..." : "Change Password"
                 );
               },
             ),
            ],
          ),
        ),
      ),
    );
  }
}
