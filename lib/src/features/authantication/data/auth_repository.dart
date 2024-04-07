import 'package:dio/dio.dart';
import 'package:maids_tasks_manager/src/constants/end_points.dart';
import 'package:maids_tasks_manager/src/features/authantication/domain/auth_response.dart';
import 'package:maids_tasks_manager/src/network/network_service.dart';

class AuthRepository {
  late NetworkService<Response> networkService;
  AuthRepository({required this.networkService});

  Future<AuthResponse> login(String email, String password) async {
    Map<String, dynamic> fields = {
      "email": email,
      "password": password,
    };

    final Response data =
        await networkService.post(endpoint: Endpoints.login, data: fields);

    if (data.statusCode != 200) {
      throw AppException(data.statusMessage);
    }
    final AuthResponse authResponse = AuthResponse.fromMap(data.data);
    return authResponse;
  }
}
