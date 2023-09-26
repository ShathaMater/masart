import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'connectivity.dart';
import 'status_request.dart';

class ApiRequest {
  /////////////.............
  ///
  ///
  // .. get-request
  static Future<RResponse> get(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? header,
    bool isAuth = true,
  }) async {
    final Dio dio = Dio();
    // String _token = await SPService.instance.getToken();
    // get local-language-sp
    if (header != null) dio.options.headers = header;
    dio.options.contentType = 'application/json';
    dio.options.headers['accept'] = 'application/json';
    if (isAuth) {
      // dio.options.headers["authorization"] = 'Bearer $_token';
    }
    if (params?.isNotEmpty ?? false) dio.options.queryParameters = params!;
    if (await Reachability.isInternetConected()) {
      log(path);

      Response response;
      try {
        response = await dio.get(path);
        return RResponse(StatusRequest.success, response);
      } on DioException catch (e) {
        return RResponse(StatusRequest.serverFailure, e.response);
      }
    } else {
      return const RResponse(StatusRequest.offline, null);
    }
  }

  // post
  static Future<RResponse> post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, dynamic>? header,
    bool isAuth = true,
  }) async {
    final Dio dio = Dio();
    // String _token = await SPService.instance.getToken();
    // FormData formData;
    // formData = FormData.fromMap(body ?? Map());
    //jsonEncode(body)
    // get local-language-sp
    if (header != null) dio.options.headers = header;
    dio.options.contentType = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    dio.options.headers["language"] = 'ar';
    if (isAuth) {
      // dio.options.headers["authorization"] = 'Bearer $_token';
    }
    // params
    if (params?.isNotEmpty ?? false) dio.options.queryParameters = params!;
    // request
    if (await Reachability.isInternetConected()) {
      log(path);
      Response response;
      try {
        response = await dio.post(path, data: jsonEncode(body));
        return RResponse(StatusRequest.success, response);
      } on DioException catch (e) {
        return RResponse(StatusRequest.serverFailure, e.response);
      }
    } else {
      return const RResponse(StatusRequest.offline, null);
    }
  }

  //
  static Future<RResponse> patch(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    bool isAuth = true,
  }) async {
    final Dio dio = Dio();
    // String _token = await SPService.instance.getToken();

    // get local-language-sp
    dio.options.contentType = 'application/json';
    dio.options.headers["accept"] = 'application/json';
    if (isAuth) {
      // dio.options.headers["authorization"] = 'Bearer $_token';
    }
    // params
    if (params?.isNotEmpty ?? false) dio.options.queryParameters = params!;
    // request
    if (await Reachability.isInternetConected()) {
      log(path);
      Response response;
      try {
        response = await dio.patch(path, data: jsonEncode(body));
        return RResponse(StatusRequest.success, response);
      } on DioException catch (e) {
        return RResponse(StatusRequest.serverFailure, e.response);
      }
    } else {
      return const RResponse(StatusRequest.offline, null);
    }
  }
  //
  //
}

//
class RResponse {
  final StatusRequest statusRequest;
  final Response? response;
  const RResponse(this.statusRequest, this.response);
}
