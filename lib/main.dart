import 'dart:io';

import 'package:asm_edit/computer_viewer/special_register_viewer.dart';
import 'package:asm_edit/editor/editor.dart';
import 'package:asm_edit/editor/help_widget.dart';
import 'package:asm_edit/runner/asm_runner.dart';
import 'package:asm_edit/runner/compiler.dart';
import 'package:asm_edit/runner/errors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'computer_viewer/memory_viewer.dart';

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
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
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
  List<int> memory = List.filled(MemoryViewerWidget.maxMemCells, 0);
  List<CompileException> compileExceptions = [];

  int instructionPointer = 0;
  int accumulator = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asm Editor"),
        actions: [
          Expanded(
            child: MenuBar(
              children: [
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      child: const MenuAcceleratorLabel("&Open"),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          File file = File(result.files.single.path!);
                          textCtrler.text = await file.readAsString();
                        }
                      },
                    ),
                    MenuItemButton(
                      child: const MenuAcceleratorLabel("&Save as"),
                      onPressed: () async {
                        String? outputFile = await FilePicker.platform.saveFile(
                          dialogTitle: 'Please Select an Output File',
                          fileName: 'asm_code.txt',
                        );

                        if (outputFile != null && mounted) {
                          File(outputFile).writeAsString(textCtrler.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Saved'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                  child: const MenuAcceleratorLabel("&File"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton.outlined(
              onPressed: runPressed,
              icon: const Icon(Icons.play_arrow_outlined, color: Colors.green),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SpecialRegisterViewer(
                        instructionPointer: instructionPointer,
                        accumulator: accumulator,
                      ),
                      Expanded(
                        flex: 2,
                        child: MemoryViewerWidget(memoryValues: memory),
                      ),
                      const InstructionsDescriptor(),
                    ],
                  ),
                ),
                const VerticalDivider(),
                const Flexible(child: EditorWidget()),
              ],
            ),
          ),
          const Divider(height: 0),
          if (compileExceptions.isNotEmpty)
            CompileErrorsWidget(exceptions: compileExceptions)
        ],
      ),
    );
  }

  void runPressed() {
    final computer = Computer();

    setState(() {
      compileExceptions.clear();
      instructionPointer = 0;
      memory.fillRange(0, memory.length, 0);
      accumulator = 0;
    });

    final (instructions, errors) = Compiler.compile(textCtrler.text);

    setState(() => compileExceptions = errors);

    if (errors.isNotEmpty) return;

    for (final instruction in instructions) {
      if (computer.executeInstruction(instruction)) break;
      setState(() {
        memory = computer.memory;
        instructionPointer = computer.instructionPointer;
        accumulator = computer.akkumulator;
      });
    }
  }
}
