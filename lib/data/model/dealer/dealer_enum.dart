enum NotificationType {
  waitage('Waitage'),
  local('Local');

  final String label;

  const NotificationType(this.label);

  static NotificationType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'waitage':
        return NotificationType.waitage;
      case 'local':
        return NotificationType.local;
      default:
        return NotificationType.local; // fallback
    }
  }
}

enum NotificationCategory {
  tractor('Tractor'),
  vehicle('Vehicle'),
  harvester('Harvester'),
  implements('Implements');

  final String label;

  const NotificationCategory(this.label);

  static NotificationCategory fromString(String value) {
    switch (value.toLowerCase()) {
      case 'tractor':
        return NotificationCategory.tractor;
      case 'vehicle':
        return NotificationCategory.vehicle;
      case 'harvester':
        return NotificationCategory.harvester;
      case 'implements':
        return NotificationCategory.implements;
      default:
        return NotificationCategory.tractor; // fallback
    }
  }
}




enum NotificationLanguage {
  en('English'),
  hi('Hindi'),
  bn('Bengali'),
  mr('Marathi'),
  ml('Malayalam'),
  or('Odia');

  final String label;

  const NotificationLanguage(this.label);

  static NotificationLanguage fromString(String value) {
    switch (value.toLowerCase()) {
      case 'en':
        return NotificationLanguage.en;
      case 'hi':
        return NotificationLanguage.hi;
      case 'bn':
        return NotificationLanguage.bn;
      case 'mr':
        return NotificationLanguage.mr;
      case 'ml':
        return NotificationLanguage.ml;
      case 'or':
        return NotificationLanguage.or;
      default:
        return NotificationLanguage.en; // fallback
    }
  }
}
