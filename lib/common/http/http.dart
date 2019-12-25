import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:lyyj/common/event/http_error_event.dart';
import 'package:lyyj/common/event/index.dart';

import '../../index.dart';

var httpClient = new HttpClient();
var tbzHttpClient = new TBZHttpClient();

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1001;
  static const NETWORK_ERROR_MSG = "网络错误,请检查网络";

  ///网络超时
  static const NETWORK_TIMEOUT = -1002;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -1003;

  static const SUCCESS = 200;

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}

class Api {
  static const String BASE_URL = "http://api.mamadezuji.com/api/";
}

class TBZApi {
  static const String BASE_URL = "http://api5.tubangzhu.net/v1/";
}

// 网络接口数据返回函数
typedef HttpCallback = void Function(int code, dynamic data, String message);

abstract class HttpBase {
  buildContext(BuildContext context);

  login<T>(
      {Map<String, dynamic> queryParameters,
      HttpCallback httpCallBack,
      String baseUrl,
      bool noCache = false,
      refresh = false});

  getRecommendList<T>(
      {int page = 1, int uid = -1, HttpCallback httpCallBack, refresh = false});

  getMyTemplateList<T>(
      {int page = 1,
      int uid = -1,
      int limit = 0,
      HttpCallback httpCallBack,
      refresh = false});
}

class TBZHttpClient extends HttpBase {
  BuildContext context;
  Options _options;

  factory TBZHttpClient() => _getInstance();

  static TBZHttpClient _instance;

  TBZHttpClient._internal();

  static TBZHttpClient _getInstance() {
    if (_instance == null) {
      _instance = new TBZHttpClient._internal();
    }
    return _instance;
  }

  Dio get dio => _dio;

  var _dio = Dio(BaseOptions(
    baseUrl: TBZApi.BASE_URL,
  ));

  init() {
    // 添加缓存插件
    _dio.interceptors.add(Global.cache);
    _dio.options.headers = _headers();
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    /*if (!Global.isRelease) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 10.1.10.250:8888";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }*/
    if (_options == null) {
      _options = Options();
    }
  }

  Map<String, dynamic> _headers() {
    String app_secret = "2tBxSfNdbGbKj3TtpNt6zMTQzzH5fH6Y";
    TubangzhuCooperation tubangzhuCooperation = new TubangzhuCooperation();
    String tempSign = app_secret +
        "app_id" +
        tubangzhuCooperation.app_id +
        "timestamp" +
        tubangzhuCooperation.timestamp +
        "uid" +
        tubangzhuCooperation.uid +
        "username" +
        tubangzhuCooperation.username +
        app_secret;
    tubangzhuCooperation.setSign =
        sha1.convert(utf8.encode(tempSign)).toString().toUpperCase();
    return {
      "Client": "tubangzhu_web",
      "TubangzhuCooperation": json.encode(tubangzhuCooperation.toJson()),
    };
  }

  @override
  buildContext(BuildContext context) {
    if (_options == null) {
      _options = Options();
    }
    _options.extra.addAll({"context": context});
    return this;
  }

  @override
  login<T>(
      {Map<String, dynamic> queryParameters,
      HttpCallback httpCallBack,
      String baseUrl,
      bool noCache = false,
      refresh = false}) {
    return null;
  }

  @override
  getRecommendList<T>(
      {int page = 1,
      int uid = -1,
      refresh = false,
      HttpCallback httpCallBack}) async {
    bool refresh = false;
    _options.extra
        .update("noCache", (value) => refresh, ifAbsent: () => refresh);
    _options.extra
        .update("refresh", (value) => refresh, ifAbsent: () => refresh);
    _options.extra.update("refresh", (value) => true, ifAbsent: () => true);
    var response = await _dio.get(
      "open-api-member/template-recommend",
      queryParameters: {"page": page, "uid": uid},
      options: _options,
    );
    httpCallBack(response.data.Code, response.data.Data, response.data.Message);
    return response.data.Data;
  }

  @override
  getMyTemplateList<T>(
      {int page = 1,
      int uid = -1,
      int limit = 10,
      HttpCallback httpCallBack,
      refresh = false}) async {
    bool refresh = false;
    _options.extra
        .update("noCache", (value) => refresh, ifAbsent: () => refresh);
    _options.extra
        .update("refresh", (value) => refresh, ifAbsent: () => refresh);
    _options.extra.update("refresh", (value) => true, ifAbsent: () => true);
    var response = await _dio.get("open-api-member/member-template",
        queryParameters: {"uid": uid, "page": page, "limit": limit},
        options: _options);
    httpCallBack(response.data.Code, response.data.Data, response.data.Message);
    return response.data.Data;
  }
}

class TubangzhuCooperation {
  String app_id = "f1563g9ef35y20p3";
  String timestamp = (DateTime.now().millisecondsSinceEpoch).toString();
  String sign;
  String uid =
      Global.profile.user != null ? Global.profile.user.uid.toString() : "-1";
  String username = "jiubanganju";

  TubangzhuCooperation();

  TubangzhuCooperation.fromJson(Map<String, dynamic> json)
      : app_id = json['app_id'],
        timestamp = json['timestamp'],
        sign = json['sign'],
        uid = json['uid'],
        username = json['username'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'app_id': app_id,
        'timestamp': timestamp,
        'sign': sign,
        'uid': uid,
        'username': username,
      };

  void set setSign(String sign) => this.sign = sign;
}

class HttpClient extends HttpBase {
  BuildContext context;
  Options _options;

  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  /*HttpClient([this.context]) {
    _options = Options(extra: {"context": context});
  }*/

  //私有构造函数
  HttpClient._internal();

  static HttpClient _singleton = new HttpClient._internal();

  factory HttpClient() => _singleton;

  Dio get dio => _dio;

  var _dio = Dio(BaseOptions(
    baseUrl: Api.BASE_URL,
  ));

  init() {
    // 添加缓存插件
    _dio.interceptors.add(Global.cache);
    _dio.options.headers = _headers();
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!Global.isRelease) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 10.1.10.250:8888";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Map<String, dynamic> _headers() {}

  buildContext(BuildContext context) {
    _options = Options(extra: {"context": context});
    return this;
  }

  @override
  login<T>(
      {Map<String, dynamic> queryParameters,
      HttpCallback httpCallBack,
      String baseUrl,
      bool noCache = false,
      refresh = false}) async {
    if (baseUrl != null) _dio.options.baseUrl = baseUrl;
    var response = await _dio.get(
      "UserInfo/Login",
      queryParameters: queryParameters,
      options: _options.merge(
        extra: {
          "noCache": noCache,
        },
      ),
    );
    LYYJResponse res = LYYJResponse.fromJson(response.data);
    httpCallBack(res.Code, res.Data, res.Message);
  }

  @override
  getRecommendList<T>(
      {int page = 1,
      int uid = -1,
      HttpCallback httpCallBack,
      refresh = false}) {
    return null;
  }

  @override
  getMyTemplateList<T>(
      {int page = 1,
      int uid = -1,
      int limit = 0,
      HttpCallback httpCallBack,
      refresh = false}) {
    return null;
  }
}
