import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/home/data/datasource/home_data_sources.dart';
import 'package:wassl/features/home/domain/entities/home_entities.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient _apiClient;

  HomeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<HomeDataEntity> getHomeData() async {
    final ads = await getAds();
    final events = await getEvents();
    return HomeDataEntity(ads: ads, events: events);
  }

  @override
  Future<List<AdEntity>> getAds() async {
    final response = await _apiClient.get(ApiEndpoints.ads);
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      final list = (json['ads']?['data'] as List<dynamic>?) ?? (json['data'] as List<dynamic>?) ?? [];
      return list.map((e) => AdEntity(
        id: e['id'] as int?,
        title: e['_title']?.toString(),
        description: e['_description']?.toString(),
        image: e['_image']?.toString(),
      )).toList();
    }
    throw ServerException(statusCode: response.statusCode);
  }

  @override
  Future<List<EventEntity>> getEvents() async {
    final response = await _apiClient.get(ApiEndpoints.meetings);
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      final list = (json['events']?['data'] as List<dynamic>?) ?? (json['data'] as List<dynamic>?) ?? [];
      return list.map((e) => EventEntity(
        id: e['id'] as int?,
        title: e['_title']?.toString(),
        description: e['_description']?.toString(),
        startDate: e['_start_date']?.toString(),
        endDate: e['_end_date']?.toString(),
        location: e['_location']?.toString(),
      )).toList();
    }
    throw ServerException(statusCode: response.statusCode);
  }
}
