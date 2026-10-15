class ChatMessage {
  final String id;
  final String requestId;
  final String senderId;
  final String? message;
  final List<String> images;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.requestId,
    required this.senderId,
    this.message,
    this.images = const [],
    required this.createdAt,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as String,
      requestId: map['request_id'] as String,
      senderId: map['sender_id'] as String,
      message: map['message'] as String?,
      images: List<String>.from(map['images'] ?? const []),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
