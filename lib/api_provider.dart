import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiProvider {
  ApiProvider();

  String apiUrl = "http://203.209.96.245/webservice_r1/web/index.php/api";

  Future<http.Response> getUsers() async {
    String url = 'https://randomuser.me/api/?results=20';
    return await http.get(url);
  }

  Future<http.Response> getQof() async {
    String url = '$apiUrl/qof';
    return await http.get(url);
  }

  Future<http.Response> getQofScoreChw(String qofId) async {
    String url = '$apiUrl/qofchw?id=$qofId';
    return await http.get(url);
  }

  Future<http.Response> getQofScoreAmpur(String qofId, String chwId) async {
    String url = '$apiUrl/qofamp?chwcode=$chwId&id=$qofId';
    return await http.get(url);
  }

  Future<http.Response> getLogin(String username, String password) async {
    String url = 'http://172.16.192.57:3000/login';
    var params = {'username': username, 'password': password};
    return await http.post(url, body: params);
  }

  Future<http.Response> getApiUsers(String token) async {
    String url = 'http://172.16.192.57:3000/users';
    return await http
        .get(url, headers: {HttpHeaders.AUTHORIZATION: "Bearer $token"});
  }
}
