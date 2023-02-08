import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/contact/domain/entities/network/response_contact.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Future<Either<Failures, ResponseContact>> findContactRepository();
}
