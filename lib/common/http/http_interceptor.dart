import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lyyj/index.dart';

class CacheModel {
  CacheModel(this.response) : timeStamp = DateTime.now().millisecondsSinceEpoch;

  Response response;
  int timeStamp;

  @override
  bool operator ==(Object other) => response.hashCode == other.hashCode;

  @override
  int get hashCode => response.realUri.hashCode;
}

class HttpInterceptors extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheModel>();

  @override
  FutureOr<dynamic> onRequest(RequestOptions options) async {
    // 配置超时
    options.connectTimeout = 8000;
    // 配置打印数据
    if (!Global.isRelease) {
      print("Flutter_Http:请求base_url：${options.baseUrl}");
      print("Flutter_Http:请求url：${options.path}");
      print('Flutter_Http:请求头: ' + options.headers.toString());
      print('Flutter_Http:请求参数: ' + options.queryParameters.toString());

      if (options.data != null) {
        print('Flutter_Http:请求参数: ' + options.queryParameters.toString());
      }
    }
    //配置无网络时的数据
    /*var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var responseData = LYYJResponse();
      responseData.Data = null;
      responseData.Code = Code.NETWORK_ERROR;
      responseData.Message = Code.errorHandleFunction(
          Code.NETWORK_ERROR, Code.NETWORK_ERROR_MSG, false);
      return (httpClient as HttpClient)
          .dio
          .resolve(Response(data: responseData));
    }*/
    // 配置缓存
    if (!Global.profile.cache.enable) return options;
    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;
    if (refresh) {
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }
      return options;
    }
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }
    }
  }

  @override
  onError(DioError err) {
    // 错误状态不缓存
    if (!Global.isRelease) {
      print('Flutter_Http:请求异常: ' + err.toString());
      print('Flutter_Http:请求异常信息: '+ err.response?.toString()??"");
    }
  }

  @override
  onResponse(Response response) {
    // 如果启用缓存，将返回结果保存到缓存
    if (!Global.isRelease) {
      print('Flutter_Http:返回参数: ' + response.toString());
    }
    if (response.request.baseUrl == TBZApi.BASE_URL) {
      print("onResponse:");
      LYYJResponse res = LYYJResponse();
      if (response.data["success"]) {
        res.Code = 1;
        res.Message = "数据返回成功";
        res.Data = response.data["data"]["data"];
      } else {
        res.Code = -1;
        res.Message = response.data["data"]["message"];
        res.Data = null;
      }
      response.data = res;
      print("onResponse:"+json.encode(response.data));
      return response;
    }
//    if (Global.profile.cache.enable) {
//      _saveCache(response);
//    }
  }

  void _saveCache(Response response) {
    RequestOptions options = response.request;
    if (response.data["Code"] != 1) {
      return;
    }
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheModel(response);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
