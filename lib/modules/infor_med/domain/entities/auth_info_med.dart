import 'package:equatable/equatable.dart';

class AuthInfoMed extends Equatable {
  final int? userid;
  final String? token;
  final String? origin;

  AuthInfoMed({this.userid, this.token, this.origin});

  @override
  List<Object?> get props => [this.userid, this.token, this.origin];
}
