class Message {
  final String id;
  final String conversationId;
  final String content;
  final String senderId;
  final String createdAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.senderId,
    required this.createdAt,
  });
}