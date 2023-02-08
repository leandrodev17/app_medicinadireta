import '../entities/network/anthropometry_response.dart';
import '/core/network/failures/failures.dart';

import 'package:dartz/dartz.dart';

abstract class AnthropometryUsecase {
  Future<Either<Failures, AnthropometryResponse>> findAnthropometryUsecase(int pacientId);
}
