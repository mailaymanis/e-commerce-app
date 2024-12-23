abstract class UserProfileStates{}
//create initial state
class UserProfileInitializationState extends UserProfileStates{}

//create userProfile states
class UserProfileLoadingState extends UserProfileStates{}
class UserProfileSuccessState extends UserProfileStates{}
class UserProfileFailedState extends UserProfileStates{
  String? message;
  UserProfileFailedState({required this.message});
}

