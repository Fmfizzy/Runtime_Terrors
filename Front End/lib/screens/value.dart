import 'package:http/http.dart';

const String url = "http://192.168.1.100:8086";
String userId = "";

Future<String> getUserId() async{

  if (userId.isEmpty) {
    final uri = Uri.parse(url + "/id");
    var response = await get(uri);
    userId = response.body;
  }
  return userId;
}
