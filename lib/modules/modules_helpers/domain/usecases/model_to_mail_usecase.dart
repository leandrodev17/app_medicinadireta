import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_mail.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_sms.dart';

import 'package:dartz/dartz.dart';

abstract class ModelToMailUsecase {
  Future<Either<Failures, ResponseModelToMail>> findByModelToMail();
  Future<Either<Failures, ResponseModelToSms>> findByModelToSms();
  Future<Either<Failures, ResponseNewPhone>> saveByNewPhone(RequestNewPhone request, int patientId);
}
