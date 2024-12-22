abstract class AuthStates{}

class AuthInitializationState extends AuthStates{}

//register states
class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class RegisterFailedState extends AuthStates{
  String message;
  RegisterFailedState({required this.message});
}

//login states
class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{}
class LoginFailedState extends AuthStates{
  String message;
  LoginFailedState({required this.message});
}