import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class ParamsEvolution extends Equatable implements NetworkRequest {
  final bool? count;
  final String? filter;
  final String? expand;
  final int? top;
  final String? orderBy;

  ParamsEvolution({
    this.count,
    this.filter,
    this.expand,
    this.top,
     this.orderBy,
  });

  _map() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    if (this.orderBy != null) _map["\$orderby"] = this.orderBy;
    if (this.count != null) _map["\$count"] = this.count;
    if (this.filter != null) _map["\$filter"] = this.filter;
    if (this.expand != null) _map["\$expand"] = this.expand;
    if (this.top != null) _map["\$top"] = this.top;
    return _map;
  }

  @override
  toMap() => _map();

  @override
  List<Object> get props => [count!, filter!, expand!, orderBy!, top!];
}
