import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertask/data/local/session_manager.dart';
import 'package:fluttertask/data/network/client/api_client.dart';
import 'package:fluttertask/data/network/client/connectivity_manager.dart';
import 'package:get/get.dart';

/// Define own methods of all types of api's. Like., GET, POST..etc
abstract class IApiProvider {

  Future<Either<String, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Progress? uploadProgress,
    Map<String, File>? files,
    bool isWithBody,
  });


}
class ApiProvider extends GetConnect implements IApiProvider {

  @override
  void onInit() {
    httpClient.baseUrl = ApiClient.apiBaseUrl;
    httpClient.maxAuthRetries = 3;
  }

  // this is post api method

  @override
  Future<Either<String, dynamic>?> postMethod<T>(
      String url,
      dynamic body, {
        Progress? uploadProgress,
        Map<String, File>? files,
        bool? isRawData = true,
        bool isWithBody = true,
        bool isUsedBaseUrl = true
      }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();
        final form = FormData({
          ...body,
        });

        if (files != null) {
          files.forEach((key, value) {
            String fileName = value.path.split('/').last;
            form.files.add(MapEntry(key, MultipartFile(value, filename: fileName)));
          });
        }

        var result = await post((isUsedBaseUrl == true ?ApiClient.apiBaseUrl:"") + url,isRawData == true? form:body, uploadProgress: uploadProgress, headers: {
          if (token != null) ...{
            'x-access-token': token,
          }else... {
            'Authorization': "Bearer AAAA7DR67wg:APA91bE6OMntXTg5JcFG-lBPC2tVaRe9Psdi2FocniW3vxIEyQPjAIhIHFhI0wpOeFnFI8B67qGQaRuRj_Lni97FgHfnf_Mal72wnANpLVd68KzdHa6_IiOV57QYXbZRQmM80S7Lhnsa",
          }
        });
        debugPrint('========${result.body}');
        debugPrint('========${result.bodyString}');
        debugPrint('========${result.bodyBytes}');
        debugPrint('Post Url :-${ApiClient.apiBaseUrl + url}');
        if ( result.body == null ) {
          if ( result.statusCode == 204 ) {
            return Right(result);
          }else {
            return const Left("something went Wrong");
          }
        }else {

          if(result.statusCode == 200){
            return Right(result.bodyString);

          }else {
            return const Left("something went Wrong");
          }
        }

      } else {
        return const Left("Check Your Internet Connectivity");
      }
    } catch (e, s) {
      debugPrint('$e \n $s');
      return const Left("SomeThing Went Wrong");
    }
    return null;
  }

}
