import 'package:markdown_notifier/models/QueryModel.dart';
import 'package:markdown_notifier/logic/RequestLogic.dart';

class NotificationQueryLogic {
  final Duration queryDuration;
  final String url;
  late final RequestLogic requestLogic;
  NotificationQueryLogic(
      {this.queryDuration = const Duration(minutes: 30), required this.url}) {
    requestLogic = RequestLogic();
  }
  Future<void> init(String cachePath) async {
    await requestLogic.init(cachePath);
  }

  Stream<Future<QueryModel>> queryForUpdates() {
    if (requestLogic.cacheLogic == null) {
      throw "You need to call the classes init function first!!";
    }
    return Stream.periodic(queryDuration, (_) async {
      return await requestLogic.getMarkdown(url);
    });
  }
}
