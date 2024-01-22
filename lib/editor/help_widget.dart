import 'package:asm_edit/constants.dart';
import 'package:flutter/material.dart';

class InstructionsDescriptor extends StatelessWidget {
  const InstructionsDescriptor({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text("Help", style: TextStyle(fontSize: 20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final descriptionEntry in operatorDescriptions.entries) ...[
                Text(
                  descriptionEntry.value,
                  style: const TextStyle(
                    fontFamily: "Cascadia Code",
                    fontSize: 12,
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
