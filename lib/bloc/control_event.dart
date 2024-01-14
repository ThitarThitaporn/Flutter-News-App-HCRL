import 'package:equatable/equatable.dart';

abstract class ControlEvent {}

class FetchNewsEvent extends ControlEvent {
  final bool includeAuth;
  final bool requireAuthorization;

  FetchNewsEvent({
    required this.includeAuth,
    required this.requireAuthorization,
  });

  // @override
  // List<Object?> get props => [includeAuth, requireAuthorization];
  
}
