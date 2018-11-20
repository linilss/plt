package cpp;
import cpp.Absyn.*;
/*** BNFC-Generated Visitor Design Pattern Skeleton. ***/
/* This implements the common visitor design pattern.
   Tests show it to be slightly less efficient than the
   instanceof method, but easier to use. 
   Replace the R and A parameters with the desired return
   and context types.*/

public class VisitSkel
{
  public class ProgramVisitor<R,A> implements Program.Visitor<R,A>
  {
    public R visit(cpp.Absyn.PDefs p, A arg)
    { /* Code For PDefs Goes Here */
      for (Def x: p.listdef_)
      { /* ... */ }
      return null;
    }
  }
  public class DefVisitor<R,A> implements Def.Visitor<R,A>
  {
    public R visit(cpp.Absyn.DFun p, A arg)
    { /* Code For DFun Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      //p.id_;
      for (Arg x: p.listarg_)
      { /* ... */ }
      for (Stm x: p.liststm_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.DFunBody p, A arg)
    { /* Code For DFunBody Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      //p.id_;
      for (Arg x: p.listarg_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.DUsing p, A arg)
    { /* Code For DUsing Goes Here */
      for (String x: p.listid_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.DInit p, A arg)
    { /* Code For DInit Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      for (Var x: p.listvar_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.DTD p, A arg)
    { /* Code For DTD Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      //p.id_;
      return null;
    }
  }
  public class ArgVisitor<R,A> implements Arg.Visitor<R,A>
  {
    public R visit(cpp.Absyn.ADecl p, A arg)
    { /* Code For ADecl Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      p.var_.accept(new VarVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.ADeclInit p, A arg)
    { /* Code For ADeclInit Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      return null;
    }
  }
  public class StmVisitor<R,A> implements Stm.Visitor<R,A>
  {
    public R visit(cpp.Absyn.SExp p, A arg)
    { /* Code For SExp Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.SInit p, A arg)
    { /* Code For SInit Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      for (Var x: p.listvar_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.SReturn p, A arg)
    { /* Code For SReturn Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.SWhile p, A arg)
    { /* Code For SWhile Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      p.stm_.accept(new StmVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.SBlock p, A arg)
    { /* Code For SBlock Goes Here */
      for (Stm x: p.liststm_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.SIf p, A arg)
    { /* Code For SIf Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      p.stm_.accept(new StmVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.SIfElse p, A arg)
    { /* Code For SIfElse Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      p.stm_1.accept(new StmVisitor<R,A>(), arg);
      p.stm_2.accept(new StmVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.SFor p, A arg)
    { /* Code For SFor Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      for (Var x: p.listvar_)
      { /* ... */ }
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      p.stm_.accept(new StmVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.SDoWhile p, A arg)
    { /* Code For SDoWhile Goes Here */
      p.stm_.accept(new StmVisitor<R,A>(), arg);
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.STD p, A arg)
    { /* Code For STD Goes Here */
      p.type_.accept(new TypeVisitor<R,A>(), arg);
      //p.id_;
      return null;
    }
  }
  public class VarVisitor<R,A> implements Var.Visitor<R,A>
  {
    public R visit(cpp.Absyn.VarDecl p, A arg)
    { /* Code For VarDecl Goes Here */
      //p.id_;
      return null;
    }    public R visit(cpp.Absyn.VarInit p, A arg)
    { /* Code For VarInit Goes Here */
      //p.id_;
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }
  }
  public class ExpVisitor<R,A> implements Exp.Visitor<R,A>
  {
    public R visit(cpp.Absyn.EInt p, A arg)
    { /* Code For EInt Goes Here */
      //p.integer_;
      return null;
    }    public R visit(cpp.Absyn.EDouble p, A arg)
    { /* Code For EDouble Goes Here */
      //p.double_;
      return null;
    }    public R visit(cpp.Absyn.EString p, A arg)
    { /* Code For EString Goes Here */
      for (String x: p.liststring_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.ETrue p, A arg)
    { /* Code For ETrue Goes Here */
      return null;
    }    public R visit(cpp.Absyn.EFalse p, A arg)
    { /* Code For EFalse Goes Here */
      return null;
    }    public R visit(cpp.Absyn.EApp p, A arg)
    { /* Code For EApp Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      for (Exp x: p.listexp_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.EChar p, A arg)
    { /* Code For EChar Goes Here */
      //p.char_;
      return null;
    }    public R visit(cpp.Absyn.EQCon p, A arg)
    { /* Code For EQCon Goes Here */
      for (String x: p.listid_)
      { /* ... */ }
      return null;
    }        public R visit(cpp.Absyn.ECall p, A arg)
    { /* Code For ECall Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      for (Exp x: p.listexp_)
      { /* ... */ }
      return null;
    }    public R visit(cpp.Absyn.EStrDot p, A arg)
    { /* Code For EStrDot Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EStrArr p, A arg)
    { /* Code For EStrArr Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EIdx p, A arg)
    { /* Code For EIdx Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EPIncr p, A arg)
    { /* Code For EPIncr Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EPDecr p, A arg)
    { /* Code For EPDecr Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.EIncr p, A arg)
    { /* Code For EIncr Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EDecr p, A arg)
    { /* Code For EDecr Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.ENeg p, A arg)
    { /* Code For ENeg Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EMul p, A arg)
    { /* Code For EMul Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.ETimes p, A arg)
    { /* Code For ETimes Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EDiv p, A arg)
    { /* Code For EDiv Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EMod p, A arg)
    { /* Code For EMod Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.EPlus p, A arg)
    { /* Code For EPlus Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EMinus p, A arg)
    { /* Code For EMinus Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.ERS p, A arg)
    { /* Code For ERS Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.ELS p, A arg)
    { /* Code For ELS Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.ELt p, A arg)
    { /* Code For ELt Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EGt p, A arg)
    { /* Code For EGt Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.ELtEq p, A arg)
    { /* Code For ELtEq Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EGtWq p, A arg)
    { /* Code For EGtWq Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.EEq p, A arg)
    { /* Code For EEq Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.ENEq p, A arg)
    { /* Code For ENEq Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.EAnd p, A arg)
    { /* Code For EAnd Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.EOr p, A arg)
    { /* Code For EOr Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.EAss p, A arg)
    { /* Code For EAss Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EAssAdd p, A arg)
    { /* Code For EAssAdd Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.EAssSub p, A arg)
    { /* Code For EAssSub Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.ECond p, A arg)
    { /* Code For ECond Goes Here */
      p.exp_1.accept(new ExpVisitor<R,A>(), arg);
      p.exp_2.accept(new ExpVisitor<R,A>(), arg);
      p.exp_3.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }        public R visit(cpp.Absyn.EThrow p, A arg)
    { /* Code For EThrow Goes Here */
      p.exp_.accept(new ExpVisitor<R,A>(), arg);
      return null;
    }                    
  }
  public class PTypeVisitor<R,A> implements PType.Visitor<R,A>
  {
    public R visit(cpp.Absyn.Tbool p, A arg)
    { /* Code For Tbool Goes Here */
      return null;
    }    public R visit(cpp.Absyn.Tdouble p, A arg)
    { /* Code For Tdouble Goes Here */
      return null;
    }    public R visit(cpp.Absyn.Tint p, A arg)
    { /* Code For Tint Goes Here */
      return null;
    }    public R visit(cpp.Absyn.Tvoid p, A arg)
    { /* Code For Tvoid Goes Here */
      return null;
    }    public R visit(cpp.Absyn.TChar p, A arg)
    { /* Code For TChar Goes Here */
      return null;
    }    public R visit(cpp.Absyn.TQCon p, A arg)
    { /* Code For TQCon Goes Here */
      for (String x: p.listid_)
      { /* ... */ }
      return null;
    }
  }
  public class RTypeVisitor<R,A> implements RType.Visitor<R,A>
  {
    public R visit(cpp.Absyn.TPType p, A arg)
    { /* Code For TPType Goes Here */
      p.ptype_.accept(new PTypeVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.TRef p, A arg)
    { /* Code For TRef Goes Here */
      p.rtype_.accept(new RTypeVisitor<R,A>(), arg);
      return null;
    }
  }
  public class TypeVisitor<R,A> implements Type.Visitor<R,A>
  {
    public R visit(cpp.Absyn.TRType p, A arg)
    { /* Code For TRType Goes Here */
      p.rtype_.accept(new RTypeVisitor<R,A>(), arg);
      return null;
    }    public R visit(cpp.Absyn.TConst p, A arg)
    { /* Code For TConst Goes Here */
      p.rtype_.accept(new RTypeVisitor<R,A>(), arg);
      return null;
    }
  }
}