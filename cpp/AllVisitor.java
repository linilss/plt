package cpp;

import cpp.Absyn.*;

/** BNFC-Generated All Visitor */
public interface AllVisitor<R,A> extends
  cpp.Absyn.Program.Visitor<R,A>,
  cpp.Absyn.Def.Visitor<R,A>,
  cpp.Absyn.Arg.Visitor<R,A>,
  cpp.Absyn.Stm.Visitor<R,A>,
  cpp.Absyn.Var.Visitor<R,A>,
  cpp.Absyn.Exp.Visitor<R,A>,
  cpp.Absyn.PType.Visitor<R,A>,
  cpp.Absyn.RType.Visitor<R,A>,
  cpp.Absyn.Type.Visitor<R,A>
{}
