import 'package:markdown_notifier/logic/notification_logic.dart';
import 'package:markdown_notifier/models/query_model.dart';
import 'package:markdown_notifier/logic/request_logic.dart';

class NotificationQueryLogic {
  final Duration queryDuration;
  final String url;
  late final RequestLogic requestLogic;
  late final NotificationIconLogic notificationIconLogic;
  NotificationQueryLogic(
      {this.queryDuration = const Duration(minutes: 30), required this.url}) {
    requestLogic = RequestLogic();
    notificationIconLogic = NotificationIconLogic.instance;
  }

  /// Init caches for [RequestLogic] and [NotificationIconLogic] use[cachePath] to provide a path to cache data
  Future<void> init(String cachePath) async {
    await requestLogic.init(cachePath);
    await notificationIconLogic
        .init(cachePath); //TODO: Maybe use different path
  }

  /// Query for updates and yield [QueryModel] if data has changed, this is used by the [InformationButton]
  Stream<QueryModel> queryForUpdates() async* {
    if (requestLogic.cacheLogic == null) {
      throw "You need to call the classes init function first!!";
    }
    while (true) {
      QueryModel data = await requestLogic.getMarkdown(url);
      if (data.hasChanged) await notificationIconLogic.shouldNotify(true);
      yield data;
      await Future.delayed(queryDuration);
    }
  }
}
