import 'package:asm_edit/editor/editor.dart';
import 'package:asm_edit/memory_viewer/memory_viewer.dart';
import 'package:asm_edit/runner/asm_runner.dart';
import 'package:asm_edit/runner/compiler.dart';
import 'package:asm_edit/runner/errors.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asm Editor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white12),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<int> memory = [];
  List<CompileException> compileExceptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asm Editor"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                MemoryViewerWidget(memoryValues: memory),
                Expanded(
                  child: Column(
                    children: [
                      IconButton.outlined(
                        onPressed: runPressed,
                        icon: const Icon(Icons.play_arrow_outlined),
                      ),
                      const Expanded(child: EditorWidget()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              CompileErrorsWidget(exceptions: compileExceptions),
            ],
          )
        ],
      ),
    );
  }

  void runPressed() {
    final computer = Computer();

    setState(compileExceptions.clear);

    final (instructions, errors) = Compiler.compile(textCtrler.text);

    setState(() => compileExceptions = errors);

    if (errors.isNotEmpty) {
      return;
    }

    for (final instruction in instructions) {
      computer.executeInstruction(instruction);
      setState(() => memory = computer.memory);
    }
  }
}
