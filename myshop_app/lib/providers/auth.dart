import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String emailAddress, String password, String urlSegment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyB3mqaCINkBfGnVlId3EVRAMR9fNgWukGI";

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "email": emailAddress,
          "password": password,
          "returnSecureToken": true,
        }),
      );
      final responseData = json.decode(response.body);

      if (responseData["error"] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData["idToken"];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();

      /*The below code is for saving the user authentication details on device
     for maintaining the user session of login as once app is closed the 
     variables data is lost and the session details as well which need to be 
     maintained. */

      final preferencesToStoreInDeviceStorage =
          await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      preferencesToStoreInDeviceStorage.setString('userData', userData);

      // print("-------------------------------------");
      // print("preference written");
      // print(userData);

      // print("-------------------------------------");
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String emailAddress, String password) async {
    return _authenticate(emailAddress, password, "signUp");
  }

  Future<void> login(String emailAddress, String password) async {
    return _authenticate(emailAddress, password, "signInWithPassword");
  }

  Future<bool> autoLoginSuccessOnAppStart() async {
    final pref = await SharedPreferences.getInstance();

    if (!pref.containsKey('userData')) {
      return false;
    }
    // print("in auto login ");

    final extractedUserData =
        json.decode(pref.getString("userData")) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    // print("-------------------------------------");
    // print(expiryDate.isAfter(DateTime.now()));
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    // print("All condition true");
    // print(extractedUserData['expiryDate']);

    _token = extractedUserData['token'];
    // print(_token);
    _userId = extractedUserData['userId'];
    // print(_userId);
    _expiryDate = expiryDate;
    // print(_expiryDate);

    // print("value assigned");

    notifyListeners();
    _autoLogout();

    // print("in auto preference retrieved");
    // print("-------------------------------------");
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    /* pref.remove('userData');  //if you want to delete entire object can have
    multiple data in it but if you want the data to remain saved then*/
    pref.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
      Duration(seconds: timeToExpiry),
      logout,
    );

    // print("Timer Reset");
  }
}
