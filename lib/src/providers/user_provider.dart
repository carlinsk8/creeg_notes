import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {

  final String _apiKey= 'AIzaSyDIXPaCmLVZaCT60HVpAAdn3UzHh5bYwWw';

  Future newUser(String email, String password) async {

    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if( decodedResp.containsKey('idToken')){
      // TODO: Saalvar token storage
      return {'ok': true, 'token': decodedResp['idToken']};
    }else{
      return {'ok': false, 'message': decodedResp['error']['message']};
    }

  }

}