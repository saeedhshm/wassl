import 'package:wassl/features/home/data/datasource/home_data_sources.dart';
import 'package:wassl/features/home/domain/entities/home_entities.dart';

class MockHomeRemoteDataSource implements HomeRemoteDataSource {
  @override
  Future<HomeDataEntity> getHomeData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return HomeDataEntity(ads: await getAds(), events: await getEvents());
  }

  @override
  Future<List<AdEntity>> getAds() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      const AdEntity(id: 1, title: 'Welcome', description: 'Welcome to Wasl', image: ''),
    ];
  }

  @override
  Future<List<EventEntity>> getEvents() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      EventEntity(id: 1, title: 'Meeting', startDate: '2026-06-01'),
    ];
  }
}
