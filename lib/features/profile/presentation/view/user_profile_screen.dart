import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/auth/data/shared/save_user_token.dart';
import 'package:shop_app/features/profile/presentation/view_model/cubit/user_profile_cubit.dart';
import 'package:shop_app/features/profile/presentation/view_model/cubit/user_profile_states.dart';

import '../../../../core/utils/helper/app_routes.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit,UserProfileStates>(
      listener:(context , state){},
      builder:(context , state){
        final cubit = BlocProvider.of<UserProfileCubit>(context);
        return Scaffold(
          body:cubit.userModel != null ? SafeArea(
            child:SingleChildScrollView(
              child:Padding(
                padding:const EdgeInsets.symmetric(vertical: 50 , horizontal: 20),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("My Profile" , style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize:30,
                    ),),
                    const SizedBox(height: 20,),
                    Center(
                      child: CircleAvatar(
                        radius:80,
                        backgroundImage:NetworkImage(cubit.userModel!.image!),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Center(child: Text(cubit.userModel!.name! , style:const TextStyle(
                      fontSize: 20,
                    ),)),
                    const SizedBox(height: 8,),
                    Center(child: Text(cubit.userModel!.email! , style: const TextStyle(
                      fontSize: 20,
                    ),)),
                    const SizedBox(height: 8,),
                    Center(child: Text(cubit.userModel!.phone! , style:const TextStyle(
                      fontSize: 20,
                    ),)),
                    const SizedBox(height: 25,),
                    Container(
                      color:Colors.grey.withValues(alpha:0.2),
                      child: const ListTile(
                        leading:Icon(Icons.lock , color:Colors.orangeAccent,),
                        title: Text("Change Password"),
                        trailing:Icon(Icons.arrow_forward_ios_outlined , color:Colors.orangeAccent,),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      color:Colors.grey.withValues(alpha:0.2),
                      child: const ListTile(
                        leading:Icon(Icons.update , color:Colors.orangeAccent,),
                        title: Text("Update Profile"),
                        trailing:Icon(Icons.arrow_forward_ios_outlined , color:Colors.orangeAccent,),
                      ),
                    ),
                    const SizedBox(height: 25,),
                Container(
                  color:Colors.grey.withValues(alpha: 0.2),
                  child: ListTile(
                    onTap:(){
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    leading:Icon(Icons.change_circle , color:Colors.orangeAccent,),
                    title: Text("ChangeTheme"),
                    trailing:Icon(Icons.arrow_forward_ios_outlined , color:Colors.orangeAccent,),
                  ),
                ),
                     SizedBox(height: 25,),
                    Container(
                      color:Colors.grey.withValues(alpha:0.2),
                      child: ListTile(
                        onTap:(){
                          // CacheSecureStorage.deleteUserToken(key: 'token');
                          //  Navigator.pushReplacementNamed(context, MyRoutes.loginScreenRoute);
                        },
                        leading:Icon(Icons.exit_to_app , color:Colors.orangeAccent,),
                        title: Text("Logout"),
                        trailing:Icon(Icons.arrow_forward_ios_outlined , color:Colors.orangeAccent,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) : const Center(child:CircularProgressIndicator(),),
        );
      },
    );
  }
}
