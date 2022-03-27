import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../_core/error/exceptions.dart';
import '../../../../../_core/utils/constants.dart';

import '../../../data/data_sources/local_data_source.dart';
import '../../../data/hive/user_model.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

void main() {
  late MockHiveInterface mockHiveInterface;
  late MockHiveBox mockHiveBox;
  late AuthLocalDataSourceImpl dataSource;

  setUp(() async {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    dataSource = AuthLocalDataSourceImpl(hive: mockHiveInterface);
  });

  group('GetCachedCurrentUser', () {
    const tUserModel = UserModel(
        id: 'id',
        firstName: 'firstName',
        lastName: 'lastName',
        phone: 'phone',
        email: 'email',
        gender: 'gender',
        roles: [],
        avatar: 'avatar');

    test(
      'should return user from hive when there is one in cache',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.get(cachedUser)).thenAnswer((_) => tUserModel);

        // act
        final result = await dataSource.getCachedCurrentUser();

        // assert
        expect(result, equals(tUserModel));
      },
    );

    test(
      'should throw a CacheException when there is no cached data',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenThrow(CacheException());
        // when(() => mockHiveBox.get(cachedUser))
        //     .thenAnswer((invocation) => null,);

        // act
        final call = dataSource.getCachedCurrentUser;

        // assert
        expect(() => call(), throwsA(isInstanceOf<CacheException>()));
      },
    );
  });

  group('getCachedToken', () {
    const tToken = "1234567891123456789112345";

    test(
      'should return token from hive when there is one in cache',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox('token'))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.get(cachedToken))
            .thenAnswer((invocation) => tToken);

        // act
        final result = await dataSource.getCachedToken();

        // assert
        expect(result, equals(tToken));
      },
    );

    test(
      'should throw a CacheException when there is no cached data',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox('token'))
            .thenThrow(CacheException());

        // act
        final call = dataSource.getCachedToken;

        // assert
        expect(() => call(), throwsA(isInstanceOf<CacheException>()));
      },
    );
  });

  group('cacheToken', () {
    const tToken = "1234567891123456789112345";

    test(
      'should call hive to cache the token data',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.put(cachedToken, tToken))
            .thenAnswer((_) async => Void);

        // act
        await dataSource.cacheToken(tToken);

        // assert
        verify(() => mockHiveInterface.openBox("token"));
        verify(() => mockHiveBox.put(cachedToken, tToken));
      },
    );
  });

  group('cacheUser', () {
    const tUserModel = UserModel(
      id: 'id',
      firstName: 'firstName',
      lastName: 'lastName',
      phone: 'phone',
      email: 'email',
      gender: 'gender',
      roles: [],
      avatar: 'avatar',
    );

    test(
      'should call hive to cache the user data',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.put(cachedUser, tUserModel))
            .thenAnswer((_) async => Void);

        // act
        await dataSource.cacheUser(tUserModel);

        // assert
        verify(() => mockHiveInterface.openBox("user"));
        verify(() => mockHiveBox.put(cachedUser, tUserModel));
      },
    );
  });

  group('removeToken', () {
    test(
      'should remove cached token from the hive',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.delete(cachedToken))
            .thenAnswer((_) async => Void);

        // act
        await dataSource.removeToken();

        // assert
        verify(() => mockHiveInterface.openBox("token"));
        verify(() => mockHiveBox.delete(cachedToken));
      },
    );
  });

  group('removeUser', () {
    test(
      'should remove cached user from the hive',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.delete(cachedUser))
            .thenAnswer((_) async => Void);

        // act
        await dataSource.removeUser();

        // assert
        verify(() => mockHiveInterface.openBox("user"));
        verify(() => mockHiveBox.delete(cachedUser));
      },
    );
  });
}
