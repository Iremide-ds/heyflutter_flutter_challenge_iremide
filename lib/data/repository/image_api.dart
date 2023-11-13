import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/config/constants.dart';
import 'package:weather_app/data/models/img.dart';

part 'image_api.g.dart';

@RestApi(baseUrl: AppConsts.host2)
abstract class ImageRestClient {
  factory ImageRestClient(Dio dio, {String baseUrl}) = _ImageRestClient;

  @GET('/search/photos')
  Future<UnsplashResult> getImage(
      @Query('client_id') String key,
      @Query('query') String query,
      @Query('page') int page,
      @Query('per_page') int perPage,
      @Query('orientation') String orientation);
}
