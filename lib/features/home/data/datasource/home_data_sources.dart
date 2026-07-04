import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/home/domain/entities/home_entities.dart';

abstract class HomeRemoteDataSource {
  Future<HomeDataEntity> getHomeData();
  Future<List<AdEntity>> getAds();
  Future<List<EventEntity>> getEvents();
}

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
    final list = response.data as List<dynamic>? ?? [];
    return list.map((e) => AdEntity(
      id: e['id'] as int?,
      title: e['title']?.toString(),
      description: e['description']?.toString(),
      image: e['image']?.toString(),
    )).toList();
  }

  @override
  Future<List<EventEntity>> getEvents() async {
    final response = await _apiClient.get(ApiEndpoints.meetings);
    final list = response.data as List<dynamic>? ?? [];
    return list.map((e) => EventEntity(
      id: e['id'] as int?,
      title: e['title']?.toString(),
      startDate: e['start_date']?.toString(),
    )).toList();
  }
}
