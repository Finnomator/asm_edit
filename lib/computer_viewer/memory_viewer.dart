import 'package:flutter/material.dart';

class MemoryViewerWidget extends StatelessWidget {
  final List<int> memoryValues;
  static const int columns = 4;
  static const int maxMemCells = 32;
  static const int rows = maxMemCells ~/ columns;

  const MemoryViewerWidget({super.key, required this.memoryValues});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text("Register", style: TextStyle(fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              columnWidths: const {
                1: FlexColumnWidth(),
                3: FlexColumnWidth(),
                5: FlexColumnWidth(),
                7: FlexColumnWidth(),
              },
              border: TableBorder.all(
                width: 1,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              children: [
                for (int y = 0; y < rows; ++y) ...[
                  TableRow(
                    children: [
                      for (int x = 0; x < columns * 2; ++x) ...[
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            child: makeMemoryCell(x, y),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget makeMemoryCell(final int x, final int y) {
    final int i = y + x ~/ 2 * rows;
    if (x % 2 == 0) {
      return Text("$i", style: const TextStyle(color: Colors.white70));
    }
    return Text("${memoryValues[i]}");
  }
}
