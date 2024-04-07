import 'package:flutter_test/flutter_test.dart';
import 'package:maids_tasks_manager/src/common_models/app_response.dart';
import 'package:maids_tasks_manager/src/features/tasks/domain/task.dart';

void main() {
  group('AppResponse', () {
    test('fromMap should create AppResponse object from map', () {
      final Map<String, dynamic> jsonData = {
        "page": 1,
        "per_page": 6,
        "total": 12,
        "total_pages": 2,
        "data": {
          "id": 1,
          "email": "george.bluth@reqres.in",
          "first_name": "George",
          "last_name": "Bluth",
          "avatar": "https://reqres.in/img/faces/1-image.jpg"
        }
      };

      final appResponse =
          AppResponse.fromMap(jsonData, (data) => Task.fromMap(data));

      // Assert
      expect(appResponse.page, equals(1));
      expect(appResponse.perPage, equals(6));
      expect(appResponse.total, equals(12));
      expect(appResponse.totalPages, equals(2));
      expect(appResponse.data.id, equals(1));
      expect(appResponse.data.email, equals("george.bluth@reqres.in"));
      expect(appResponse.data.firstName, equals("George"));
      expect(appResponse.data.lastName, equals("Bluth"));
      expect(appResponse.data.avatar,
          equals("https://reqres.in/img/faces/1-image.jpg"));
    });

    test('fromMap should handle null data', () {
      final Map<String, dynamic> jsonData = {
        "page": 1,
        "per_page": 10,
        "total": 100,
        "total_pages": 10,
        "data": null
      };

      final appResponse = AppResponse.fromMap(jsonData, (data) => null);

      expect(appResponse.page, equals(1));
      expect(appResponse.perPage, equals(10));
      expect(appResponse.total, equals(100));
      expect(appResponse.totalPages, equals(10));
      expect(appResponse.data, isNull);
    });
  });
}
