import '../entities/network/pressure_response.dart';
import '/core/network/failures/failures.dart';

import 'package:dartz/dartz.dart';

abstract class PressureUsecase {
  Future<Either<Failures, PressureResponse>> findPressureUsecase(int pacientId);
}
