import 'package:get_it/get_it.dart';
import 'package:oceantodo/Repo/stickerRepo.dart';

GetIt getIt = GetIt.instance;

void superGet() {
  getIt.registerFactory<StickerRepo>(() => StickerRepoImpl());
}
