abstract class LayoutStates{}
//create initial state
class LayoutInitializationState extends LayoutStates{}

//bottom navigation state
class BottomNavSuccessState extends LayoutStates{}

//banners states
class BannersLoadingState extends LayoutStates{}
class BannersSuccessState extends LayoutStates{}
class BannersFailedState extends LayoutStates{}

//categories states
class CategoryLoadingState extends LayoutStates{}
class CategorySuccessState extends LayoutStates{}
class CategoryFailedState extends LayoutStates{}