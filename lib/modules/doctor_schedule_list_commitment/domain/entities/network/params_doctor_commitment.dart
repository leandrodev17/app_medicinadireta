import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class ParamsDoctorCommitment extends Equatable implements NetworkRequest {
  final bool count;
  final String filter;
  final String? expand;
  final int? top;
  final String orderBy;

  ParamsDoctorCommitment({
    required this.count,
    required this.filter,
    this.expand,
    this.top,
    required this.orderBy,
  });

  _map() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    _map["\$count"] = this.count;
    _map["\$filter"] = this.filter;
    if (this.expand != null) _map["\$expand"] = this.expand;
    if (this.top != null) _map["\$top"] = this.top;
    _map["\$orderby"] = this.orderBy;
    return _map;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [count, filter, expand!, orderBy];
}
