package cpp;

import cpp.Absyn.*;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;

/** BNFC-Generated Fold Visitor */
public abstract class FoldVisitor<R,A> implements AllVisitor<R,A> {
    public abstract R leaf(A arg);
    public abstract R combine(R x, R y, A arg);

/* Program */
    public R visit(cpp.Absyn.PDefs p, A arg) {
      R r = leaf(arg);
      for (Def x : p.listdef_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      return r;
    }

/* Def */
    public R visit(cpp.Absyn.DFun p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      for (Arg x : p.listarg_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      for (Stm x : p.liststm_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      return r;
    }
    public R visit(cpp.Absyn.DFunBody p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      for (Arg x : p.listarg_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      return r;
    }
    public R visit(cpp.Absyn.DUsing p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.DInit p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      for (Var x : p.listvar_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      return r;
    }
    public R visit(cpp.Absyn.DTD p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      return r;
    }

/* Arg */
    public R visit(cpp.Absyn.ADecl p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      r = combine(p.var_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ADeclInit p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      return r;
    }

/* Stm */
    public R visit(cpp.Absyn.SExp p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.SInit p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      for (Var x : p.listvar_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      return r;
    }
    public R visit(cpp.Absyn.SReturn p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.SWhile p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      r = combine(p.stm_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.SBlock p, A arg) {
      R r = leaf(arg);
      for (Stm x : p.liststm_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      return r;
    }
    public R visit(cpp.Absyn.SIf p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      r = combine(p.stm_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.SIfElse p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      r = combine(p.stm_1.accept(this, arg), r, arg);
      r = combine(p.stm_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.SFor p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      for (Var x : p.listvar_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      r = combine(p.stm_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.SDoWhile p, A arg) {
      R r = leaf(arg);
      r = combine(p.stm_.accept(this, arg), r, arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.STD p, A arg) {
      R r = leaf(arg);
      r = combine(p.type_.accept(this, arg), r, arg);
      return r;
    }

/* Var */
    public R visit(cpp.Absyn.VarDecl p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.VarInit p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }

/* Exp */
    public R visit(cpp.Absyn.EInt p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.EDouble p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.EString p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.ETrue p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.EFalse p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.EApp p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      for (Exp x : p.listexp_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      return r;
    }
    public R visit(cpp.Absyn.EChar p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.EQCon p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.ECall p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      for (Exp x : p.listexp_)
      {
        r = combine(x.accept(this, arg), r, arg);
      }
      return r;
    }
    public R visit(cpp.Absyn.EStrDot p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EStrArr p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EIdx p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EPIncr p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EPDecr p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EIncr p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EDecr p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ENeg p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EMul p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ETimes p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EDiv p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EMod p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EPlus p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EMinus p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ERS p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ELS p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ELt p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EGt p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ELtEq p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EGtWq p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EEq p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ENEq p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EAnd p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EOr p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EAss p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EAssAdd p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EAssSub p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.ECond p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_1.accept(this, arg), r, arg);
      r = combine(p.exp_2.accept(this, arg), r, arg);
      r = combine(p.exp_3.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.EThrow p, A arg) {
      R r = leaf(arg);
      r = combine(p.exp_.accept(this, arg), r, arg);
      return r;
    }

/* PType */
    public R visit(cpp.Absyn.Tbool p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.Tdouble p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.Tint p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.Tvoid p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.TChar p, A arg) {
      R r = leaf(arg);
      return r;
    }
    public R visit(cpp.Absyn.TQCon p, A arg) {
      R r = leaf(arg);
      return r;
    }

/* RType */
    public R visit(cpp.Absyn.TPType p, A arg) {
      R r = leaf(arg);
      r = combine(p.ptype_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.TRef p, A arg) {
      R r = leaf(arg);
      r = combine(p.rtype_.accept(this, arg), r, arg);
      return r;
    }

/* Type */
    public R visit(cpp.Absyn.TRType p, A arg) {
      R r = leaf(arg);
      r = combine(p.rtype_.accept(this, arg), r, arg);
      return r;
    }
    public R visit(cpp.Absyn.TConst p, A arg) {
      R r = leaf(arg);
      r = combine(p.rtype_.accept(this, arg), r, arg);
      return r;
    }


}
