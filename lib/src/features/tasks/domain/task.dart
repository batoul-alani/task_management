class Task {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  Task({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
      id: json["id"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      avatar: json["avatar"]);

  factory Task.fromEditMap(Map<String, dynamic> json) => Task(
      id: int.parse(json["id"] ?? "0"),
      email: "",
      firstName: json["name"],
      lastName: json["job"],
      avatar: "https://reqres.in/img/faces/1-image.jpg");

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar
      };
}
