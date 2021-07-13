import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapplication/Modules/Register/cubit/states.dart';
import 'package:ecommerceapplication/models/usermodel/usermodel.dart';
import 'package:ecommerceapplication/shared/EndPoints.dart';
import 'package:ecommerceapplication/shared/components/constatnst/constants.dart';
import 'package:ecommerceapplication/shared/const/const.dart';
import 'package:ecommerceapplication/shared/network/remote/DioHelper/DioHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState()) ;
  static RegisterCubit get(context)=>BlocProvider.of(context) ;
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
    emit(RegisterChangeIconState()) ;
  }

  UserModel userModel ;
  void Register (
  {
  @required String name ,
  @required String email ,
  @required String password ,
  @required String phone ,
}
      )
  {
    emit(RegisterLoadingState()) ;
    DioHelper.postdata(url: REGISTER, data: {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
    })
        .then((value){
          userModel = UserModel.FromJson(value.data) ;
          print (userModel.data.token) ;
          token=userModel.data.token;
          emit(RegisterSuccessState()) ;
    })
        .catchError((error){
          print (error.toString()) ;
          emit(RegisterErrorState()) ;
    }) ;
  }
}