class BannerModel
{
  bool status ;
  String message ;
  List <BannerData> data ;
  BannerModel({this.status , this.message , this.data}) ;
  BannerModel.FromJson(Map<String,dynamic>json)
  {
    status = json['status'] ;
    message = json['message'] ;
   if (json['data']!=null)
     {
       data = new List<BannerData>();
       json['data'].forEach((v){
         data.add(new BannerData.FromJson(v)) ;
       }) ;
     }
  }
}

class BannerData {
  int id ;
  String image ;
  BannerData({this.id , this.image ,}) ;
  BannerData.FromJson(Map<String , dynamic> json)
  {
    id = json['id'] ;
    image = json['image'] ;
  }
}