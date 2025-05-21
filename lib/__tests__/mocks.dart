import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import '../_core/error/failures.dart';
import '../_core/network_info.dart';

class FakeFailure extends Fake implements Failure {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockDio extends Mock implements Dio {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockLazyBox<T> extends Mock implements LazyBox<T> {}

