import 'package:asm_edit/constants.dart';
import 'package:asm_edit/memory_viewer/memory_viewer.dart';
import 'package:asm_edit/runner/compiler.dart';

class Computer {
  int akkumulator = 0;
  int instructionPointer = 0;
  final List<int> memory = List.filled(MemoryViewerWidget.maxMemCells, 0);

  bool executeInstruction(BaseInstruction instruction) {
    // Returns if the program is done.
    final Operator op = instruction.operator;
    switch (op) {
      case Operator.load:
        akkumulator = memory[(instruction as Instruction).argument];
        ++instructionPointer;
        break;
      case Operator.dLoad:
        akkumulator = (instruction as Instruction).argument;
        ++instructionPointer;
        break;
      case Operator.store:
        memory[(instruction as Instruction).argument] = akkumulator;
        ++instructionPointer;
        break;
      case Operator.add:
        akkumulator += memory[(instruction as Instruction).argument];
        ++instructionPointer;
        break;
      case Operator.sub:
        akkumulator -= memory[(instruction as Instruction).argument];
        ++instructionPointer;
        break;
      case Operator.mult:
        akkumulator *= memory[(instruction as Instruction).argument];
        ++instructionPointer;
        break;
      case Operator.div:
        akkumulator ~/= memory[(instruction as Instruction).argument];
        ++instructionPointer;
        break;
      case Operator.jump:
        instructionPointer = (instruction as Instruction).argument;
        break;
      case Operator.jge:
        if (akkumulator >= 0) {
          instructionPointer = (instruction as Instruction).argument;
        } else {
          ++instructionPointer;
        }
        break;
      case Operator.jgt:
        if (akkumulator > 0) {
          instructionPointer = (instruction as Instruction).argument;
        } else {
          ++instructionPointer;
        }
        break;
      case Operator.jle:
        if (akkumulator <= 0) {
          instructionPointer = (instruction as Instruction).argument;
        } else {
          ++instructionPointer;
        }
        break;
      case Operator.jlt:
        if (akkumulator < 0) {
          instructionPointer = (instruction as Instruction).argument;
        } else {
          ++instructionPointer;
        }
        break;
      case Operator.jeq:
        if (akkumulator == 0) {
          instructionPointer = (instruction as Instruction).argument;
        } else {
          ++instructionPointer;
        }
        break;
      case Operator.jne:
        if (akkumulator != 0) {
          instructionPointer = (instruction as Instruction).argument;
        } else {
          ++instructionPointer;
        }
        break;
      case Operator.end:
        return true;
      case Operator.inc:
        ++akkumulator;
        ++instructionPointer;
        break;
      case Operator.dec:
        --akkumulator;
        ++instructionPointer;
        break;
    }
    return false;
  }
}
