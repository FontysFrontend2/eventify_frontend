class UserData {
  final int id;
  final String name;
  final String email;
  final String registrationDate;
  final List events;
  final List interests;

  const UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.registrationDate,
      required this.events,
      required this.interests});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        registrationDate: json['registrationDate'],
        events: json['events'],
        interests: json['interests']);
  }
}

class MyUserData {
  final int id;
  final String name;
  final String email;
  final String registrationDate;
  final List events;
  final List interests;

  const MyUserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.registrationDate,
      required this.events,
      required this.interests});

  factory MyUserData.fromJson(Map<String, dynamic> json) {
    return MyUserData(
        /*id: json['id'],
        name: json['username'],
        email: json['email'],
        registrationDate: json['registrationDate'],
        events: json['eventIDs'],
        interests: json['interestIDs']*/
        id: 0,
        name: "TestiKayttaja",
        email: "testi@pesti.com",
        registrationDate: "2022-05-14T14:06:04.395Z",
        events: [0],
        interests: [1, 4, 5, 7]);
  }
}
