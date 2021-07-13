class ProductModel
{
  bool status ;
  String message ;
  Data data ;
  ProductModel({this.data,this.status,this.message}) ;
  ProductModel.FromJson(Map<String,dynamic>json)
  {
    status=json['status'] ;
    message=json['message'] ;
    data=json['data']!=null? Data.FromJson(json['data']):null ;
  }
}

class Data {
  List <ProductData> products ;
  Data(this.products) ;
  Data.FromJson(Map<String,dynamic>json)
  {
    if (json['products']!=null)
      {
        products=new List<ProductData>() ;
        json['products'].forEach((v)
        {
          products.add(new ProductData.FromJson(v)) ;
        });
      }
  }
}

class ProductData {
  int id ;
  dynamic price ;
  dynamic old_price ;
  dynamic discount ;
  String image ;
  String name ;
  String description ;
  bool infav ;
  bool incart ;
  ProductData({this.id ,this.image,this.old_price,this.name,this.discount,this.price,this.description,this.incart,this.infav}) ;
  ProductData.FromJson(Map <String,dynamic> json )
  {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    infav = json['in_favorites'];
    incart = json['in_cart'];
  }
}

