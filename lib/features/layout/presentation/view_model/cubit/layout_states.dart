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

//products states
class ProductsLoadingState extends LayoutStates{}
class ProductsSuccessState extends LayoutStates{}
class ProductsFailedState extends LayoutStates{}

//search for products state
class SearchForProductsSuccessState extends LayoutStates{}

//get favourite data states
class FavouritesLoadingState extends LayoutStates{}
class FavouritesSuccessState extends LayoutStates{}
class FavouritesFailedState extends LayoutStates{}

//add or remove from favourites states
class AddOrRemoveFromFavouriteLoadingState extends LayoutStates{}
class AddOrRemoveFromFavouriteSuccessState extends LayoutStates{}
class AddOrRemoveFromFavouriteFailedState extends LayoutStates{}

//get cart data states
class CartLoadingState extends LayoutStates{}
class CartSuccessState extends LayoutStates{}
class CartFailedState extends LayoutStates{}

//add or remove from cart states
class AddOrRemoveFromCartLoadingState extends LayoutStates{}
class AddOrRemoveFromCartSuccessState extends LayoutStates{}
class AddOrRemoveFromCartFailedState extends LayoutStates{}