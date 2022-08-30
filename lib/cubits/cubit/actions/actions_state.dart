part of 'actions_cubit.dart';

abstract class ActionsState extends Equatable {
  const ActionsState();

  @override
  List<Object> get props => [];
}

class ActionsInitial extends ActionsState {
  late String type;
  late int incr;
  ActionsInitial({
    required this.type,
    required this.incr,
  });

  factory ActionsInitial.initial() {
    return ActionsInitial(type: "", incr: 0);
  }
  ActionsInitial copyWith({
    String? type,
    int? incr,
  }) {
    return ActionsInitial(
      type: type ?? this.type,
      incr: incr ?? this.incr,
    );
  }

  @override
  List<Object> get props => [type, incr!];
  @override
  String toString() => 'ActionsInitial(type: $type, incr: $incr)';
}
