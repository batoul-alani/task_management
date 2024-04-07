import 'package:flutter_test/flutter_test.dart';
import 'package:maids_tasks_manager/src/constants/services_urls.dart';

void main() {
  group('ServicesUrls', () {
    test('baseUrl should match expected value', () {
      expect(ServicesUrls.baseUrl, equals("https://reqres.in/"));
    });
  });
}
