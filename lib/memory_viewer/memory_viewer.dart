import 'package:flutter/material.dart';

class MemoryViewerWidget extends StatelessWidget {
  final List<int> memoryValues;
  static const int columns = 4;
  static const int maxMemCells = 32;
  static const int rows = maxMemCells ~/ columns;

  const MemoryViewerWidget({super.key, required this.memoryValues});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        children: [
          for (int x = 0; x < columns; ++x) ...[
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  for (int y = 0; y < rows; ++y) ...[
                    makeMemoryCell(x, y),
                    const Divider(),
                  ],
                ],
              ),
            ),
            const VerticalDivider(width: 1)
          ],
        ],
      ),
    );
  }

  Widget makeMemoryCell(final int x, final int y) {
    final int i = y + x * rows;
    return Row(
      children: [
        Text("$i: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        if (i < memoryValues.length) Text("${memoryValues[i]}"),
      ],
    );
  }
}
