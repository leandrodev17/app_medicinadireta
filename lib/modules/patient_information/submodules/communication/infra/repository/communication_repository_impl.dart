import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/request_communication.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/entities/network/response_communication_sms.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/domain/repositories/communication_repository.dart';
import 'package:medicinadireta/modules/patient_information/submodules/communication/infra/datasources/communication_datasource.dart';
import 'package:dartz/dartz.dart';

class CommunicationRepositoryImpl implements CommunicationRepository {
  final CommunicationDatasource datasource;

  CommunicationRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseCommunication>> saveCommunicationRepository(RequestCommunication params) async {
    try {
      final result = await datasource.saveCommunicationDatasource(params);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }

  @override
  Future<Either<Failures, ResponseCommunicationSms>> sendSMSCommunicationRepository(RequestCommunication params) async {
    try {
      final result = await datasource.sendSMSCommunicationDatasource(params);
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
