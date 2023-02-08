import 'package:medicinadireta/core/models/request/query_parameters.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:medicinadireta/modules/patient_information/submodules/prescription/domain/entities/network/response_prescription.dart';

abstract class PrescriptionRepository {
  Future<Either<Failures, ResponsePrescription>> findAllPrescriptionRepository(int pacientId, QueryParameters parameters);
}

