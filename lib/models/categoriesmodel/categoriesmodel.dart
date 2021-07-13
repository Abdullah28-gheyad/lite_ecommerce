class CategoriesModel
{
  bool status ;
  String message ;
  CategoryDataModel data ;
  CategoriesModel({this.status,this.message,this.data}) ;
  CategoriesModel.FromJson(Map<String,dynamic> json)
  {
    status=json['status'] ;
    message=json['message'] ;
    data=json['data']!=null?CategoryDataModel.FromJson(json['data']):null ;
  }
}
class CategoryDataModel{
int currentpage ;
List<CategoryData> data ;
CategoryDataModel({this.currentpage,this.data}) ;
CategoryDataModel.FromJson(Map<String,dynamic> json)
{
  currentpage = json['current_page'];
  if (json['data']!=null)
  {
    data = new List<CategoryData>() ;
    json['data'].forEach((v){
      data.add(new CategoryData.FromJson(v));
    });
  }
}
}


class CategoryData {
  int id  ;
  String name ;
  String image ;
  CategoryData({this.id,this.name,this.image}) ;
  CategoryData.FromJson(Map<String,dynamic> json)
  {
    id = json['id'] ;
    name = json['name'] ;
    image = json['image'] ;
  }
}