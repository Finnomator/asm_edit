import 'package:asm_edit/constants.dart';

class CompileException extends FormatException {
  final int start;
  final int end;
  final String reason;
  final int line;

  CompileException(this.start, this.end, this.reason, this.line);
}

class BaseInstruction {
  final Operator operator;

  BaseInstruction(this.operator);
}

class Instruction extends BaseInstruction {
  final int argument;

  Instruction(super.operator, this.argument);
}

class Compiler {

  static BaseInstruction compileLine(String line, int lineIdx) {
    line = line.trim();
    final List<String> splited = line.split(" ");
    if (splited.isEmpty) {
      throw CompileException(0, 0, "No Instruction", lineIdx);
    }

    final Operator? instruction = findInstruction(splited[0]);

    if (instruction == null) {
      throw CompileException(
          0, splited[0].length, "Unknown Instruction", lineIdx);
    }

    if (const [Operator.inc, Operator.dec, Operator.end]
        .contains(instruction)) {
      return BaseInstruction(instruction);
    }

    if (splited.length < 2) {
      throw CompileException(0, splited[0].length, "No Argument", lineIdx);
    }

    final int? parsedArgument = int.tryParse(splited[1]);

    if (parsedArgument == null) {
      throw CompileException(
          splited[0].length + 1,
          splited[0].length + 1 + splited[1].length,
          "Invalid Argument",
          lineIdx);
    }

    return Instruction(instruction, parsedArgument);
  }

  static (List<BaseInstruction> instructions, List<CompileException> errors) compile(String program) {
    final List<BaseInstruction> compiledInstructions = [];
    final List<CompileException> compileErrors = [];

    final List<String> lines = program.split("\n");

    for (int i = 0; i < lines.length; ++i) {
      final String line = lines[i].trim();

      if (line.isEmpty) continue;

      try {
        final BaseInstruction compiled = compileLine(line, i);
        compiledInstructions.add(compiled);
      } on CompileException catch (e) {
        compileErrors.add(e);
      }
    }

    return (compiledInstructions, compileErrors);
  }
}
