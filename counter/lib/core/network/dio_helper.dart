import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'endpoints.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE,PATCH,OPTIONS'
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      error: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ),);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
      };
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  static Future<Response> postFormData({
    required String url,
    required FormData formData,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept': 'application/json',
      };
      final Response response = await dio.post(
        url,
        data: formData,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept': 'application/json',
      };
      final Response response = await dio.post(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }



  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept': 'application/json',
      };
      final Response response = await dio.put(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final Response response = await dio.patch(
        url,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    required String token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      final Response response = await dio.delete(
        url,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}