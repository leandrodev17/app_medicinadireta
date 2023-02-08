import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class ParamsDoctorSchedule extends Equatable implements NetworkRequest {
  final bool count;
  final String filter;
  final String orderby;
  final int top;
  final int skip;

  ParamsDoctorSchedule({
    required this.count,
    required this.filter,
    required this.orderby,
    required this.top,
    required this.skip,
  });

  _map() {
    Map<String, dynamic> _p = {
      "\$count": this.count,
      "\$filter": this.filter,
      "\$orderby": this.orderby,
      "\$top": this.top,
      "\$skip": this.skip,
    };
    return _p;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [count, filter, orderby, top, skip];
}
