import 'package:flutter/material.dart';

class SpecialRegisterViewer extends StatelessWidget {
  final int instructionPointer;
  final int accumulator;

  const SpecialRegisterViewer({
    super.key,
    required this.instructionPointer,
    required this.accumulator,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, int> jumpTable = {
      "Instruction Pointer": instructionPointer,
      "Accumulator": accumulator,
    };

    return Card(
      child: Column(
        children: [
          const Text("Special Register", style: TextStyle(fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              columnWidths: const {1: FlexColumnWidth()},
              children: [
                for (final entry in jumpTable.entries) ...[
                  TableRow(
                    children: [entry.key, entry.value.toString()]
                        .map(
                          (e) => TableCell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 5,
                              ),
                              child: Text(e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
