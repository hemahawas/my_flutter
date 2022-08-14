import 'package:my_project/models/shop_app/categories_model.dart';
import 'package:my_project/models/shop_app/change_favorites_model.dart';

//System
abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

//Home
class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

//Categories
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  ChangeFavoritesModel? model;

  ShopSuccessChangeFavoritesState({this.model});
}

//Favorites
class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

//User Settings
class ShopLoadingUserState extends ShopStates {}

class ShopSuccessUserState extends ShopStates {}

class ShopErrorUserState extends ShopStates {}

// User Update
class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {}

// Search
class ShopLoadingSearchState extends ShopStates {}

class ShopSuccessSearchState extends ShopStates {}

class ShopErrorSearchState extends ShopStates {}
