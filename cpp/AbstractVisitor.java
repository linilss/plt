package cpp;
import cpp.Absyn.*;
/** BNFC-Generated Abstract Visitor */
public class AbstractVisitor<R,A> implements AllVisitor<R,A> {
/* Program */
    public R visit(cpp.Absyn.PDefs p, A arg) { return visitDefault(p, arg); }
    public R visitDefault(cpp.Absyn.Program p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }
/* Def */
    public R visit(cpp.Absyn.DFun p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.DFunBody p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.DUsing p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.DInit p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.DTD p, A arg) { return visitDefault(p, arg); }
    public R visitDefault(cpp.Absyn.Def p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }
/* Arg */
    public R visit(cpp.Absyn.ADecl p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.ADeclInit p, A arg) { return visitDefault(p, arg); }
    public R visitDefault(cpp.Absyn.Arg p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }
/* Stm */
    public R visit(cpp.Absyn.SExp p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.SInit p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.SReturn p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.SWhile p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.SBlock p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.SIf p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.SIfElse p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.SFor p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.SDoWhile p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.STD p, A arg) { return visitDefault(p, arg); }
    public R visitDefault(cpp.Absyn.Stm p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }
/* Var */
    public R visit(cpp.Absyn.VarDecl p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.VarInit p, A arg) { return visitDefault(p, arg); }
    public R visitDefault(cpp.Absyn.Var p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }
/* Exp */
    public R visit(cpp.Absyn.EInt p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EDouble p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EString p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.ETrue p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EFalse p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EApp p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EChar p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EQCon p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.ECall p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EStrDot p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EStrArr p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EIdx p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EPIncr p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EPDecr p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.EIncr p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EDecr p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.ENeg p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EMul p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.ETimes p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EDiv p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EMod p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.EPlus p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EMinus p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.ERS p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.ELS p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.ELt p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EGt p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.ELtEq p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EGtWq p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.EEq p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.ENEq p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.EAnd p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.EOr p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.EAss p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EAssAdd p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.EAssSub p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.ECond p, A arg) { return visitDefault(p, arg); }

    public R visit(cpp.Absyn.EThrow p, A arg) { return visitDefault(p, arg); }





    public R visitDefault(cpp.Absyn.Exp p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }
/* PType */
    public R visit(cpp.Absyn.Tbool p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.Tdouble p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.Tint p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.Tvoid p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.TChar p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.TQCon p, A arg) { return visitDefault(p, arg); }
    public R visitDefault(cpp.Absyn.PType p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }
/* RType */
    public R visit(cpp.Absyn.TPType p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.TRef p, A arg) { return visitDefault(p, arg); }
    public R visitDefault(cpp.Absyn.RType p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }
/* Type */
    public R visit(cpp.Absyn.TRType p, A arg) { return visitDefault(p, arg); }
    public R visit(cpp.Absyn.TConst p, A arg) { return visitDefault(p, arg); }
    public R visitDefault(cpp.Absyn.Type p, A arg) {
      throw new IllegalArgumentException(this.getClass().getName() + ": " + p);
    }

}
