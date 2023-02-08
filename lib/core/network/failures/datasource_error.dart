
import 'package:medicinadireta/core/network/failures/failures.dart';

class DatasourceError implements Failures{
  final String message;
  DatasourceError({required this.message});
}