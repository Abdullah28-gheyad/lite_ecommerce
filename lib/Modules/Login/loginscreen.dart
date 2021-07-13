
import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerceapplication/Layout/HomeScreen/homeScreen.dart';
import 'package:ecommerceapplication/Modules/Login/cubit/cubit.dart';
import 'package:ecommerceapplication/Modules/Login/cubit/states.dart';
import 'package:ecommerceapplication/Modules/Register/registerscreen.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
TextEditingController email_controller = TextEditingController();
TextEditingController password_controller = TextEditingController();
var form_key = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit , LoginStates>(
        listener: (context,state){
          if (state is LoginSuccessState)
            Navigatetoandremove(context, HomeScreen()) ;
        },
        builder: (context,state){
          var cubit = LoginCubit.get(context) ;
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
                        Text('Sign in to See Our Hot Offers' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
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
                              return 'password cannot be empty' ;
                            return null ;
                          },
                          controller: password_controller,
                          type: TextInputType.visiblePassword ,
                          prefix: Icons.lock ,
                          suffix: cubit.icon,
                          hint: 'Password' ,
                          obsecure: cubit.secure ,
                          suffixpress: (){cubit.change_icon();}
                        ) ,
                        SizedBox(height: 10.0,) ,
                        ConditionalBuilder(
                         builder: (context)=>default_button(
                             function: (){
                               if (form_key.currentState.validate())
                               {
                                 cubit.Login(Email: email_controller.text, Password: password_controller.text) ;
                               }
                             },
                             text: 'LOGIN'),
                          condition: state is !LoginLoadingState,
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ) ,
                        SizedBox(height: 10.0,) ,
                        Row(
                          children: [
                            Text('Dont have account ?') ,
                            TextButton(onPressed: (){
                              Navigateto(context, RegisterScreen()) ;
                            }, child: Text('REGISTER NOW'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
}
