/*For making method template
*/
abstract class BaseApiServices {
  Future<dynamic> getApiResponse(String url);

  Future<dynamic> postApiResponse(String ur, dynamic data);
}
