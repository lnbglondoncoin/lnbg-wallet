class NotificationModel {
  final String title;
  final String dateTime;
  final String description;
  final bool isNew;
  final String iconPath;

  NotificationModel({
    required this.title,
    required this.dateTime,
    required this.description,
    required this.isNew,
    required this.iconPath,
  });
}
