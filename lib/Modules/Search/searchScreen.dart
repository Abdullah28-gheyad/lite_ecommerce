import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerceapplication/Layout/Cubit/Cubit.dart';
import 'package:ecommerceapplication/Layout/Cubit/States.dart';
import 'package:ecommerceapplication/models/productmodel/productmodel.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var SearchController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
        },),
      ),
      body: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var Cubit = ShopAppCubit.get(context) ;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                default_Edit_text(
                  controller: SearchController ,
                  Validate: (String value){
                    if (value.isEmpty)
                      return null ;
                  } ,
                  prefix: Icons.search ,
                  hint: 'Search' ,
                  onsubmit: (value)
                    {
                      Cubit.getProductssearch(SearchController.text) ;
                    } ,
                ) ,
                SizedBox(height: 5.0,) ,
                if (state is GetProductSearchLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 5.0,),
                if (state is !GetProductSearchLoadingState)
                  ConditionalBuilder(
                    condition: Cubit.productModel!=null||Cubit.productModelsearch!=null,
                    builder: (context)=>Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>SearchController.text!=''?build_searched(Cubit.productModelsearch.data.products[index],context):build_searched(Cubit.productModel.data.products[index],context),
                          separatorBuilder: (context,index)=>Container(height: 1,width: double.infinity,color: Colors.grey[300],),
                          itemCount: SearchController.text==''?Cubit.productModel.data.products.length:Cubit.productModelsearch.data.products.length??2
                      ),
                    ),
                    fallback: (context)=>Center(child: CircularProgressIndicator()),
                  )
              ],
            ),
          ) ;
        },
      ),
    );
  }

  Widget build_searched(ProductData model , context)=>
      Container(
        width: double.infinity,
        child: Row(
          children: [
            Image(
                image: NetworkImage(model.image) ,
              width: 120.0,
              height: 120.0,

            ) ,
            SizedBox(width: 2.0,) ,
            Expanded(child: Text(model.name,style: Theme.of(context).textTheme.caption,maxLines: 1,overflow: TextOverflow.ellipsis,))
          ],
        ),
      );
}
