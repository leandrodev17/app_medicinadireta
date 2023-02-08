import 'package:medicinadireta/modules/infor_med/domain/entities/response_auth_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_htm_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_info_med.dart';

import '/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class InfoMedUsecase {
  Future<Either<Failures, ResponseAuthInfoMed>> loginInfoMed(Map<String, dynamic> req);
  Future<Either<Failures, ResponseContentsInfoMed>> searchInfoMed(Map<String, dynamic> req);
  Future<Either<Failures, ResponseContentsHTMLInfoMed>> searchContentsIdInfoMed(String id);
}
