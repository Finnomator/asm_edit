import 'package:flutter/material.dart';

final textCtrler = TextEditingController();

class EditorWidget extends StatefulWidget {
  const EditorWidget({super.key});

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TextField(
            autocorrect: false,
            maxLines: null,
            controller: textCtrler,
            style: const TextStyle(fontFamily: "Cascadia Code", fontSize: 12),
            decoration: const InputDecoration(
              hintText: "Type here...",
            ),
          ),
        ),
      ],
    );
  }
}
