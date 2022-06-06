import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:any_link_preview/any_link_preview.dart';

class LinkBubble extends StatelessWidget {
  const LinkBubble({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: AnyLinkPreview(
        link: link,
        displayDirection: UIDirection.uiDirectionHorizontal,
        showMultimedia: true,
        bodyMaxLines: 5,
        bodyTextOverflow: TextOverflow.ellipsis,
        titleStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
