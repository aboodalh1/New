import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DioHelper {
  final baseUrl = 'https://api.behealthy-dxb.com/api';
  final Dio dio;
  static String ? _token;
  DioHelper(this.dio);


  static Future setConnectionParameter({required String token,required String name,required int id})async{
    _token = token;

    storeToken(token,name,id);
    return;
  }
  static Future<void> storeToken(String token,String name,int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setInt('id', id);
    await prefs.setString('name', name);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }
  static Future<int?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }
  static Future<String?> getLastRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_route');
  }
  static  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

   Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
    String lang = "en",
    String? contentType,
    String? accept,
  }) async {
     _token =await getToken();
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    if (_token != null) {
      headers.addAll({'Authorization': 'Bearer $_token'});
    }
    return await dio
        .get('$baseUrl$endPoint',
        queryParameters: query,
        data: query,
        options: Options(
          contentType: 'Application/json',
          validateStatus: (v)=>v!=null &&v>=200 &&v<=430,
          receiveDataWhenStatusError: true,
          extra: query,
          headers: headers,
        ));
  }


  Future<Response> postData(
      {required String endPoint,
        required var data,
        String? token}) async {
    Map<String, String> headers = {
      'Accept':'application/json'

    };
    if (_token != null) {
      _token =await getToken();
      headers.addAll({'Authorization': 'Bearer $_token'});
    }
    return dio.post('$baseUrl$endPoint',
        data: data,
        options: Options(
            receiveDataWhenStatusError: true,
            headers: headers));
  }
  Future<Response> putData(
      {required String endPoint,
        required Map<String, dynamic> data,
        String lang = "en",
        String? token}) async {
    _token =await getToken();
    dio.options.headers = {
      'Accept': 'application/json',
      'lang': lang,
      'Authorization': 'Bearer $token'
    };
    return await dio.put('$baseUrl$endPoint', data: data);
  }

  Future<Response> deleteData(

      {required String endPoint,
        Map<String, dynamic>? query,
        }) async {
    _token =await getToken();
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    };

    return await dio.delete('$baseUrl$endPoint',
        queryParameters: query,
        options: Options(
        ));
  }
}
