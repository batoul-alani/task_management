import 'package:flutter_test/flutter_test.dart';
import 'package:maids_tasks_manager/src/constants/end_points.dart';

void main() {
  group('Endpoints', () {
    test('login endpoint should match expected value', () {
      expect(Endpoints.login, equals("api/login"));
    });

    test('getTasks endpoint should match expected value', () {
      expect(Endpoints.getTasks, equals("/api/users"));
    });
  });
}
