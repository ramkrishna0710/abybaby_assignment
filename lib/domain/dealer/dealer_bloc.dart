import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/dealer/dealer_repository.dart';
import 'dealer_event.dart';
import 'dealer_state.dart';

class DealerBloc extends Bloc<DealerEvent, DealerState> {
  final DealerRepository dealerRepository;

  DealerBloc({required this.dealerRepository})
      : super(const DealerState()) {
    on<FetchDealerNotifications>(_onFetchNotifications);
    on<LoadMoreDealerNotifications>(_onLoadMoreNotifications);
  }

  Future<void> _onFetchNotifications(
      FetchDealerNotifications event,
      Emitter<DealerState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final data = await dealerRepository.getDealerNotification(
        page: event.page,
        pageLimit: event.pageLimit,
        notificationType: event.notificationType,
        category: event.category,
        language: event.language,
      );

      emit(state.copyWith(
        isLoading: false,
        notifications: data,
        page: event.page,
        hasReachedMax: data.length < event.pageLimit,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreNotifications(
      LoadMoreDealerNotifications event,
      Emitter<DealerState> emit,
      ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.page + 1;

      final data = await dealerRepository.getDealerNotification(
        page: nextPage,
        pageLimit: 10,
      );
      print("Dala length${data.length}");

      emit(state.copyWith(
        isLoadingMore: false,
        page: nextPage,
        notifications: [...state.notifications, ...data],
        hasReachedMax: data.isEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }
}
