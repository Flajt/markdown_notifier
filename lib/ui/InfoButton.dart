import 'package:flutter/material.dart';
import 'package:markdown_notifier/logic/NotificationQueryLogic.dart';
import 'package:markdown_notifier/ui/NotificationDisplayDialog.dart';

class InfoButton extends StatelessWidget {
  final Icon notificationButtonIcon;
  final NotificationQueryLogic notificationQueryLogic;
  const InfoButton(
      {Key? key,
      this.notificationButtonIcon = const Icon(Icons.notifications),
      required this.notificationQueryLogic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: notificationQueryLogic.queryForUpdates(),
      builder: (context, snapshot) {
        return IconButton(
            onPressed: () => snapshot.hasData
                ? showDialog(
                    context: context,
                    builder: (context) =>
                        NotificationDialog(data: snapshot.data!.markdownData))
                : null,
            icon: snapshot.data?.hasChanged ?? false
                ? const Icon(Icons.notifications_active)
                : const Icon(Icons.notifications));
      },
    );
  }
}
