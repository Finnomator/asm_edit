enum Operator {
  load,
  dLoad,
  store,
  add,
  sub,
  mult,
  div,
  jump,
  jge,
  jgt,
  jle,
  jlt,
  jeq,
  jne,
  end,
  inc,
  dec
}

const Map<Operator, String> operatorDescriptions = {
  Operator.load:  "LOAD x : Kopiert den Wert in Register x in den Akkumulator",
  Operator.dLoad: "DLOAD i: Lädt i in den Akkumulator",
  Operator.store: "STORE x: Kopiert den Wert im Akkumulator nach Register x",
  Operator.add:   "ADD x  : Addiert den Wert in Register x zum Wert im Akkumulator",
  Operator.sub:   "SUB x  : Subtrahiert den Wert in Register x vom Wert im Akkumulator",
  Operator.mult:  "MULT x : Multipliziert den Wert in Register x mit dem Wert im Akkumulator",
  Operator.div:   "DIV x  : Dividiert den Wert im Akkumulator durch den Wert in Register x",
  Operator.jge:   "JGE n  : Setzt Befehlszähler auf n, wenn Akkumulator >= 0",
  Operator.jgt:   "JGT n  : Setzt Befehlszähler auf n, wenn Akkumulator > 0",
  Operator.jle:   "JLE n  : Setzt Befehlszähler auf n, wenn Akkumulator <= 0",
  Operator.jlt:   "JLT n  : Setzt Befehlszähler auf n, wenn Akkumulator < 0",
  Operator.jeq:   "JEQ n  : Setzt Befehlszähler auf n, wenn Akkumulator == 0",
  Operator.jne:   "JNE n  : Setzt Befehlszähler auf n, wenn Akkumulator != 0",
  Operator.end:   "END    : Beended Programm",
  Operator.inc:   "INC    : Akkumulator++",
  Operator.dec:   "DEC    : Akkumulator--",
};

Operator? findInstruction(final String inst) {
  final lowerInst = inst.toLowerCase();
  for (final instruction in Operator.values) {
    if (instruction.name.toLowerCase() == lowerInst) {
      return instruction;
    }
  }
  return null;
}
