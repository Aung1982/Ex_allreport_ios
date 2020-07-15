import 'package:http/http.dart' as http;
import 'dart:convert';

class APIServices{

    static String insUpdDel ='http://150.95.88.102:60/api/InsUpdDel/';
static Map<String,String> header={
    'Content-type':'application/json',
    'Accept':'application/json'
  };

  static Future getUser(String v1) async {
    return await http.get(v1);
  }

static Future<List<dynamic>> getListData(String v1) async{
  final res = await http.get(v1);
  if (res.statusCode ==200){
    return json.decode(res.body);
  }
  else{
    return null;
  }
}
   static Future fechString(String v1) async{
       final res = await http.get(v1);
     return res;
   }

  static Future<bool>postRegister(Map reg) async{
     var ailBody = json.encode(reg);
       var res = await http.post(insUpdDel,headers: header,body: ailBody);
    return Future.value(res.statusCode ==200 ? true: false);
  }
}
  
