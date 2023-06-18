import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class NotificationDialog extends StatelessWidget {
  final double width;
  final double height;
  final String data;
  final int maxTitleChars;
  const NotificationDialog(
      {Key? key,
      required this.data,
      this.width = 350,
      this.height = 500,
      this.maxTitleChars = 49})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> notifications = data.split("<br>");

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(),
        width: width,
        height: height,
        child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: width,
                height: height * .3,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) => Dialog.fullscreen(
                            child: MarkdownWidget(
                                physics: const BouncingScrollPhysics(),
                                selectable: false,
                                padding: const EdgeInsets.all(8.0),
                                data: notifications[index])));
                  },
                  child: MarkdownWidget(
                      selectable: false,
                      data: notifications[index]
                          .substring(0, _getLength(notifications[index]))),
                ),
              );
            }),
      ),
    );
  }

  _getLength(String data) =>
      data.length > maxTitleChars ? maxTitleChars : data.length;
}
