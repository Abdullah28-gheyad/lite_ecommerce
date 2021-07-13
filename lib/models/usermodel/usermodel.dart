class UserModel
{
  bool status  ;
  String message ;
  UserData data ;
  UserModel(this.status , this.message , this.data) ;
  UserModel.FromJson(Map<String,dynamic>json)
  {
    status = json['status'] ;
    message = json['message'] ;
    data = json['data']!=null?UserData.FromJsot(json['data']):null ;
  }
}

class UserData {
  int id ;
  String email ;
  String name ;
  String phone ;
  String image ;
  int points ;
  int credit ;
  String token ;
  UserData({this.id, this.email, this.name, this.phone, this.image, this.points, this.credit, this.token,}) ;
  UserData.FromJsot(Map<String,dynamic> json)
  {
    id = json['id'] ;
    email = json['email'] ;
    name = json['name'] ;
    phone = json['phone'] ;
    image = json['image'] ;
    points = json['points'] ;
    credit = json['credit'] ;
    token = json['token'] ;
  }
}