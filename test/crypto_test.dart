import 'package:crypto_search/model/crypto/bpi.dart';
import 'package:crypto_search/model/crypto/crypto_data.dart';
import 'package:crypto_search/model/crypto/time.dart';
import 'package:crypto_search/service/crypto_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'crypto_test.mocks.dart';

@GenerateMocks([
  CryptoService,
  CryptoData,
  Bpi
], customMocks: [
  MockSpec<CryptoData>(
      as: #MockCryptoDataRelaxed, onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late MockCryptoService service;

  final success = CryptoData(
      time: Time(
          updated: "updated",
          updatedIso: DateTime.now(),
          updateduk: "updateduk"),
      disclaimer: "disclaimer",
      chartName: "BTC",
      bpi: MockBpi());

  setUp(() {
    service = MockCryptoService();
  });

  group('call crypto api data', () {
    test('call crypto success case test', () async {
      when(service.fetchCrypto()).thenAnswer((_) async => success);
      await service.fetchCrypto();

      verify(service.fetchCrypto());

      service.fetchCrypto().then((data) {
        expect(data, success);
        expect(data?.time, success.time);
        expect(data?.chartName, success.chartName);
      });

      expect(service.fetchCrypto(), completes);
    });
    test('call crypto error case test', () async {
      when(service.fetchCrypto()).thenAnswer((_) async => MockCryptoData());
      await service.fetchCrypto();

      verify(service.fetchCrypto());

      service.fetchCrypto().then((data) {
        expect(data, const TypeMatcher<MockCryptoData>());
      });

      expect(service.fetchCrypto(), completes);
    });
  });

  group('call crypto api with stream', () {
    test('call crypto success case test', ()  {
      when(service.fetchCryptoStream()).thenAnswer((_)  => Stream.value(success));
      verifyNever(service.fetchCryptoStream());

      service.fetchCryptoStream().listen((data) {
        expect(data, success);
        expect(data?.time, success.time);
        expect(data?.chartName, success.chartName);
      });

      
      expect(service.fetchCryptoStream(), emitsInOrder([success]));
    });
    test('call crypto error case test', () {
      when(service.fetchCryptoStream()).thenAnswer((_) => Stream.value(MockCryptoData()));
      service.fetchCryptoStream().listen((data) {
        expect(data, const TypeMatcher<MockCryptoData>());
      },onError: (err){
        expect(err, TypeError());
      });
    });
  });

  group('call crypto history with sqlite', () {
    test('call crypto history success case test', () async {
      when(service.historyCrypto()).thenAnswer((_) async => [MockBpi()]);
      await service.historyCrypto();

      verify(service.historyCrypto());
      expect(service.historyCrypto(), completes);

      service.historyCrypto().then((data) {
        expect(data?.length, 1);
        expect(data, const TypeMatcher<List<Bpi>>());
      });
    });
    test('call crypto history error case test', () async {
      when(service.historyCrypto()).thenAnswer((_) async => []);
      await service.historyCrypto();

      verify(service.historyCrypto());
      expect(service.historyCrypto(), completes);

      service.historyCrypto().then((data) {
        expect(data?.length, 0);
        expect(data, const TypeMatcher<List<Bpi>>());
      });
    });
  });
}

void setUp(Function() p) {
  p();
}
