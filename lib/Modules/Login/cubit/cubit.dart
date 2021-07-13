import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/Modules/Login/cubit/states.dart';
import 'package:ecommerceapplication/models/usermodel/usermodel.dart';
import 'package:ecommerceapplication/shared/EndPoints.dart';
import 'package:ecommerceapplication/shared/components/constatnst/constants.dart';
import 'package:ecommerceapplication/shared/const/const.dart';
import 'package:ecommerceapplication/shared/network/remote/DioHelper/DioHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState()) ;
  static LoginCubit get(context)=>BlocProvider.of(context) ;
  bool secure = true ;
  IconData icon = Icons.visibility ;
  void change_icon()
  {
    if (icon == Icons.visibility)
      {
        icon = Icons.visibility_off ;
        secure = false ;
      }
    else
      {
        icon = Icons.visibility ;
        secure = true ;
      }
    emit(LoginChangeIconState()) ;
  }

  UserModel userModel ;
  void Login (
  {
  @required Email ,
  @required Password ,
}
      )
  {
    emit(LoginLoadingState()) ;
    DioHelper.postdata(url: LOGIN, data: {
      'email':Email ,
      'password':Password
    })
        .then((value){
          userModel = UserModel.FromJson(value.data) ;
          print (userModel.data.token) ;
          token=userModel.data.token;
          emit (LoginSuccessState()) ;
    })
        .catchError((error){
          print (error.toString()) ;
          emit(LoginErrorState()) ;
    }) ;
  }

}