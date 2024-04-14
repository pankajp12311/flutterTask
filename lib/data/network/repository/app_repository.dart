import 'package:dartz/dartz.dart';
import 'package:fluttertask/data/network/client/api_client.dart';
import 'package:fluttertask/data/network/client/api_provider.dart';

/// App related all api will be done here
class AppRepository extends ApiProvider {

// this is push notification api method
  Future<Either<String, String>?> sendNotification(
      Map<String, dynamic> params) async {

    var response = await postMethod<String>(ApiClient.sendNotification, params);
    return response?.fold((l) => Left(l), (r) => Right(r as String));
  }
}
