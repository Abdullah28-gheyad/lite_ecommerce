
import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerceapplication/Layout/Cubit/Cubit.dart';
import 'package:ecommerceapplication/Layout/Cubit/States.dart';
import 'package:ecommerceapplication/models/categoriesmodel/categoriesmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit , ShopAppStates>(
      builder: (context,state){
        var Cubit = ShopAppCubit.get(context) ;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ConditionalBuilder(
                condition: Cubit.categoriesModel!=null,
                builder: (context)=>Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>Bulid_Gategory_item(Cubit.categoriesModel.data.data[index]),
                      separatorBuilder: (context,index)=>Container(height: 1,width: double.infinity,color: Colors.grey[300],),
                      itemCount: Cubit.categoriesModel.data.data.length),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator()),
              )
            ],
          )
        ) ;
      },
      listener: (context,state){},
    );
  }

  Widget Bulid_Gategory_item(CategoryData model)=>Row(
    children: [
      Image(
        image: NetworkImage(model.image) ,
        width: 150,
        height: 150,

      ),
      SizedBox(width: 5.0,) ,
      Text(model.name , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15.0),) ,
      Spacer() ,
      IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){} , color: Colors.blue,) ,
    ],
  ) ;

}
