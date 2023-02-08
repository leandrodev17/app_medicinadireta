import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_mail.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_sms.dart';
import 'package:dartz/dartz.dart';

abstract class ModelToMailRepository {
  Future<Either<Failures, ResponseModelToMail>> findModelToMailRepository();
  Future<Either<Failures, ResponseModelToSms>> findModelToSmsRepository();
  Future<Either<Failures, ResponseNewPhone>> saveNewPhone(RequestNewPhone request, int patientId);
}
