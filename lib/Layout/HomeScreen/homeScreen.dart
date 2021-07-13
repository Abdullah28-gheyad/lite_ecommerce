import 'package:ecommerceapplication/Layout/Cubit/Cubit.dart';
import 'package:ecommerceapplication/Layout/Cubit/States.dart';
import 'package:ecommerceapplication/Modules/Search/searchScreen.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit ,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var Cubit = ShopAppCubit.get(context) ; 
        return Scaffold(
          appBar: AppBar(
            title:  Text(Cubit.titles[Cubit.currentindex]),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: (){
                Navigateto(context, SearchScreen()) ;
              })
            ],
          ) ,
          body: Cubit.screens[Cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home) ,label: 'Home') ,
              BottomNavigationBarItem(icon: Icon(Icons.apps) ,label: 'Categories') ,
              BottomNavigationBarItem(icon: Icon(Icons.settings) ,label: 'Settings') ,
            ],
            currentIndex: Cubit.currentindex,
            onTap: (index)=>Cubit.changenavbar(index),
          ),

        ) ; 
      },
    );
  }
}
