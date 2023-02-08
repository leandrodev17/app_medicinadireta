import 'package:medicinadireta/core/network/failures/datasource_error.dart';
import 'package:medicinadireta/core/network/failures/failures.dart';
import 'package:medicinadireta/modules/contact/domain/entities/network/response_contact.dart';
import 'package:medicinadireta/modules/contact/domain/repositories/contact_repository.dart';
import 'package:medicinadireta/modules/contact/infra/datasources/contatc_datasource.dart';
import 'package:dartz/dartz.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDatasource datasource;

  ContactRepositoryImpl(this.datasource);

  @override
  Future<Either<Failures, ResponseContact>> findContactRepository() async {
    try {
      final result = await datasource.findContactDatasource();
      return right(result);
    } on DatasourceError catch (e) {
      return left(e);
    } catch (e) {
      return left(DatasourceError(message: 'Não foi possível solicitar os dados para o servidor'));
    }
  }
}
