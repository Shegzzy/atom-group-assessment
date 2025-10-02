import 'package:atom_assessment/features/utils/api_client.dart';
import 'package:dio/dio.dart';

import '../../utils/app_logger.dart';

class SearchCompanyRepository {

  Future<dynamic> getSearchResults (String query, int page) async {
    String url = "company-search";
    Map<String, dynamic> queryParameters = {
      'query': query,
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