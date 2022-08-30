import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

part 'position_state.dart';

class PositionCubit extends Cubit<PositionInitial> {
  PositionCubit() : super(PositionInitial.initial());

  void udatepostion(Offset offset) {
    print("offset2:${offset.dx}");
    return emit(
        PositionInitial(offset: offset + Offset.fromDirection(300, 100)));
  }
}
