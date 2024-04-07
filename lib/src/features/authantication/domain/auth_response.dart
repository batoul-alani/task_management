class AuthResponse {
  final String token;
  AuthResponse({required this.token});

  factory AuthResponse.fromMap(Map<String, dynamic> json) =>
      AuthResponse(token: json["token"]);
}
