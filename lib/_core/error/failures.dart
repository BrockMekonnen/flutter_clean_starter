import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String getMessage();
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure([this.message = 'Oops something went wrong']);

  @override
  List<Object?> get props => [message];

  @override
  String getMessage() => message;
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String getMessage() => message;
}

class ConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String getMessage() => "No Internet Connection";
}
