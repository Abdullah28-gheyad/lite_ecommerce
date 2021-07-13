import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/Layout/Cubit/Cubit.dart';
import 'package:ecommerceapplication/Modules/Login/loginscreen.dart';
import 'package:ecommerceapplication/shared/components/blocobserver/blocobserve.dart';
import 'package:ecommerceapplication/shared/const/const.dart';
import 'package:ecommerceapplication/shared/network/remote/DioHelper/DioHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized() ;
  DioHelper.init() ;
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopAppCubit()..getBanners()..getCategories()..getProducts(context)..get_profile(token: token),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomNavigationBarTheme:BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed ,
              backgroundColor: Colors.white ,
              elevation: 20.0 ,
              unselectedItemColor: Colors.grey ,
              selectedItemColor: Colors.blue

          ),
        backgroundColor: Colors.white ,
        scaffoldBackgroundColor: Colors.white ,
        appBarTheme: AppBarTheme(
          color: Colors.white ,
          iconTheme: IconThemeData(
            color: Colors.blue
          ) ,
          backwardsCompatibility: false,
          elevation: 0.0 ,
          actionsIconTheme: IconThemeData(
            color: Colors.blue ,
          ) ,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white
          ),
          foregroundColor: Colors.white ,
       titleTextStyle:TextStyle(
      color: Colors.black ,
      fontSize: 20.0 ,
      fontWeight: FontWeight.bold
  )
        )
      ),
      home: LoginScreen(),
      ),
    );
  }
}
