part of 'stickers_bloc.dart';

@immutable
abstract class StickersEvent extends Equatable {
  StickersEvent();
  @override
  List<Object> pros = [];
}

class StickerFectchEvent extends StickersEvent {
  StickerFectchEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
