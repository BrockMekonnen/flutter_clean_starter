import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../__tests__/mocks.dart';
import '../../../_core/error/failures.dart';
import '../data/auth_repository_impl.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockDio mockDio;
  late MockHiveInterface mockHive;
  late MockNetworkInfo mockNetworkInfo;
  late MockLazyBox<dynamic> mockUserBox;
  late MockLazyBox<dynamic> mockTokenBox;

  setUp(() {
    mockDio = MockDio();
    mockHive = MockHiveInterface();
    mockNetworkInfo = MockNetworkInfo();
    mockUserBox = MockLazyBox();
    mockTokenBox = MockLazyBox();

    repository = AuthRepositoryImpl(
      dio: mockDio,
      hive: mockHive,
      networkInfo: mockNetworkInfo,
    );

    // Default box open returns
    when(() => mockHive.openLazyBox(any())).thenAnswer((invocation) {
      final boxName = invocation.positionalArguments[0] as String;
      if (boxName == 'CACHED_USER_BOX') return Future.value(mockUserBox);
      if (boxName == 'CACHED_TOKEN_BOX') return Future.value(mockTokenBox);
      return Future.value(MockLazyBox());
    });
  });

  group('login', () {
    final tEmail = 'test@example.com';
    final tPassword = 'password';
    final tToken = 'abc123token';
    final tUserJson = {
      'data': {
        'id': 'userId1',
        'email': tEmail,
        'firstName': 'Test1',
        'lastName': "Test2",
        'phone': '11234567890',
        'roles': [],
        // add your fields here
      }
    };

    test('should login and cache token and user, then emit user', () async {
      // Mock dio.post for login (token fetch)
      when(() => mockDio.post('/users/login', data: {
            'email': tEmail,
            'password': tPassword,
          })).thenAnswer((_) async => Response(data: {
            'data': {'token': tToken}
          }, statusCode: 200, requestOptions: RequestOptions(path: '/users/login')));

      // Mock dio.get for fetching user data
      when(() => mockDio.get('/users/me')).thenAnswer((_) async => Response(
          data: tUserJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/users/me')));

      // Mock caching token and user
      when(() => mockTokenBox.put(any(), any())).thenAnswer((_) async {});
      when(() => mockUserBox.put(any(), any())).thenAnswer((_) async {});

      // Call login
      final result = await repository.login(email: tEmail, password: tPassword);

      expect(result.isRight(), true);

      // Verify methods called
      verify(() => mockDio.post('/users/login',
          data: {'email': tEmail, 'password': tPassword})).called(1);

      verify(() => mockDio.get('/users/me')).called(1);
      verify(() => mockTokenBox.put('CACHED_TOKEN', tToken)).called(1);
      verify(() => mockUserBox.put('CACHED_USER', any())).called(1);
    });

    test('should return ServerFailure when token is missing', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: {'data': {}}, // no token
                statusCode: 200,
                requestOptions: RequestOptions(path: '/users/login'),
              ));

      final result = await repository.login(email: tEmail, password: tPassword);

      expect(result.isLeft(), true);
      result.fold((failure) => expect(failure, isA<ServerFailure>()), (_) => null);
    });

    test('should return ServerFailure on DioException', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/users/login')));

      final result = await repository.login(email: tEmail, password: tPassword);

      expect(result.isLeft(), true);
      result.fold((failure) => expect(failure, isA<ServerFailure>()), (_) => null);
    });
  });

  group('logout', () {
    test('should clear caches and emit empty user', () async {
      when(() => mockUserBox.clear()).thenAnswer((_) async => 1);
      when(() => mockTokenBox.clear()).thenAnswer((_) async => 1);

      final result = await repository.logout();

      expect(result.isRight(), true);

      // You can verify clearing calls or _userController calls here if you expose it
      verify(() => mockUserBox.clear()).called(1);
      verify(() => mockTokenBox.clear()).called(1);
    });
  });

  group('getUser', () {
    final tUserJson = {
      'data': {
        'id': 'userId1',
        'email': 'test@example.com',
        'firstName': 'Test1',
        'lastName': "Test2",
        'phone': '11234567890',
        'roles': [],
        // add your fields here
      }
    };

    test('should fetch user and emit user', () async {
      when(() => mockDio.get('/users/me')).thenAnswer((_) async => Response(
          data: tUserJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/users/me')));

      final result = await repository.getMe();

      expect(result.isRight(), true);

      result.fold((_) => null, (user) => expect(user?.email, 'test@example.com'));

      verify(() => mockDio.get('/users/me')).called(1);
    });

    test('should return ServerFailure on DioException', () async {
      when(() => mockDio.get(any()))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/users/me')));

      final result = await repository.getMe();

      expect(result.isLeft(), true);
      result.fold((failure) => expect(failure, isA<ServerFailure>()), (_) => null);
    });
  });
}
