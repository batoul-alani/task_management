import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_tasks_manager/src/features/authantication/data/auth_repository.dart';
import 'package:maids_tasks_manager/src/features/authantication/domain/auth_response.dart';
import 'package:maids_tasks_manager/src/network/network_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkService extends Mock implements NetworkService<Response> {
  @override
  Future<Response> post(
      {required String endpoint,
      dynamic data,
      Map<String, dynamic>? headers}) async {
    return Response(
        data: _kSuccessResponse,
        statusCode: 200,
        requestOptions: RequestOptions());
  }
}

class MockAuthRepository extends Mock implements AuthRepository {}


void main() {
  late AuthRepository authRepository;
  setUp(() {
    final mockNetworkService = MockNetworkService();

    authRepository = AuthRepository(networkService: mockNetworkService);
  });

  test("Successfully logged in user", () async {
    final result = await authRepository.login("eve.holt@reqres.in", "cityslicka");

    expect(result, isA<AuthResponse>());
  });

}

const _kSuccessResponse = {
    "token": "QpwL5tke4Pnpja7X4"
};
