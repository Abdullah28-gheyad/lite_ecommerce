import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/Layout/Cubit/States.dart';
import 'package:ecommerceapplication/Modules/Categories/categories.dart';
import 'package:ecommerceapplication/Modules/favourite/favorites.dart';
import 'package:ecommerceapplication/Modules/products/products.dart';
import 'package:ecommerceapplication/Modules/settings/settings.dart';
import 'package:ecommerceapplication/models/bannersmodel/bannersmodel.dart';
import 'package:ecommerceapplication/models/categoriesmodel/categoriesmodel.dart';
import 'package:ecommerceapplication/models/productmodel/productmodel.dart';
import 'package:ecommerceapplication/models/usermodel/usermodel.dart';
import 'package:ecommerceapplication/shared/EndPoints.dart';
import 'package:ecommerceapplication/shared/const/const.dart';
import 'package:ecommerceapplication/shared/network/remote/DioHelper/DioHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopAppCubit extends Cubit <ShopAppStates>
{
  ShopAppCubit():super(ShopAppInitialState()) ;
  static ShopAppCubit get(context)=>BlocProvider.of(context) ;
  int currentindex = 0 ;
  List<String> titles = [
    'Home',
    'Categories',
    'Setting',
  ];
  List<Widget> screens=
      [
         ProductScreen() ,
         CategoriesScreen() ,
         SettingsScreen() ,
      ];
  void changenavbar(int index)
  {
    currentindex = index ;
    emit(ShopAppChangeNavBarState()) ;
  }
  BannerModel bannerModel ;
  void getBanners()
  {
    emit(GetBannersLoadingState()) ; 
    DioHelper.getData(url: BANNERS)
        .then((value) {
          bannerModel = BannerModel.FromJson(value.data) ;
          print (bannerModel.data[0].image) ;
          emit(GetBannersSuccessState()) ;
    })
        .catchError((error){
          print (error) ;
          emit(GetBannersErrorState()) ;
    }) ;
  }

  CategoriesModel categoriesModel ;
  void getCategories()
  {
    emit(GetCategoryLoadingState()) ;
    DioHelper.getData(url: CATEGORY)
        .then((value) {
      categoriesModel = CategoriesModel.FromJson(value.data) ;
      print (categoriesModel.data.data[0].image) ;
      emit(GetCategoryySuccessState()) ;
    })
        .catchError((error){
      print (error) ;
      emit(GetCategoryErrorState()) ;
    }) ;
  }


  ProductModel productModel ;
  void getProducts(context)
  {
    emit(GetProductLoadingState()) ;
    DioHelper.getData(url: PRODUCT,Authorization: token)
        .then((value) {
      productModel = ProductModel.FromJson(value.data) ;
      print (productModel.data.products[0].image) ;
      emit(GetProductySuccessState()) ;
    })
        .catchError((error){
      print (error.toString()) ;
      emit(GetProductErrorState()) ;
    }) ;
  }
  ProductModel productModelsearch ;
  void getProductssearch(String word)
  {
    emit(GetProductSearchLoadingState()) ;
    DioHelper.getData(url: SEARCH,Authorization: token ,Data: {
      'text':word
    })
        .then((value) {
      productModelsearch = ProductModel.FromJson(value.data) ;
      print (productModelsearch.data.products[0].image) ;
      emit(GetProductSearchSuccessState()) ;
    })
        .catchError((error){
      print (error.toString()+'   im errorrrrrrrrrrrrrrr') ;
      emit(GetProductSearchErrorState()) ;
    }) ;
  }
  UserModel userModel ;
  void get_profile (
  {
  @required String token,
}
      )
  {
    emit( GetUserProfileLoadingState()) ; 
    DioHelper.getData(url: PROFILE , Authorization: token).then((value){
      userModel = UserModel.FromJson(value.data) ;
      print (userModel.data.phone.toString()+'here iam phone') ;
      emit(GetUserProfileSuccessState()) ;
    })
    .catchError((error){
      print (error.toString()) ;
      emit(GetUserProfileErrorState()) ;
    }) ;
  }

  void Update_profile(
  {
  @required String name ,
  @required String phone ,
  @required String email ,
}
      )
  {
    emit (UpdateUserProfileLoadingState()) ;
    DioHelper.put_data(url: UPDATE,token: token , data: {
      'name':name ,
      'phone':phone ,
      'email':email ,
    })
        .then((value) {
          userModel = UserModel.FromJson(value.data) ;
          print(userModel.data.name+'my is naaaaaaaaaaaaaaaaaaaame') ;
          emit(UpdateUserProfileSuccessState()) ;
    })
    .catchError((error){
      print (error.toString()) ;
      emit(UpdateUserProfileErrorState()) ;
    });
  }

  IconData fav_icon = Icons.favorite_border ;
  void ChangeFavoriteIcon()
  {
    if (fav_icon==Icons.favorite_border)
      {
        fav_icon=Icons.favorite ;
      }
    else
      {
        fav_icon=Icons.favorite_border ;
      }
    emit (ChangeFavIconSuccessState()) ;
  }
}