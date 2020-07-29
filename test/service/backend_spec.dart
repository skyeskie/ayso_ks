import 'package:ayso_ks/service/backend_interface.dart';
import 'package:flutter_test/flutter_test.dart';

typedef BackendInterfaceGenerator = BackendInterface Function();

void backendInterfaceSpec(BackendInterfaceGenerator initBackend) {
  BackendInterface service;

  group('(BackendInterface)', () {
    setUp(() {
      service = initBackend();
    });

    test('returns games', () async {
      expect(await service.getGames(), isNotEmpty);
    });

    test('returns teams', () async {
      expect(await service.getTeams(), isNotEmpty);
    });

    test('returns week starts', () async {
      expect(await service.getWeekStarts(), isNotEmpty);
    });

    test('returns data version', () async {
      expect(await service.getDataVersion(), isA<String>());
    });
  });
}
