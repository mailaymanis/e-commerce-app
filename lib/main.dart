// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/helper/app_constants.dart';
import 'package:shop_app/core/utils/helper/app_routes.dart';
import 'package:shop_app/features/auth/data/shared/save_user_token.dart';
import 'package:shop_app/features/auth/presentation/view/screens/login_screen.dart';
import 'package:shop_app/features/auth/presentation/view/screens/signup_screen.dart';
import 'package:shop_app/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:shop_app/features/home/presentation/view/screen/home_screen.dart';
import 'package:shop_app/features/layout/presentation/view/screen/layout_screen.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_cubit.dart';
import 'package:shop_app/features/profile/presentation/view/change_password_screen.dart';
import 'package:shop_app/features/profile/presentation/view/user_profile_screen.dart';
import 'package:shop_app/features/profile/presentation/view_model/cubit/user_profile_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await CacheSecureStorage.getUserToken(key: 'token');
  userPassword = await CacheSecureStorage.getUserToken(key: 'password');
  print("user token is : $token");
  print("user password is : $userPassword");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => UserProfileCubit()..getUserProfileData(),
        ),
        BlocProvider(
          create: (context) => LayoutCubit()
            ..getBannersDate()
            ..getCategoriesData()
            ..getProductsDate()
            ..getFavouritesData()
            ..getCartData(),
        ),
      ],
      child: BlocProvider(
        create:(context) => ThemeCubit(),
        child:BlocBuilder<ThemeCubit , ThemeData>(
          builder:(context , themeState){
            return MaterialApp(
              theme:themeState,
              debugShowCheckedModeBanner: false,
              home: token != null && token != ""
                  ? const LayoutScreen()
                  : const LoginScreen(),
              routes: {
                MyRoutes.loginScreenRoute: (context) => const LoginScreen(),
                MyRoutes.signupScreenRoute: (context) => const SignupScreen(),
                MyRoutes.homeScreenRoute: (context) => const HomeScreen(),
                MyRoutes.changePasswordRoute : (context) => const ChangePasswordScreen(),
                MyRoutes.profileScreenRoute : (context) => const ProfileScreen(),
                MyRoutes.layoutScreenRoute : (context) => const LayoutScreen(),
              },
            );
          },
        ),
      ),
    );
  }
}
