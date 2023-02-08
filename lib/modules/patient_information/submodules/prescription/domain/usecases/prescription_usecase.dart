import 'package:medicinadireta/modules/patient_information/submodules/prescription/domain/entities/network/response_prescription.dart';

import '/core/models/request/query_parameters.dart';
import '/core/network/failures/failures.dart';

import 'package:dartz/dartz.dart';

abstract class PrescriptionUsecase {
  Future<Either<Failures, ResponsePrescription>> findPrescriptionUsecase(int pacientId, QueryParameters parameters);
}
