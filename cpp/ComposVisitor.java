package cpp;
import cpp.Absyn.*;
/** BNFC-Generated Composition Visitor
*/

public class ComposVisitor<A> implements
  cpp.Absyn.Program.Visitor<cpp.Absyn.Program,A>,
  cpp.Absyn.Def.Visitor<cpp.Absyn.Def,A>,
  cpp.Absyn.Arg.Visitor<cpp.Absyn.Arg,A>,
  cpp.Absyn.Stm.Visitor<cpp.Absyn.Stm,A>,
  cpp.Absyn.Var.Visitor<cpp.Absyn.Var,A>,
  cpp.Absyn.Exp.Visitor<cpp.Absyn.Exp,A>,
  cpp.Absyn.PType.Visitor<cpp.Absyn.PType,A>,
  cpp.Absyn.RType.Visitor<cpp.Absyn.RType,A>,
  cpp.Absyn.Type.Visitor<cpp.Absyn.Type,A>
{
/* Program */
    public Program visit(cpp.Absyn.PDefs p, A arg)
    {
      ListDef listdef_ = new ListDef();
      for (Def x : p.listdef_)
      {
        listdef_.add(x.accept(this,arg));
      }
      return new cpp.Absyn.PDefs(listdef_);
    }
/* Def */
    public Def visit(cpp.Absyn.DFun p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      String id_ = p.id_;
      ListArg listarg_ = new ListArg();
      for (Arg x : p.listarg_)
      {
        listarg_.add(x.accept(this,arg));
      }
      ListStm liststm_ = new ListStm();
      for (Stm x : p.liststm_)
      {
        liststm_.add(x.accept(this,arg));
      }
      return new cpp.Absyn.DFun(type_, id_, listarg_, liststm_);
    }    public Def visit(cpp.Absyn.DFunBody p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      String id_ = p.id_;
      ListArg listarg_ = new ListArg();
      for (Arg x : p.listarg_)
      {
        listarg_.add(x.accept(this,arg));
      }
      return new cpp.Absyn.DFunBody(type_, id_, listarg_);
    }    public Def visit(cpp.Absyn.DUsing p, A arg)
    {
      ListId listid_ = p.listid_;
      return new cpp.Absyn.DUsing(listid_);
    }    public Def visit(cpp.Absyn.DInit p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      ListVar listvar_ = new ListVar();
      for (Var x : p.listvar_)
      {
        listvar_.add(x.accept(this,arg));
      }
      return new cpp.Absyn.DInit(type_, listvar_);
    }    public Def visit(cpp.Absyn.DTD p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      String id_ = p.id_;
      return new cpp.Absyn.DTD(type_, id_);
    }
/* Arg */
    public Arg visit(cpp.Absyn.ADecl p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      Var var_ = p.var_.accept(this, arg);
      return new cpp.Absyn.ADecl(type_, var_);
    }    public Arg visit(cpp.Absyn.ADeclInit p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      return new cpp.Absyn.ADeclInit(type_);
    }
/* Stm */
    public Stm visit(cpp.Absyn.SExp p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.SExp(exp_);
    }    public Stm visit(cpp.Absyn.SInit p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      ListVar listvar_ = new ListVar();
      for (Var x : p.listvar_)
      {
        listvar_.add(x.accept(this,arg));
      }
      return new cpp.Absyn.SInit(type_, listvar_);
    }    public Stm visit(cpp.Absyn.SReturn p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.SReturn(exp_);
    }    public Stm visit(cpp.Absyn.SWhile p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      Stm stm_ = p.stm_.accept(this, arg);
      return new cpp.Absyn.SWhile(exp_, stm_);
    }    public Stm visit(cpp.Absyn.SBlock p, A arg)
    {
      ListStm liststm_ = new ListStm();
      for (Stm x : p.liststm_)
      {
        liststm_.add(x.accept(this,arg));
      }
      return new cpp.Absyn.SBlock(liststm_);
    }    public Stm visit(cpp.Absyn.SIf p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      Stm stm_ = p.stm_.accept(this, arg);
      return new cpp.Absyn.SIf(exp_, stm_);
    }    public Stm visit(cpp.Absyn.SIfElse p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      Stm stm_1 = p.stm_1.accept(this, arg);
      Stm stm_2 = p.stm_2.accept(this, arg);
      return new cpp.Absyn.SIfElse(exp_, stm_1, stm_2);
    }    public Stm visit(cpp.Absyn.SFor p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      ListVar listvar_ = new ListVar();
      for (Var x : p.listvar_)
      {
        listvar_.add(x.accept(this,arg));
      }
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      Stm stm_ = p.stm_.accept(this, arg);
      return new cpp.Absyn.SFor(type_, listvar_, exp_1, exp_2, stm_);
    }    public Stm visit(cpp.Absyn.SDoWhile p, A arg)
    {
      Stm stm_ = p.stm_.accept(this, arg);
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.SDoWhile(stm_, exp_);
    }    public Stm visit(cpp.Absyn.STD p, A arg)
    {
      Type type_ = p.type_.accept(this, arg);
      String id_ = p.id_;
      return new cpp.Absyn.STD(type_, id_);
    }
/* Var */
    public Var visit(cpp.Absyn.VarDecl p, A arg)
    {
      String id_ = p.id_;
      return new cpp.Absyn.VarDecl(id_);
    }    public Var visit(cpp.Absyn.VarInit p, A arg)
    {
      String id_ = p.id_;
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.VarInit(id_, exp_);
    }
/* Exp */
    public Exp visit(cpp.Absyn.EInt p, A arg)
    {
      Integer integer_ = p.integer_;
      return new cpp.Absyn.EInt(integer_);
    }    public Exp visit(cpp.Absyn.EDouble p, A arg)
    {
      Double double_ = p.double_;
      return new cpp.Absyn.EDouble(double_);
    }    public Exp visit(cpp.Absyn.EString p, A arg)
    {
      ListString liststring_ = p.liststring_;
      return new cpp.Absyn.EString(liststring_);
    }    public Exp visit(cpp.Absyn.ETrue p, A arg)
    {
      return new cpp.Absyn.ETrue();
    }    public Exp visit(cpp.Absyn.EFalse p, A arg)
    {
      return new cpp.Absyn.EFalse();
    }    public Exp visit(cpp.Absyn.EApp p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      ListExp listexp_ = new ListExp();
      for (Exp x : p.listexp_)
      {
        listexp_.add(x.accept(this,arg));
      }
      return new cpp.Absyn.EApp(exp_, listexp_);
    }    public Exp visit(cpp.Absyn.EChar p, A arg)
    {
      Character char_ = p.char_;
      return new cpp.Absyn.EChar(char_);
    }    public Exp visit(cpp.Absyn.EQCon p, A arg)
    {
      ListId listid_ = p.listid_;
      return new cpp.Absyn.EQCon(listid_);
    }    public Exp visit(cpp.Absyn.ECall p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      ListExp listexp_ = new ListExp();
      for (Exp x : p.listexp_)
      {
        listexp_.add(x.accept(this,arg));
      }
      return new cpp.Absyn.ECall(exp_, listexp_);
    }    public Exp visit(cpp.Absyn.EStrDot p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EStrDot(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EStrArr p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EStrArr(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EIdx p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EIdx(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EPIncr p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.EPIncr(exp_);
    }    public Exp visit(cpp.Absyn.EPDecr p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.EPDecr(exp_);
    }    public Exp visit(cpp.Absyn.EIncr p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.EIncr(exp_);
    }    public Exp visit(cpp.Absyn.EDecr p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.EDecr(exp_);
    }    public Exp visit(cpp.Absyn.ENeg p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.ENeg(exp_);
    }    public Exp visit(cpp.Absyn.EMul p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.EMul(exp_);
    }    public Exp visit(cpp.Absyn.ETimes p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.ETimes(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EDiv p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EDiv(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EMod p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EMod(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EPlus p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EPlus(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EMinus p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EMinus(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.ERS p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.ERS(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.ELS p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.ELS(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.ELt p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.ELt(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EGt p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EGt(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.ELtEq p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.ELtEq(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EGtWq p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EGtWq(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EEq p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EEq(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.ENEq p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.ENEq(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EAnd p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EAnd(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EOr p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EOr(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EAss p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EAss(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EAssAdd p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EAssAdd(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.EAssSub p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      return new cpp.Absyn.EAssSub(exp_1, exp_2);
    }    public Exp visit(cpp.Absyn.ECond p, A arg)
    {
      Exp exp_1 = p.exp_1.accept(this, arg);
      Exp exp_2 = p.exp_2.accept(this, arg);
      Exp exp_3 = p.exp_3.accept(this, arg);
      return new cpp.Absyn.ECond(exp_1, exp_2, exp_3);
    }    public Exp visit(cpp.Absyn.EThrow p, A arg)
    {
      Exp exp_ = p.exp_.accept(this, arg);
      return new cpp.Absyn.EThrow(exp_);
    }
/* PType */
    public PType visit(cpp.Absyn.Tbool p, A arg)
    {
      return new cpp.Absyn.Tbool();
    }    public PType visit(cpp.Absyn.Tdouble p, A arg)
    {
      return new cpp.Absyn.Tdouble();
    }    public PType visit(cpp.Absyn.Tint p, A arg)
    {
      return new cpp.Absyn.Tint();
    }    public PType visit(cpp.Absyn.Tvoid p, A arg)
    {
      return new cpp.Absyn.Tvoid();
    }    public PType visit(cpp.Absyn.TChar p, A arg)
    {
      return new cpp.Absyn.TChar();
    }    public PType visit(cpp.Absyn.TQCon p, A arg)
    {
      ListId listid_ = p.listid_;
      return new cpp.Absyn.TQCon(listid_);
    }
/* RType */
    public RType visit(cpp.Absyn.TPType p, A arg)
    {
      PType ptype_ = p.ptype_.accept(this, arg);
      return new cpp.Absyn.TPType(ptype_);
    }    public RType visit(cpp.Absyn.TRef p, A arg)
    {
      RType rtype_ = p.rtype_.accept(this, arg);
      return new cpp.Absyn.TRef(rtype_);
    }
/* Type */
    public Type visit(cpp.Absyn.TRType p, A arg)
    {
      RType rtype_ = p.rtype_.accept(this, arg);
      return new cpp.Absyn.TRType(rtype_);
    }    public Type visit(cpp.Absyn.TConst p, A arg)
    {
      RType rtype_ = p.rtype_.accept(this, arg);
      return new cpp.Absyn.TConst(rtype_);
    }
}