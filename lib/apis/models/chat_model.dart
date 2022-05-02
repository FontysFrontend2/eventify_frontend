class MessageData {
  final String user;
  final String room;
  final String message;
  final bool join;
  final bool leave;

  const MessageData({
    required this.user,
    required this.room,
    required this.message,
    required this.join,
    required this.leave,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
        user: json['user'],
        room: json['room'],
        message: json['message'],
        join: json['join'],
        leave: json['leave']);
  }
}
