import 'package:medicinadireta/modules/contact/domain/entities/contact.dart';

class ContactExt extends Contact {
  final int? contactId;
  final String? name;
  ContactExt({this.contactId, this.name});

  ContactExt copyWith({int? contactId, String? name}) => ContactExt(contactId: contactId ?? this.contactId, name: name ?? this.name);

  factory ContactExt.fromMap(Map<String, dynamic> json) => ContactExt(contactId: json["contatoId"], name: json["nome"]);

  Map<String, dynamic> toMap() => {"contatoId": contactId, "nome": name};
}
