import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/core/network/failures/failures_generic.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_mail.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_sms.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/repositories/model_to_mail_repository.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/usecases/model_to_mail_usecase.dart';
import 'package:dartz/dartz.dart';

class ModelToMailUsecaseImpl implements ModelToMailUsecase {
  final ModelToMailRepository repository;

  ModelToMailUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseModelToMail>> findByModelToMail() async {
    try {
      return repository.findModelToMailRepository();
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
  @override
  Future<Either<Failures, ResponseModelToSms>> findByModelToSms() async {
    try {
      return repository.findModelToSmsRepository();
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewPhone>> saveByNewPhone(RequestNewPhone request, int patientId) async{
   try {
      return repository.saveNewPhone(request, patientId);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
