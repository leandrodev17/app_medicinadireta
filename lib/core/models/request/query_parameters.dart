import '/core/network/network_request.dart';
import 'package:equatable/equatable.dart';

class QueryParameters extends Equatable implements NetworkRequest {
  final bool? count;
  final String? filter;
  final String? orderby;
  final String? select;
  final int? top;
  final int? skip;
  final String? expand;

  const QueryParameters({this.count, this.filter, this.orderby, this.select, this.top, this.skip, this.expand});

  _map() {
    Map<String, dynamic> _map = <String, dynamic>{};
    if (count != null) _map["\$count"] = count;
    if (filter != null) _map["\$filter"] = filter;
    if (orderby != null) _map["\$orderby"] = orderby;
    if (select != null) _map["\$select"] = select;
    if (top != null) _map["\$top"] = top;
    if (skip != null) _map["\$skip"] = skip;
    if (expand != null) _map["\$expand"] = expand;
    return _map;
  }

  @override
  toMap() => _map();

  @override
  List<Object?> get props => [count, filter, orderby, select, top, skip, expand];
}
