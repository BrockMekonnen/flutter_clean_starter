import 'package:mocktail/mocktail.dart';

import '../domain/auth_repository.dart';
import '../domain/user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class FakeUser extends Fake implements User {}

