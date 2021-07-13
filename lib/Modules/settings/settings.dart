import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerceapplication/Layout/Cubit/Cubit.dart';
import 'package:ecommerceapplication/Layout/Cubit/States.dart';
import 'package:ecommerceapplication/Modules/Login/loginscreen.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:ecommerceapplication/shared/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var Name_Controller = TextEditingController() ;
  var phone_Controller = TextEditingController() ;
  var email_Controller = TextEditingController() ;
  var form_key = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var Cubit = ShopAppCubit.get(context) ;
        if (Cubit.userModel.data!=null)
          {
            Name_Controller.text = Cubit.userModel.data.name ;
            phone_Controller.text = Cubit.userModel.data.phone ;
            email_Controller.text = Cubit.userModel.data.email ;
          }
        return  ConditionalBuilder(
          condition: Cubit.userModel!=null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: form_key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is UpdateUserProfileLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    default_Edit_text
                      (
                      Validate: (String value){
                        if (value.isEmpty)
                          return 'name cannot be empty' ;
                        return null ;
                      },
                      controller: Name_Controller,
                      type: TextInputType.text ,
                      hint: 'Name' ,
                      prefix: Icons.person ,
                    ) ,
                    SizedBox(height: 10.0,) ,
                    default_Edit_text
                      (
                      Validate: (String value){
                        if (value.isEmpty)
                          return 'email cannot be empty' ;
                        return null ;
                      },
                      controller: email_Controller,
                      type: TextInputType.emailAddress ,
                      hint: 'Email' ,
                      prefix: Icons.email ,
                    ) ,
                    SizedBox(height: 10.0,) ,
                    default_Edit_text
                      (
                      Validate: (String value){
                        if (value.isEmpty)
                          return 'phone cannot be empty' ;
                        return null ;
                      },
                      controller: phone_Controller,
                      type: TextInputType.phone ,
                      hint: 'Phone' ,
                      prefix: Icons.phone ,
                    ) ,
                    SizedBox(height: 10.0,) ,
                    default_button(
                      function: (){
                        if (form_key.currentState.validate())
                        {
                          Cubit.Update_profile(
                              name: Name_Controller.text ,phone: phone_Controller.text ,email: email_Controller.text) ;
                        }
                      },
                      text: 'Update',
                    ),
                    SizedBox(height: 10.0,) ,
                    default_button(
                      function: (){
                        token='' ;
                        Navigatetoandremove(context, LoginScreen()) ;
                      },
                      text: 'Logout',
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        ) ;
      },
    );
  }
}
