class UserData {
  final int id;
  final String name;
  final String description;

  const UserData({
    required this.id,
    required this.name,
    required this.description,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'], name: json['name'], description: json['description']);
  }
}
