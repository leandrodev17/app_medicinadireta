import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/domain/entities/network/response_medicines.dart';
import 'package:medicinadireta/modules/patient_information/submodules/medicines_in_use/infra/models/medicines_in_use_ext.dart';

class ResponseMedicinesInUseExt extends ResponseMedicinesInUse {
  final List<MedicinesInUseExt> model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;
  final String? odata;

  ResponseMedicinesInUseExt({this.statusCode, this.statusMessage, this.errorMessage, this.odata, required this.model});

  factory ResponseMedicinesInUseExt.fromMap({List<dynamic>? data, int? statusCode, String? statusMessage, String? errorMessage, String? odata}) {
    return ResponseMedicinesInUseExt(
      model: data!.map<MedicinesInUseExt>((data) => MedicinesInUseExt.fromMap(data)).toList(),
      statusCode: statusCode,
      statusMessage: statusMessage,
      errorMessage: errorMessage,
      odata: odata,
    );
  }
}