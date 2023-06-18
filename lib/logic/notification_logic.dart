import 'package:get_storage/get_storage.dart';

class NotificationIconLogic {
  GetStorage? _storage;

  NotificationIconLogic._internal();

  static final NotificationIconLogic instance =
      NotificationIconLogic._internal();

  Future<void> init(String path, [viewContainer = "viewdStorage"]) async {
    await GetStorage.init(viewContainer);
    _storage = GetStorage(viewContainer, path);
  }

  Future<void> shouldNotify(bool value) async =>
      await _storage!.write("needsNotification", value);
  bool get needsNotification =>
      _storage!.read<bool>("needsNotification") ?? true;
}
