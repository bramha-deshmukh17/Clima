import 'package:http/http.dart' as http;

class FetchData{

  FetchData(this.url);

  final String url;

  Future<http.Response> getResponse() async{
    http.Response response = await http.get(Uri.parse(url));
    return response;
  }
}