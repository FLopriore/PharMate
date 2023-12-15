import 'dart:convert';
import 'dart:io';

import 'package:pharmate/authorization/login_secure_storage.dart';

class CallApi {
  final String _url = "https://feddynventor.ddns.net/pharm8/";

  // POST
  Future<dynamic> postData(data, String apiUrl) async {
    String fullUrl = _url + apiUrl;
    HttpClient client = HttpClient();
    // Bypass SSL certification
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.postUrl(Uri.parse(fullUrl));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('accept', '*/*');

    String? token = await LoginSecureStorage.getLoginSecureStorage('loginToken');
    request.headers.set('Authorization', 'Bearer ${token!}');
    request.add(utf8.encode(jsonEncode(data)));
    HttpClientResponse result = await request.close();

    if (result.statusCode == 200) {
      return jsonDecode(await result.transform(utf8.decoder).join());
    } else {
      return null;
    }
  }

  // Get
  Future<dynamic> getData(String apiUrl) async {
    String fullUrl = _url + apiUrl;
    HttpClient client = HttpClient();
    // Bypass SSL certification
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.getUrl(Uri.parse(fullUrl));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('accept', '*/*');

    String? token = await LoginSecureStorage.getLoginSecureStorage('loginToken');
    request.headers.set('Authorization', 'Bearer ${token!}');
    HttpClientResponse result = await request.close();

    if (result.statusCode == 200) {
      return jsonDecode(await result.transform(utf8.decoder).join());
    }
    return null;
  }

  //DELETE
  Future<dynamic> deleteData(data, String apiUrl) async {
    String fullUrl = _url + apiUrl;
    HttpClient client = HttpClient();
    // Bypass SSL certification
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.deleteUrl(Uri.parse(fullUrl));
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('accept', '*/*');

    String? token = await LoginSecureStorage.getLoginSecureStorage('loginToken');
    request.headers.set('Authorization', 'Bearer ${token!}');
    request.add(utf8.encode(jsonEncode(data)));
    HttpClientResponse result = await request.close();

    if (result.statusCode == 200) {
      return jsonDecode(await result.transform(utf8.decoder).join());
    } else {
      return null;
    }
  }
  }