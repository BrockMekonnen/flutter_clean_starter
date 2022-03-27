import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../../data/data_sources/remote_data_source.dart';
import '../../../data/hive/user_model.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() async {
    // dio = await DioConfig.init();
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dataSource = AuthRemoteDataSourceImpl(dio: dio);
  });

  group('authenticate', () {
    const route = '/users/login';
    const tToken = "147852369852147852398";
    final data = {
      'phone': "789789789",
      'password': "00110011",
    };
    const tPhone = '789789789';
    const tPassword = '00110011';

    const response = {
      'data': {'token': tToken}
    };
    test(
      'should perform a POST request on a URL with phone and password being the endpoint',
      () async {
        // arrange
        dioAdapter.onPost(route, (server) {
          server.reply(200, response);
        }, data: data);

        // act
        final token = await dataSource.authenticate(tPhone, tPassword);

        // assert
        expect(token, equals(tToken));
      },
    );
  });

  group('getCurrentUser', () {
    const token = "ACCESS_TOKEN";
    final headers = <String, dynamic>{
      'Authentication': 'Bearer $token',
    };
    const route = '/users/me';
    const tUserJson = {
      "id": "id",
      "firstName": "firstName",
      "lastName": "lastName",
      "phone": "phone",
      "email": "email",
      "gender": "gender",
      "roles": ["roles"],
      "avatar": "profileUrl"
    };
    const tUserModel = UserModel(
      id: "id",
      firstName: "firstName",
      lastName: "lastName",
      phone: "phone",
      email: "email",
      gender: "gender",
      roles: ["roles"],
      avatar: "profileUrl",
    );

    const response = {'data': tUserJson};

    test(
      'should return user when the response is 200',
      () async {
        // arrange
        dioAdapter.onGet(route, (server) => server.reply(200, response));

        // act
        final result = await dataSource.getCurrentUser();

        // assert
        expect(result, tUserModel);
      },
    );
  });
}
