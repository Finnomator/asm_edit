import 'package:flutter/material.dart';

import 'compiler.dart';

class CompileErrorsWidget extends StatelessWidget {
  final List<CompileException> exceptions;

  const CompileErrorsWidget({super.key, required this.exceptions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Compile Errors", style: TextStyle(fontSize: 20)),
        for (final CompileException ex in exceptions) ...[
          ListTile(
            title: Text("(${ex.line}; ${ex.start}) ${ex.reason}"),
            leading: const Icon(Icons.error, color: Colors.red),
          ),
          if (ex != exceptions.last) const Divider(height: 0),
        ],
      ],
    );
  }
}
