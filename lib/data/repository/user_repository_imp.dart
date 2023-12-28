
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project/data/local/database.dart';
import 'package:flutter_project/data/remote/response/response_info.dart';
import 'package:flutter_project/data/remote/response/response_user_login.dart';
import 'package:flutter_project/data/remote/state/state_info.dart';
import 'package:flutter_project/domain/models/user_data.dart';
import 'package:flutter_project/domain/repository/user_repository.dart';
import 'package:flutter_project/utils/encryption_aes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserRepositoryImp implements UserRepository {

  static const JWT_LOGIN_SECRET = "a2b0e0c3-93c9-4795-b58e-4d6e8f64056f";

  @override
  Future<bool> insert(UserData user) async {
    try {
        final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
        final userDataDao = database.userDataDao;
        final userData = await find();
        if (userData?.login == user.login && userData?.password == user.password) {
          return true;
        } else {
          if (userData != null) {
            await deleteAll();
          }
          await userDataDao.insertUser(user);
          return true;
        }
    } catch (e) {
        print(e);
        return false;
    }
  }

  @override
  Future<UserData?> find() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final userDataDao = database.userDataDao;
      return await userDataDao.find();
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<bool> deleteAll() async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final userDataDao = database.userDataDao;
      await userDataDao.deleteAll();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> asyncLogin(String login, String password) async {
    try {
      final dio = Dio();
      dio.options.headers["content-type"] = "application/json";
      var data = {
        'userName': login,
        'password': password,
        'platform': "flutter",
      };

      var crypto = encrypt(jsonEncode(data));

      final response = await dio.post(
          'http://192.168.203.56:8081/auth/signincode',
          data: {
            'token': crypto
          },
          options: Options(
            contentType: Headers.jsonContentType,
            headers: {
              Headers.acceptHeader: Headers.jsonContentType,
              Headers.contentTypeHeader: Headers.jsonContentType,
              // 'Accept': 'application/json',
              // 'Content-Type': 'application/json',
            }
          ),
      );
      print("response $response");
      ResponseUserLogin responseInfo = ResponseUserLogin.fromJson(response.data);
      print("loginResponse  $responseInfo");
      if(responseInfo.authenticated == true) {
        if (kIsWeb) {
          final prefs = await SharedPreferences.getInstance();
          bool isLogin = await prefs.setString('user', login);
          bool isPass = await prefs.setString('pass', password);

          return isLogin && isPass;
        } else {
          bool result = await insert(
              UserData(1, login, password, "", responseInfo.expiration!, responseInfo.accessToken!, responseInfo.refreshToken!)
          );
          return result;
        }
      } else {
        return false;
      }
    } catch(e) {
      print("Error Dio $e");
      return false;
    }
  }

  @override
  Future<StateInfo> asyncRegisterUser(String fullName, String email, String userName, String password) async{
    try {
      final dio = Dio();
      dio.options.headers["content-type"] = "application/json";

      var data = {
        'userName': userName,
        'fullName': fullName,
        'email': email,
        'password': password,
        'platform': "flutter",
      };

      var crypto = encrypt(jsonEncode(data));

      final response = await dio.post(
        'http://192.168.203.56:8081/auth/signuptoken',
        data: {
          'token': crypto
        },
        options: Options(
            contentType: Headers.jsonContentType,
            headers: {
              Headers.acceptHeader: Headers.jsonContentType,
              Headers.contentTypeHeader: Headers.jsonContentType,
            }
        ),
      );
      print("response ${response.data}");
      ResponseInfo responseInfo = ResponseInfo.fromJson(response.data);
      print("loginResponse  $responseInfo");
      return StateInfo(responseInfo.status, responseInfo.info);
    } catch(e) {
      print("Error Dio $e");
      return StateInfo(false, "Usuário não cadastrado!");
    }
  }



}