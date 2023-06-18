import 'package:flutter/material.dart';
import 'package:markdown_notifier/logic/NotificationQueryLogic.dart';
import 'package:markdown_notifier/ui/NotificationDisplayDialog.dart';

import '../logic/NotificationIconLogic.dart';

class InfoButton extends StatefulWidget {
  /// Button to display if no new notifications are available
  final Icon notificationButtonIcon;

  /// Button to display if new notifications are available
  final Icon hasNotificaionIconButton;
  final NotificationQueryLogic notificationQueryLogic;
  const InfoButton(
      {Key? key,
      this.notificationButtonIcon = const Icon(Icons.notifications),
      this.hasNotificaionIconButton = const Icon(Icons.notifications_active),
      required this.notificationQueryLogic})
      : super(key: key);

  @override
  State<InfoButton> createState() => _InfoButtonState();
}

class _InfoButtonState extends State<InfoButton> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.notificationQueryLogic.queryForUpdates(),
      builder: (context, snapshot) {
        return IconButton(
            onPressed: () async {
              if (snapshot.hasData) {
                await NotificationIconLogic.instance.shouldNotify(false);
                setState(() {});

                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (context) =>
                        NotificationDialog(data: snapshot.data!.markdownData));
              }
            },
            icon: NotificationIconLogic.instance.needsNotification
                ? widget.hasNotificaionIconButton
                : widget.notificationButtonIcon);
      },
    );
  }
}
