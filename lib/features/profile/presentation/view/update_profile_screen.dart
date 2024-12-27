import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/auth/presentation/view/widgets/custom_button.dart';
import 'package:shop_app/features/profile/presentation/view_model/cubit/user_profile_cubit.dart';
import 'package:shop_app/features/profile/presentation/view_model/cubit/user_profile_states.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
}
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserProfileCubit>(context);
     nameController.text = cubit.userModel!.name!;
     emailController.text = cubit.userModel!.email!;
     phoneController.text = cubit.userModel!.phone! ;
    return Scaffold(
      body:SafeArea(
        child:Padding(
          padding:EdgeInsets.symmetric(vertical:50 , horizontal:20),
          child:SingleChildScrollView(
            child:Column(
              spacing:30,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  icon:Icon(Icons.arrow_back_ios_outlined),
                ),
                Text(
                  "Update Profile",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                TextFormField(
                  controller:nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    label:Text("Name"),
                    hintText: "Name",
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
                  controller:emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    label:Text("Email"),
                    hintText: "Email",
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
                  controller:phoneController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    label:Text("Phone"),
                    hintText: "Phone",
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
                BlocConsumer<UserProfileCubit , UserProfileStates>(
                  listener:(context , state){
                    if (state is UpdateProfileSuccessState)
                    {
                        Navigator.pop(context);
                    }
                    if(state is UpdateProfileFailedState)
                    {
                      showDialog(context: context, builder:(context) => AlertDialog(
                        backgroundColor:Colors.red,
                        content:Text(state.errorMessage),
                      ),);
                    }
                  },
                  builder:(context , state){
                    return CustomButton(
                      onPressed:(){
                        if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty)
                        {
                          cubit.updateProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
                        }
                        else
                        {
                          showDialog(context: context, builder:(context) => AlertDialog(
                            backgroundColor:Colors.red,
                            content: Text("Please enter data in all fields"),
                          ));
                        }
                      },
                      text:state is UpdateProfileLoadingState ? "Loading..." : "Update Profile",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
