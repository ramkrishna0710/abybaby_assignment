import '../../data/model/dealer/notification_model.dart';

class DealerState {
  final bool isLoading;
  final bool isLoadingMore;
  final List<NotificationModel> notifications;
  final String? error;
  final int page;
  final bool hasReachedMax;

  const DealerState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.notifications = const [],
    this.error,
    this.page = 0,
    this.hasReachedMax = false,
  });

  DealerState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<NotificationModel>? notifications,
    String? error,
    int? page,
    bool? hasReachedMax,
  }) {
    return DealerState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      notifications: notifications ?? this.notifications,
      error: error,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
