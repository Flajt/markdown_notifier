import 'package:markdown_notifier/logic/NotificationIconLogic.dart';
import 'package:markdown_notifier/models/QueryModel.dart';
import 'package:markdown_notifier/logic/RequestLogic.dart';

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
  Future<void> init(String cachePath) async {
    await requestLogic.init(cachePath);
    await notificationIconLogic
        .init(cachePath); //TODO: Maybe use different path
  }

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
