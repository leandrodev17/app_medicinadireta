import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/contact/domain/entities/network/response_contact.dart';
import 'package:medicinadireta/modules/contact/domain/repositories/contact_repository.dart';
import 'package:medicinadireta/modules/contact/domain/usecases/contact_usecase.dart';
import 'package:dartz/dartz.dart';

class ContactUsecaseImpl implements ContactUsecase {
  final ContactRepository repository;

  ContactUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseContact>> findByContact() async {
    try {
      return repository.findContactRepository();
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
