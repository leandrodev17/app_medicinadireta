import 'package:medicinadireta/modules/infor_med/domain/entities/response_auth_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_htm_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/repositories/info_med_repository.dart';

import '/core/network/failures/failures.dart';
import '/core/network/failures/failures_generic.dart';
import 'package:dartz/dartz.dart';

import 'info_med_usecase.dart';

class AuthInfoMedUsecaseImpl implements InfoMedUsecase {
  final InfoMedRepository repository;

  AuthInfoMedUsecaseImpl(this.repository);

  @override
  Future<Either<Failures, ResponseAuthInfoMed>> loginInfoMed(Map<String, dynamic> req) async {
    try {
      if (req.isEmpty) {
        return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      }
      return repository.loginInfoMedRepository(req);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseContentsInfoMed>> searchInfoMed(Map<String, dynamic> req) async {
    try {
      if (req.isEmpty) {
        return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      }
      return repository.searchInfoMedRepository(req);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }

  @override
  Future<Either<Failures, ResponseContentsHTMLInfoMed>> searchContentsIdInfoMed(String id) async {
    try {
      if (id == '') return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
      return repository.searchContentsIDInfoMedRepository(id);
    } catch (e) {
      return left(FailureGeneric(message: 'Paramêtros obrigatórios'));
    }
  }
}
