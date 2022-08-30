part of 'position_cubit.dart';

abstract class PositionState extends Equatable {
  const PositionState();

  @override
  List<Object> get props => [];
}

class PositionInitial extends PositionState {
  late Offset offset;
  PositionInitial({required this.offset});

  factory PositionInitial.initial() {
    return PositionInitial(offset: Offset(100, 100));
  }

  PositionInitial copyWith({
    Offset? offset,
  }) {
    return PositionInitial(
      offset: offset ?? this.offset,
    );
  }

  @override
  String toString() => 'PositionInitial(offset: $offset)';
  @override
  List<Object> get props => [offset];
}
