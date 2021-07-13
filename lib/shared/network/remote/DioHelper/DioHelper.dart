import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper
{
  static Dio dio ;
  static void init()
  {
    dio = Dio(BaseOptions(
     baseUrl: 'https://student.valuxapps.com/api/' ,
      receiveDataWhenStatusError: true ,
      headers: {
       'Content-Type':'application/json' ,
        'lang':'ar' ,
      }
    ));
  }

  static Future <Response> getData (
  {
  String Authorization ='' ,
    dynamic Data ,
    dynamic quary ,
    @required String url ,
}
      )
  async {
      dio.options.headers={
        'Authorization':Authorization
      } ;
      return await dio.get(url , queryParameters: quary );
  }
  static Future <Response> postdata(
  {
  @required String url ,
  @required dynamic data ,
   dynamic quarey ,
   dynamic token ,

}
      )
  async {
    dio.options.headers={'Authorization':token} ;
    return await dio.post(url ,queryParameters:quarey ,data: data  ) ;
  }


  static Future <Response> put_data(
      {
        @required String url ,
        @required dynamic data ,
        dynamic quarey ,
        dynamic token ,

      }
      )
  async {
    dio.options.headers={'Authorization':token} ;
    return await dio.put(url,data: data) ;
  }


}