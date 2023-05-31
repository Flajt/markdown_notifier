import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class NotificationDialog extends StatelessWidget {
  final double width;
  final double height;
  final String data;
  const NotificationDialog(
      {Key? key, required this.data, this.width = 250, this.height = 500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        width: width,
        height: height,
        child: ListView.builder(itemBuilder: (context, index) {
          List<String> notifications = data.split("<br>");
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) => Dialog.fullscreen(
                      child: MarkdownWidget(data: notifications[index])));
            },
            child: SizedBox(
              child:
                  MarkdownWidget(data: notifications[index].substring(0, 50)),
            ),
          );
        }),
      ),
    );
  }
}
