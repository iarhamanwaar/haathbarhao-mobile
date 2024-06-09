class Notification {
  final String userId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String actionText;
  final String category;
  final bool hasActionButton;

  Notification({
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.actionText,
    required this.category,
    required this.hasActionButton,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      actionText: json['actionText'] ?? '',
      category: json['category'] ?? '',
      hasActionButton: json['hasActionButton'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'actionText': actionText,
      'category': category,
      'hasActionButton': hasActionButton,
    };
  }
}
