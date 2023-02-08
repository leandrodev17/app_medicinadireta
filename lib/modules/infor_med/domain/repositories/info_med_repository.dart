import 'package:medicinadireta/modules/infor_med/domain/entities/response_auth_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_htm_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_info_med.dart';

import '/core/network/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class InfoMedRepository {
  Future<Either<Failures, ResponseAuthInfoMed>> loginInfoMedRepository(Map<String, dynamic> req);
  Future<Either<Failures, ResponseContentsInfoMed>> searchInfoMedRepository(Map<String, dynamic> req);
  Future<Either<Failures, ResponseContentsHTMLInfoMed>> searchContentsIDInfoMedRepository(String id);
}
