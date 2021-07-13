import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerceapplication/Layout/HomeScreen/homeScreen.dart';
import 'package:ecommerceapplication/Modules/Register/cubit/cubit.dart';
import 'package:ecommerceapplication/Modules/Register/cubit/states.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterScreen extends StatelessWidget {
  TextEditingController email_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  var form_key = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if (state is RegisterSuccessState)
            Navigatetoandremove(context, HomeScreen()) ;
        },


        builder: (context,state){
          var cubit = RegisterCubit.get(context) ;
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: form_key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign Up to See Hot Offers' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                        SizedBox(height: 20.0,) ,
                        default_Edit_text(
                          Validate: (String value){
                            if (value.isEmpty)
                              return 'email cannot be empty' ;
                            return null ;
                          },
                          controller: email_controller,
                          type: TextInputType.emailAddress ,
                          prefix: Icons.email ,
                          hint: 'Email' ,

                        ) ,
                        SizedBox(height: 10.0,) ,
                        default_Edit_text(
                          Validate: (String value){
                            if (value.isEmpty)
                              return 'name cannot be empty' ;
                            return null ;
                          },
                          controller: name_controller,
                          type: TextInputType.text ,
                          prefix: Icons.person ,
                          hint: 'Name' ,

                        ) ,
                        SizedBox(height: 10.0,) ,
                        default_Edit_text(
                          Validate: (String value){
                            if (value.isEmpty)
                              return 'password cannot be empty' ;
                            return null ;
                          },
                          controller: password_controller,
                          type: TextInputType.visiblePassword ,
                          prefix: Icons.lock ,
                          suffix: cubit.icon,
                          hint: 'Password' ,
                          obsecure: cubit.secure ,
                          suffixpress: (){
                            cubit.change_icon() ;
                          }
                        ) ,
                        SizedBox(height: 10.0,) ,
                        default_Edit_text(
                          Validate: (String value){
                            if (value.isEmpty)
                              return 'phone cannot be empty' ;
                            return null ;
                          },
                          controller: phone_controller,
                          type: TextInputType.phone ,
                          prefix: Icons.phone ,
                          hint: 'Phone' ,

                        ) ,
                        SizedBox(height: 20.0,) ,
                        ConditionalBuilder(
                          condition: state is !RegisterLoadingState,
                          builder: (context)=>default_button(
                              function: (){
                                if (form_key.currentState.validate())
                                {
                                 cubit.Register(email: email_controller.text, name: name_controller.text, phone: phone_controller.text, password: password_controller.text) ;
                                }
                              },
                              text: 'SignUp'),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ) ,
                        SizedBox(height: 10.0,) ,

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
    } ,
      ),
    );
  }
}
