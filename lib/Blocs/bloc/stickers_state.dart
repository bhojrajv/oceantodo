part of 'stickers_bloc.dart';

// @immutable
// abstract class StickersState {}

enum Stikerstatus { initial, loading, success, error }

class Stickerstate extends Equatable {
  late Stikerstatus stikerstatus;
  late Stikersmodel stikersmodel;
  late CustomError customError;
  Stickerstate(
      {required this.stikerstatus,
      required this.stikersmodel,
      required this.customError});

  factory Stickerstate.initial() {
    return Stickerstate(
        stikerstatus: Stikerstatus.initial,
        stikersmodel: Stikersmodel.initial(),
        customError: CustomError(error_msg: ""));
  }
  @override
  // TODO: implement props
  List<Object?> get props => [stikerstatus, stikersmodel, customError];

  Stickerstate copyWith(
      {Stikerstatus? stikerstatus,
      Stikersmodel? stikersmodel,
      CustomError? customError}) {
    return Stickerstate(
        stikerstatus: stikerstatus ?? this.stikerstatus,
        stikersmodel: stikersmodel ?? this.stikersmodel,
        customError: customError ?? this.customError);
  }

  @override
  String toString() =>
      'Stickerstate(stikerstatus: $stikerstatus, stikersmodel: $stikersmodel, customError: $customError)';
}
