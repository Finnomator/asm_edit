import 'package:flutter/material.dart';

import 'compiler.dart';

class CompileErrorsWidget extends StatelessWidget {
  final List<CompileException> exceptions;

  const CompileErrorsWidget({super.key, required this.exceptions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Compile Errors:"),
        for (final CompileException ex in exceptions) ...[
          SizedBox(
            width: 500,
            child: ListTile(
              title: Text("(${ex.line}; ${ex.start}) ${ex.reason}"),
              leading: const Icon(Icons.error, color: Colors.red),
            ),
          ),
          const Divider(),
        ],
      ],
    );
  }
}
