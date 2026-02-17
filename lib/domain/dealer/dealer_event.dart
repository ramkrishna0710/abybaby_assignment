import '../../data/model/dealer/dealer_enum.dart';

abstract class DealerEvent {
  const DealerEvent();
}

class FetchDealerNotifications extends DealerEvent {
  final int page;
  final int pageLimit;
  final NotificationType? notificationType;
  final NotificationCategory? category;
  final NotificationLanguage? language;

  const FetchDealerNotifications({
    this.page = 0,
    this.pageLimit = 10,
    this.notificationType,
    this.category,
    this.language,
  });
}

class LoadMoreDealerNotifications extends DealerEvent {}
