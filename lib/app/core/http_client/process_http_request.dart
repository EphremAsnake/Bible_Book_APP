import 'package:bible_book_app/app/core/http_client/htttp_attrib_options.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class ProcessHttpRequest {
  Future<http.Response> processGetRequest(RetryClient httpClient,
      HttpClientAttributeOptions httpAttribOptions) async {
    Uri uri = Uri.parse( httpAttribOptions.baseUrl + httpAttribOptions.url);
    return await httpClient
        .get(
          uri,
          headers: httpAttribOptions.headers,
        )
        .timeout(
          Duration(seconds: httpAttribOptions.connectionTimeout),
        );
  }

}