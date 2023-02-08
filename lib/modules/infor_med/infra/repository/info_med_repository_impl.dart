import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/response_auth_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/response_contents_htm_info_med.dart';
import 'package:medicinadireta/modules/infor_med/domain/repositories/info_med_repository.dart';
import 'package:medicinadireta/modules/infor_med/infra/datasources/info_med_datasource.dart';
import 'package:medicinadireta/modules/infor_med/infra/models/response_contents_info_med_ext.dart';
import 'package:dartz/dartz.dart';

class InfoMedRepositoryImpl implements InfoMedRepository {
  final InfoMedDatasource datasource;

  InfoMedRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseAuthInfoMed>> loginInfoMedRepository(Map<String, dynamic> req) async {
    try {
      final result = await datasource.loginInfoMedDatasource(req);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseContentsInfoMedExt>> searchInfoMedRepository(Map<String, dynamic> req) async {
    try {
      final result = await datasource.searchInfoMedDatasource(req);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseContentsHTMLInfoMed>> searchContentsIDInfoMedRepository(String id) async {
    try {
      final result = await datasource.searchContentsIDInfoMedDatasource(id);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
