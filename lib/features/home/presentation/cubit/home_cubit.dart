import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/features/home/domain/entities/home_entities.dart';
import 'package:wassl/features/home/domain/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit({required HomeRepository repository})
      : _repository = repository,
        super(const HomeInitial());

  Future<void> loadHomeData() async {
    emit(const HomeLoading());
    final result = await _repository.getHomeData();
    if (result.failure != null) {
      emit(HomeError(result.failure!));
    } else {
      emit(HomeLoaded(result.data!));
    }
  }

  void resetState() => emit(const HomeInitial());
}
