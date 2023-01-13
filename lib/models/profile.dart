import 'dart:convert';

List<Profiles> profilesFromMap(String str) =>
    List<Profiles>.from(json.decode(str).map((x) => Profiles.fromMap(x)));

Profiles profilesOfUserIdFromMap(String str) =>
    List<Profiles>.from(json.decode(str).map((x) => Profiles.fromMap(x))).first;

String profilesToMap(List<Profiles> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Profiles {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String username;
  final String firstname;
  final String lastname;
  final String phoneUser;
  final String? avatarUrl;

  Profiles({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phoneUser,
    this.avatarUrl,
  });

  factory Profiles.fromMap(Map<String, dynamic> json) => Profiles(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phoneUser: json["phone_user"],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "phone_user": phoneUser,
        "avatar_url": avatarUrl,
      };
}
