import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../domain/auth_usecase.dart';
import '../domain/user.dart';
import 'auth_mocks.dart';

void main() {
  late AuthUsecase userUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    userUsecase = AuthUsecase(mockAuthRepository);
  });

  test('should forward isAuthenticated call to repository', () async {
    when(() => mockAuthRepository.isAuthenticated()).thenAnswer((_) async => Right(null));

    final result = await userUsecase.isAuthenticated();

    expect(result, Right(null));
    verify(() => mockAuthRepository.isAuthenticated()).called(1);
  });

  test('should forward logout call to repository', () async {
    when(() => mockAuthRepository.logout()).thenAnswer((_) async => Right(null));

    final result = await userUsecase.logout();

    expect(result, Right(null));
    verify(() => mockAuthRepository.logout()).called(1);
  });

  test('should forward getUserStream call to repository', () {
    final user = User.empty;
    when(() => mockAuthRepository.getUserStream()).thenAnswer((_) => Stream.value(user));

    final result = userUsecase.getUserStream();

    expect(result, emits(user));
    verify(() => mockAuthRepository.getUserStream()).called(1);
  });

  test('should forward dispose call to repository', () {
    userUsecase.dispose();

    verify(() => mockAuthRepository.dispose()).called(1);
  });
}
