import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String error_msg;
  CustomError({
    required this.error_msg,
  });

  @override
  String toString() => 'CustomError(error_msg: $error_msg)';

  @override
  // TODO: implement props
  List<Object?> get props => [error_msg];
}
