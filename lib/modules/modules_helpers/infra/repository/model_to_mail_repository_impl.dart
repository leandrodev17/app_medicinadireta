import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/request_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_mail.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_model_to_sms.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/entities/network/response_new_phone.dart';
import 'package:medicinadireta/modules/modules_helpers/domain/repositories/model_to_mail_repository.dart';
import 'package:medicinadireta/modules/modules_helpers/infra/datasources/model_to_mail_datasource.dart';
import 'package:dartz/dartz.dart';

class ModelToMailRepositoryImpl implements ModelToMailRepository {
  final ModelToMailDatasource datasource;

  ModelToMailRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseModelToMail>> findModelToMailRepository() async {
    try {
      final result = await datasource.findModelToMailDatasource();
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseModelToSms>> findModelToSmsRepository() async {
    try {
      final result = await datasource.findModelToSmsDatasource();
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseNewPhone>> saveNewPhone(RequestNewPhone request, int patientId) async {
    try {
      final result = await datasource.saveNewPhoneDatasource(request, patientId);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
