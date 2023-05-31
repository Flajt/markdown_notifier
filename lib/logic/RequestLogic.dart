import 'package:http/http.dart' as http;
import 'package:markdown_notifier/models/QueryModel.dart';
import 'package:markdown_notifier/logic/CacheLogic.dart';

class RequestLogic {
  CacheLogic? cacheLogic;

  ///Call before runApp
  Future<void> init(String cachePath) async {
    cacheLogic = CacheLogic(path: cachePath);
    await cacheLogic!.init();
  }

  Future<QueryModel> getMarkdown(String url) async {
    assert(cacheLogic != null);
    Uri uri = Uri.parse(url);
    try {
      http.Response resp = await http.get(uri);
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        await cacheLogic!.save(resp.body);
        bool hasChanged = await cacheLogic!.hasChanged(resp.body);
        return QueryModel(QueryStatus.SUCCESS, resp.body, hasChanged);
      } else {
        String data = await cacheLogic!.data;
        return QueryModel(QueryStatus.ERROR, data, false);
      }
    } catch (e) {
      return QueryModel(QueryStatus.NO_CONNECTION, "Error", false);
    }
  }
}
