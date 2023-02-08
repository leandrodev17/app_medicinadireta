import 'package:equatable/equatable.dart';

class AutheticationAccess extends Equatable {
  final String? aplicativo;
  final String? platform;
  final String? privateAccess;
  final String? privateInsert;
  final String? privateDelete;
  final String? privateUpdate;
  final String? privateExport;
  final String? privatePrint;

  AutheticationAccess({
    this.aplicativo,
    this.platform,
    this.privateAccess,
    this.privateInsert,
    this.privateDelete,
    this.privateUpdate,
    this.privateExport,
    this.privatePrint,
  });

  @override
  List<Object?> get props => [
        this.aplicativo,
        this.platform,
        this.privateAccess,
        this.privateInsert,
        this.privateDelete,
        this.privateUpdate,
        this.privateExport,
        this.privatePrint,
      ];
}
