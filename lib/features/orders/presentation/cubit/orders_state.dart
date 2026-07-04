part of 'orders_cubit.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> myOrders;
  final List<OrderEntity> teamOrders;
  final int currentPage;
  final bool hasMore;
  final bool isTeamOrders;

  const OrdersLoaded({
    this.myOrders = const [],
    this.teamOrders = const [],
    this.currentPage = 1,
    this.hasMore = true,
    this.isTeamOrders = false,
  });

  @override
  List<Object?> get props => [myOrders, teamOrders, currentPage, hasMore, isTeamOrders];
}

class OrderActionSuccess extends OrdersState {
  final String message;
  const OrderActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class OrdersError extends OrdersState {
  final Failure failure;
  const OrdersError(this.failure);

  @override
  List<Object?> get props => [failure];
}
