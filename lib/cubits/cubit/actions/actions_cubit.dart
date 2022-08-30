import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'actions_state.dart';

class ActionsCubit extends Cubit<ActionsInitial> {
  ActionsCubit() : super(ActionsInitial.initial());

  void doActions2(String type, int incr2) {
    print("roatation:${incr2}");
    return emit(ActionsInitial(type: type, incr: (state.incr! + incr2)));
  }

  void flips(String type, int inc) {
    if (state.incr <= inc) {
      return emit(ActionsInitial(type: type, incr: state.incr + inc));
    } else if (state.incr >= inc) {
      return emit(ActionsInitial(type: type, incr: state.incr - inc));
    }
  }

  void scalled(String type, int inc) {
    print("scalee:${state.incr + inc}");
    return emit(ActionsInitial(type: type, incr: state.incr + inc));
  }

  void delete(String type, int inc) {
    return emit(ActionsInitial(type: type, incr: 0));
  }
}
