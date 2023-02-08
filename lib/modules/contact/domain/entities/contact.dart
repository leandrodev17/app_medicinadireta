import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int? contactId;
  final String? name;
  Contact({this.contactId, this.name});

  @override
  List<Object?> get props => [contactId, name];
}
