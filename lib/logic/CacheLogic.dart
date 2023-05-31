import 'package:get_storage/get_storage.dart';

class CacheLogic {
  late final GetStorage _cache;
  final String nameSpace;
  CacheLogic({required String path, this.nameSpace = "markdown_notifier"})
      : _cache = GetStorage(nameSpace, path);

  Future<void> init() async {
    await GetStorage.init(nameSpace);
  }

  Future<void> save(String data) async {
    await _cache.write("data", data);
  }

  Future<String> get data async => await _cache.read("data") ?? "";

  Future<void> delete() async {
    await _cache.erase();
  }

  Future<bool> hasChanged(String newData) async {
    String? cachedData = _cache.read<String>("data") ?? "";
    if (newData.length != cachedData.length) {
      return true;
    }
    return false;
  }
}
