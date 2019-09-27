import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lyyj/common/event/http_error_event.dart';
import 'package:lyyj/common/event/index.dart';

import '../../index.dart';

HttpBase httpClient = new HttpClient();

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

// 网络接口数据返回函数
typedef HttpCallback<T> = void Function(int code, T data, String message);

abstract class HttpBase {
  buildContext(BuildContext context);

  login<T>(
      {Map<String, dynamic> queryParameters,
      HttpCallback<T> httpCallBack,
      String baseUrl,
      bool noCache = false,
      refresh = false});
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
      HttpCallback<T> httpCallBack,
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
    LYYJResponse<T> res = LYYJResponse.fromJson(response.data);
    httpCallBack(res.Code, res.Data, res.Message);
  }
}
