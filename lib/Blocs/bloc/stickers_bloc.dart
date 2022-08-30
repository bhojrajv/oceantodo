import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:oceantodo/Repo/stickerRepo.dart';
import 'package:oceantodo/models/customerror.dart';
import 'package:oceantodo/models/stikersmodel.dart';

part 'stickers_event.dart';
part 'stickers_state.dart';

class StickersBloc extends Bloc<StickersEvent, Stickerstate> {
  final StickerRepoImpl stickerRepoImpl;
  StickersBloc({required this.stickerRepoImpl})
      : super(Stickerstate.initial()) {
    on<StickerFectchEvent>(fetchedStickerseve);
  }

  FutureOr<void> fetchedStickerseve(
      StickerFectchEvent event, Emitter<Stickerstate> emit) async {
    emit(state.copyWith(stikerstatus: Stikerstatus.loading));
    try {
      print("kkkdkdk:::");
      Stikersmodel stikersmodel = await stickerRepoImpl.fetchStiker();
      emit(state.copyWith(
          stikerstatus: Stikerstatus.success, stikersmodel: stikersmodel));
    } on CustomError catch (e) {
      emit(state.copyWith(stikerstatus: Stikerstatus.error, customError: e));
    }
  }
}
