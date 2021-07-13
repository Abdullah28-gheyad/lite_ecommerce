import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerceapplication/Layout/Cubit/Cubit.dart';
import 'package:ecommerceapplication/Layout/Cubit/States.dart';
import 'package:ecommerceapplication/models/categoriesmodel/categoriesmodel.dart';
import 'package:ecommerceapplication/models/productmodel/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopAppCubit.get(context) ;
       return  SingleChildScrollView(
         scrollDirection: Axis.vertical,
         physics: BouncingScrollPhysics(),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              build_banner(cubit),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Categories' , style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
              ),
              build_category(cubit),
              SizedBox(height: 10.0,) ,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('New Products' , style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 5.0,) ,
              ConditionalBuilder(
                condition: cubit.productModel!=null,
                builder: (context)=>Container(
                  color: Colors.white,
                  child: GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1/1.75,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(cubit.productModel.data.products.length, (index) => build_product(cubit.productModel.data.products[index],context)),
                  ),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
       ) ;
      },
    );
  }
  Widget build_category_item(CategoryData model)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
              image: NetworkImage(model.image) ,
            height: 70,
            width: 50,
            fit:BoxFit.cover ,
          ),
          Container(
            width: 100,
              color: Colors.black,
              child: Text(model.name , overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold  ,color: Colors.white, ),maxLines: 1 ,textAlign: TextAlign.center, )),
        ],
      ),
    );
  }
  Widget build_banner(ShopAppCubit cubit)=>ConditionalBuilder(
    condition: cubit.bannerModel!=null,
    builder: (context)=>CarouselSlider(
      items: cubit.bannerModel.data.map((e) => Image(
        image: NetworkImage('${e.image}'),
        width: double.infinity,
        fit: BoxFit.cover,
      ),).toList(),
      options: CarouselOptions(
          height: 250,
          initialPage: 0,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
          reverse: false,autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal
      ),),
    fallback: (context)=>Center(child: CircularProgressIndicator()),
  ) ;
  Widget build_category(ShopAppCubit cubit)=>ConditionalBuilder(
    condition: cubit.categoriesModel!=null,
    builder: (context)=>Container(
      height: 100.0,
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context ,int index)=>build_category_item(cubit.categoriesModel.data.data[index]),
          separatorBuilder: (context,index)=>SizedBox(width: 0.0,),
          itemCount: cubit.categoriesModel.data.data.length),
    ),
    fallback: (context)=>Center(child: CircularProgressIndicator()),
  ) ;
  Widget build_product(ProductData model , context)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 200,
              width: double.infinity,
            ),
            if (model.discount!=0)
              Text('DISCOUNT' , style: TextStyle(color: Colors.white , backgroundColor: Colors.red , fontSize: 10),)
          ],
        ),
        Text(
          model.description
          , style: TextStyle(fontSize: 15.0 ,),overflow: TextOverflow.ellipsis,maxLines: 2,) ,
        Row(
          children: [
             Text(model.price.toString()+" \$" , style: TextStyle(color: Colors.blue , fontSize: 12),),
            if (model.discount!=0)
              Text(model.old_price.toString()+"\$",style: TextStyle(color: Colors.green , fontSize: 10.0 , decoration: TextDecoration.lineThrough),),
            Spacer() ,
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 15,
              child: IconButton(
                  icon: Icon(ShopAppCubit.get(context).fav_icon , color: Colors.white,size: 15,),
                  onPressed: (){
                   // ShopAppCubit.get(context).ChangeFavoriteIcon() ;
                  }),
            ) ,

          ],
        )
      ],
    ),
  );
}
