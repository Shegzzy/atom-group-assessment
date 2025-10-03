import 'package:dio/dio.dart';

import '../../utils/api_client.dart';
import '../../utils/app_logger.dart';

class ReviewRepository {
  Future<dynamic> getCompanyReviews (String query, int page) async {
    String url = "/company-reviews";
    Map<String, dynamic> queryParameters = {
      'company_domain': query,
      'page': page,
    };

    try {
      Response response = await ApiClient.instance.dioGet(url, queryParameters: queryParameters);
      AppLogger.instance.logInfo(response.data);
      return response;
    } on DioException catch (e) {
      return ApiClient.instance.dioErrorReturner(e);
    }
  }
}