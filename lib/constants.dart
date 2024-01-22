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

Operator? findInstruction(final String inst) {
  final lowerInst = inst.toLowerCase();
  for (final instruction in Operator.values) {
    if (instruction.name.toLowerCase() == lowerInst) {
      return instruction;
    }
  }
  return null;
}
