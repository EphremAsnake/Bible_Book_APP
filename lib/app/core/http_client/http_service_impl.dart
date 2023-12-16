import 'package:bible_book_app/app/core/http_client/http_service.dart';
import 'package:bible_book_app/app/core/http_client/http_status_code_worth_retrying.dart';
import 'package:bible_book_app/app/core/http_client/htttp_attrib_options.dart';
import 'package:bible_book_app/app/core/http_client/process_http_request.dart';
import 'package:bible_book_app/app/core/http_exeption_handler/http_exception_handler.dart';
import 'package:bible_book_app/app/utils/shared_widgets/snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class HttpServiceImpl implements HttpService {
  @override
  Future<dynamic> sendHttpRequest(
      HttpClientAttributeOptions httpAttribOptions) async {
    try {
      // instantiating  http client class
      final httpClient =
          RetryClient(http.Client(), retries: httpAttribOptions.retries,
              when: (http.BaseResponse response) {
        return HttpStatusWorthRetying.isWorthRetrying(response.statusCode);
      });

      //instantiating response object
      http.Response? response;

      //instantiating http processor class
      ProcessHttpRequest processHttpRequest = ProcessHttpRequest();

      switch (httpAttribOptions.method) {
        case HttpMethod.GET:
          response = await processHttpRequest.processGetRequest(
              httpClient, httpAttribOptions);
          if (response.statusCode == 200) {
            return response;
          }
          break;
        default:
          break;
      }
    } on Exception catch (e) {
      String message = await HandleHttpException().getExceptionString(e);
      customSnackBar(title: 'Error', body: message);
    }
    return null;
  }
}
