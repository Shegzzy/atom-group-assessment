
import 'app_logger.dart';
import 'app_snackbar.dart';
import 'env.dart';
import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._privateConstructor();
  static final ApiClient instance = ApiClient._privateConstructor();
  Dio? myDioClient;


  Future<void> initializeDio() async{
    var options = BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: const Duration(milliseconds: 50000),
        receiveTimeout: const Duration(milliseconds: 50000)
    );

    myDioClient =  Dio(options);
  }

  dynamic dioErrorReturner(dynamic error){
    AppLogger.instance.logInfo(error);
    AppLogger.instance.appLogger!.e(error.response);

    if(error.response != null && (error.response.statusCode == 401 || error.response.statusCode == 404)){
      showErrorBar("Something went wrong. Please try again.");
    }


    if(error is DioException){
      switch (error.type){
        case DioExceptionType.connectionTimeout:
          AppLogger.instance.logError("This operation failed. Timeout connecting to server");
          showErrorBar("This operation failed. Timeout connecting to server");
        case DioExceptionType.sendTimeout:
          AppLogger.instance.logError("This operation failed. Timeout sending request");
          showErrorBar("This operation failed. Timeout sending request");
        case DioExceptionType.receiveTimeout:
          AppLogger.instance.logError("This operation failed. Timeout receiving response");
          showErrorBar("This operation failed. Timeout receiving response");
        case DioExceptionType.badCertificate:
          AppLogger.instance.logError("This operation failed. Bad certificate");
          showErrorBar("This operation failed. Bad certificate");

        case DioExceptionType.badResponse:
          AppLogger.instance.logError("This operation failed. Bad response");
          var errorMsg = '';

          if(error.response != null && error.response!.data != null){
            errorMsg = '${error.response!.data['message']}';
            // showErrorBar(errorMsg);
            return error.response;
          }
          else {
            errorMsg = 'This operation failed. Bad response';
            showErrorBar(errorMsg);
            return null;
          }

        case DioExceptionType.cancel:
          AppLogger.instance.logError("This operation was cancelled. Try again.");
          showErrorBar("This operation was cancelled. Try again.");
          return null;
        case DioExceptionType.connectionError:
          AppLogger.instance.logError("It seems you are having network issues. Please check the internet connectivity and try again.");
          showErrorBar("It seems you are having network issues. Please check the internet connectivity and try again.");
          return null;
        case DioExceptionType.unknown:
          return 'unknown';
      }
    }
    else {
      if(error.response != null){
        AppLogger.instance.appLogger!.e(error.response.statusCode);
        AppLogger.instance.appLogger!.e(error.response);
        return error.response;
      }
      else{
        AppLogger.instance.appLogger!.e(error);
        AppLogger.instance.appLogger!.e(error.message);
        AppLogger.instance.appLogger!.e(error.requestOptions);
        return null;
      }
    }

  }

  Future<Response> dioGet(url, {Map<String, dynamic>? queryParameters}) async {
    return myDioClient!.get(
      url,
      options: await getOptionsWithToken(),
      queryParameters: queryParameters,
    );
  }

  Future<Options>  getOptionsWithToken() async{
    return Options(
        contentType: 'application/json',
        headers: {
          'x-rapidapi-host': ' trustpilot-company-and-reviewsdata.p.rapidapi.com',
          'x-rapidapi-key': Api.apiKey,
        }
    );
  }

}