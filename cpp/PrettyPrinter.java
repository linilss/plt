package cpp;
import cpp.Absyn.*;

public class PrettyPrinter
{
  //For certain applications increasing the initial size of the buffer may improve performance.
  private static final int INITIAL_BUFFER_SIZE = 128;
  private static final int INDENT_WIDTH = 2;
  //You may wish to change the parentheses used in precedence.
  private static final String _L_PAREN = new String("(");
  private static final String _R_PAREN = new String(")");
  //You may wish to change render
  private static void render(String s)
  {
    if (s.equals("{"))
    {
       buf_.append("\n");
       indent();
       buf_.append(s);
       _n_ = _n_ + INDENT_WIDTH;
       buf_.append("\n");
       indent();
    }
    else if (s.equals("(") || s.equals("["))
       buf_.append(s);
    else if (s.equals(")") || s.equals("]"))
    {
       backup();
       buf_.append(s);
       buf_.append(" ");
    }
    else if (s.equals("}"))
    {
       int t;
       _n_ = _n_ - INDENT_WIDTH;
       for(t=0; t<INDENT_WIDTH; t++) {
         backup();
       }
       buf_.append(s);
       buf_.append("\n");
       indent();
    }
    else if (s.equals(","))
    {
       backup();
       buf_.append(s);
       buf_.append(" ");
    }
    else if (s.equals(";"))
    {
       backup();
       buf_.append(s);
       buf_.append("\n");
       indent();
    }
    else if (s.equals("")) return;
    else
    {
       buf_.append(s);
       buf_.append(" ");
    }
  }


  //  print and show methods are defined for each category.
  public static String print(cpp.Absyn.Program foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.Program foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.ListDef foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.ListDef foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.Def foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.Def foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.ListArg foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.ListArg foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.ListStm foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.ListStm foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.ListId foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.ListId foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.Arg foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.Arg foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.Stm foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.Stm foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.ListString foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.ListString foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.ListVar foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.ListVar foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.Var foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.Var foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.Exp foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.Exp foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.ListExp foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.ListExp foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.PType foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.PType foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.RType foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.RType foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String print(cpp.Absyn.Type foo)
  {
    pp(foo, 0);
    trim();
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  public static String show(cpp.Absyn.Type foo)
  {
    sh(foo);
    String temp = buf_.toString();
    buf_.delete(0,buf_.length());
    return temp;
  }
  /***   You shouldn't need to change anything beyond this point.   ***/

  private static void pp(cpp.Absyn.Program foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.PDefs)
    {
       cpp.Absyn.PDefs _pdefs = (cpp.Absyn.PDefs) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_pdefs.listdef_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
  }

  private static void pp(cpp.Absyn.ListDef foo, int _i_)
  {
     for (java.util.Iterator<Def> it = foo.iterator(); it.hasNext();)
     {
       pp(it.next(), _i_);
       if (it.hasNext()) {
         render("");
       } else {
         render("");
       }
     }  }

  private static void pp(cpp.Absyn.Def foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.DFun)
    {
       cpp.Absyn.DFun _dfun = (cpp.Absyn.DFun) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_dfun.type_, 0);
       pp(_dfun.id_, 0);
       render("(");
       pp(_dfun.listarg_, 0);
       render(")");
       render("{");
       pp(_dfun.liststm_, 0);
       render("}");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.DFunBody)
    {
       cpp.Absyn.DFunBody _dfunbody = (cpp.Absyn.DFunBody) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_dfunbody.type_, 0);
       pp(_dfunbody.id_, 0);
       render("(");
       pp(_dfunbody.listarg_, 0);
       render(")");
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.DUsing)
    {
       cpp.Absyn.DUsing _dusing = (cpp.Absyn.DUsing) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("using");
       pp(_dusing.listid_, 0);
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.DInit)
    {
       cpp.Absyn.DInit _dinit = (cpp.Absyn.DInit) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_dinit.type_, 0);
       pp(_dinit.listvar_, 0);
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.DTD)
    {
       cpp.Absyn.DTD _dtd = (cpp.Absyn.DTD) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("typedef");
       pp(_dtd.type_, 0);
       pp(_dtd.id_, 0);
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
  }

  private static void pp(cpp.Absyn.ListArg foo, int _i_)
  {
     for (java.util.Iterator<Arg> it = foo.iterator(); it.hasNext();)
     {
       pp(it.next(), _i_);
       if (it.hasNext()) {
         render(",");
       } else {
         render("");
       }
     }  }

  private static void pp(cpp.Absyn.ListStm foo, int _i_)
  {
     for (java.util.Iterator<Stm> it = foo.iterator(); it.hasNext();)
     {
       pp(it.next(), _i_);
       if (it.hasNext()) {
         render("");
       } else {
         render("");
       }
     }  }

  private static void pp(cpp.Absyn.ListId foo, int _i_)
  {
     for (java.util.Iterator<String> it = foo.iterator(); it.hasNext();)
     {
       pp(it.next(), _i_);
       if (it.hasNext()) {
         render("::");
       } else {
         render("");
       }
     }  }

  private static void pp(cpp.Absyn.Arg foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.ADecl)
    {
       cpp.Absyn.ADecl _adecl = (cpp.Absyn.ADecl) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_adecl.type_, 0);
       pp(_adecl.var_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ADeclInit)
    {
       cpp.Absyn.ADeclInit _adeclinit = (cpp.Absyn.ADeclInit) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_adeclinit.type_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
  }

  private static void pp(cpp.Absyn.Stm foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.SExp)
    {
       cpp.Absyn.SExp _sexp = (cpp.Absyn.SExp) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_sexp.exp_, 0);
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.SInit)
    {
       cpp.Absyn.SInit _sinit = (cpp.Absyn.SInit) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_sinit.type_, 0);
       pp(_sinit.listvar_, 0);
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.SReturn)
    {
       cpp.Absyn.SReturn _sreturn = (cpp.Absyn.SReturn) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("return");
       pp(_sreturn.exp_, 0);
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.SWhile)
    {
       cpp.Absyn.SWhile _swhile = (cpp.Absyn.SWhile) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("while");
       render("(");
       pp(_swhile.exp_, 0);
       render(")");
       pp(_swhile.stm_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.SBlock)
    {
       cpp.Absyn.SBlock _sblock = (cpp.Absyn.SBlock) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("{");
       pp(_sblock.liststm_, 0);
       render("}");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.SIf)
    {
       cpp.Absyn.SIf _sif = (cpp.Absyn.SIf) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("if");
       render("(");
       pp(_sif.exp_, 0);
       render(")");
       pp(_sif.stm_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.SIfElse)
    {
       cpp.Absyn.SIfElse _sifelse = (cpp.Absyn.SIfElse) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("if");
       render("(");
       pp(_sifelse.exp_, 0);
       render(")");
       pp(_sifelse.stm_1, 0);
       render("else");
       pp(_sifelse.stm_2, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.SFor)
    {
       cpp.Absyn.SFor _sfor = (cpp.Absyn.SFor) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("for");
       render("(");
       pp(_sfor.type_, 0);
       pp(_sfor.listvar_, 0);
       render(";");
       pp(_sfor.exp_1, 0);
       render(";");
       pp(_sfor.exp_2, 0);
       render(")");
       pp(_sfor.stm_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.SDoWhile)
    {
       cpp.Absyn.SDoWhile _sdowhile = (cpp.Absyn.SDoWhile) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("do");
       pp(_sdowhile.stm_, 0);
       render("while");
       render("(");
       pp(_sdowhile.exp_, 0);
       render(")");
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.STD)
    {
       cpp.Absyn.STD _std = (cpp.Absyn.STD) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("typedef");
       pp(_std.type_, 0);
       pp(_std.id_, 0);
       render(";");
       if (_i_ > 0) render(_R_PAREN);
    }
  }

  private static void pp(cpp.Absyn.ListString foo, int _i_)
  {
     for (java.util.Iterator<String> it = foo.iterator(); it.hasNext();)
     {
       pp(it.next(), _i_);
       if (it.hasNext()) {
         render("");
       } else {
         render("");
       }
     }  }

  private static void pp(cpp.Absyn.ListVar foo, int _i_)
  {
     for (java.util.Iterator<Var> it = foo.iterator(); it.hasNext();)
     {
       pp(it.next(), _i_);
       if (it.hasNext()) {
         render(",");
       } else {
         render("");
       }
     }  }

  private static void pp(cpp.Absyn.Var foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.VarDecl)
    {
       cpp.Absyn.VarDecl _vardecl = (cpp.Absyn.VarDecl) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_vardecl.id_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.VarInit)
    {
       cpp.Absyn.VarInit _varinit = (cpp.Absyn.VarInit) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_varinit.id_, 0);
       render("=");
       pp(_varinit.exp_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
  }

  private static void pp(cpp.Absyn.Exp foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.EInt)
    {
       cpp.Absyn.EInt _eint = (cpp.Absyn.EInt) foo;
       if (_i_ > 15) render(_L_PAREN);
       pp(_eint.integer_, 0);
       if (_i_ > 15) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EDouble)
    {
       cpp.Absyn.EDouble _edouble = (cpp.Absyn.EDouble) foo;
       if (_i_ > 15) render(_L_PAREN);
       pp(_edouble.double_, 0);
       if (_i_ > 15) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EString)
    {
       cpp.Absyn.EString _estring = (cpp.Absyn.EString) foo;
       if (_i_ > 15) render(_L_PAREN);
       pp(_estring.liststring_, 0);
       if (_i_ > 15) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ETrue)
    {
       cpp.Absyn.ETrue _etrue = (cpp.Absyn.ETrue) foo;
       if (_i_ > 15) render(_L_PAREN);
       render("true");
       if (_i_ > 15) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EFalse)
    {
       cpp.Absyn.EFalse _efalse = (cpp.Absyn.EFalse) foo;
       if (_i_ > 15) render(_L_PAREN);
       render("false");
       if (_i_ > 15) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EApp)
    {
       cpp.Absyn.EApp _eapp = (cpp.Absyn.EApp) foo;
       if (_i_ > 15) render(_L_PAREN);
       pp(_eapp.exp_, 0);
       render("(");
       pp(_eapp.listexp_, 0);
       render(")");
       if (_i_ > 15) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EChar)
    {
       cpp.Absyn.EChar _echar = (cpp.Absyn.EChar) foo;
       if (_i_ > 15) render(_L_PAREN);
       pp(_echar.char_, 0);
       if (_i_ > 15) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EQCon)
    {
       cpp.Absyn.EQCon _eqcon = (cpp.Absyn.EQCon) foo;
       if (_i_ > 15) render(_L_PAREN);
       pp(_eqcon.listid_, 0);
       if (_i_ > 15) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ECall)
    {
       cpp.Absyn.ECall _ecall = (cpp.Absyn.ECall) foo;
       if (_i_ > 14) render(_L_PAREN);
       pp(_ecall.exp_, 14);
       render("(");
       pp(_ecall.listexp_, 0);
       render(")");
       if (_i_ > 14) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EStrDot)
    {
       cpp.Absyn.EStrDot _estrdot = (cpp.Absyn.EStrDot) foo;
       if (_i_ > 14) render(_L_PAREN);
       pp(_estrdot.exp_1, 14);
       render(".");
       pp(_estrdot.exp_2, 15);
       if (_i_ > 14) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EStrArr)
    {
       cpp.Absyn.EStrArr _estrarr = (cpp.Absyn.EStrArr) foo;
       if (_i_ > 14) render(_L_PAREN);
       pp(_estrarr.exp_1, 14);
       render("->");
       pp(_estrarr.exp_2, 15);
       if (_i_ > 14) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EIdx)
    {
       cpp.Absyn.EIdx _eidx = (cpp.Absyn.EIdx) foo;
       if (_i_ > 14) render(_L_PAREN);
       pp(_eidx.exp_1, 14);
       render("[");
       pp(_eidx.exp_2, 0);
       render("]");
       if (_i_ > 14) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EPIncr)
    {
       cpp.Absyn.EPIncr _epincr = (cpp.Absyn.EPIncr) foo;
       if (_i_ > 14) render(_L_PAREN);
       pp(_epincr.exp_, 14);
       render("++");
       if (_i_ > 14) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EPDecr)
    {
       cpp.Absyn.EPDecr _epdecr = (cpp.Absyn.EPDecr) foo;
       if (_i_ > 14) render(_L_PAREN);
       pp(_epdecr.exp_, 14);
       render("--");
       if (_i_ > 14) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EIncr)
    {
       cpp.Absyn.EIncr _eincr = (cpp.Absyn.EIncr) foo;
       if (_i_ > 13) render(_L_PAREN);
       render("++");
       pp(_eincr.exp_, 13);
       if (_i_ > 13) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EDecr)
    {
       cpp.Absyn.EDecr _edecr = (cpp.Absyn.EDecr) foo;
       if (_i_ > 13) render(_L_PAREN);
       render("--");
       pp(_edecr.exp_, 13);
       if (_i_ > 13) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ENeg)
    {
       cpp.Absyn.ENeg _eneg = (cpp.Absyn.ENeg) foo;
       if (_i_ > 13) render(_L_PAREN);
       render("!");
       pp(_eneg.exp_, 13);
       if (_i_ > 13) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EMul)
    {
       cpp.Absyn.EMul _emul = (cpp.Absyn.EMul) foo;
       if (_i_ > 13) render(_L_PAREN);
       render("*");
       pp(_emul.exp_, 13);
       if (_i_ > 13) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ETimes)
    {
       cpp.Absyn.ETimes _etimes = (cpp.Absyn.ETimes) foo;
       if (_i_ > 12) render(_L_PAREN);
       pp(_etimes.exp_1, 12);
       render("*");
       pp(_etimes.exp_2, 13);
       if (_i_ > 12) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EDiv)
    {
       cpp.Absyn.EDiv _ediv = (cpp.Absyn.EDiv) foo;
       if (_i_ > 12) render(_L_PAREN);
       pp(_ediv.exp_1, 12);
       render("/");
       pp(_ediv.exp_2, 13);
       if (_i_ > 12) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EMod)
    {
       cpp.Absyn.EMod _emod = (cpp.Absyn.EMod) foo;
       if (_i_ > 12) render(_L_PAREN);
       pp(_emod.exp_1, 12);
       render("%");
       pp(_emod.exp_2, 13);
       if (_i_ > 12) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EPlus)
    {
       cpp.Absyn.EPlus _eplus = (cpp.Absyn.EPlus) foo;
       if (_i_ > 11) render(_L_PAREN);
       pp(_eplus.exp_1, 11);
       render("+");
       pp(_eplus.exp_2, 12);
       if (_i_ > 11) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EMinus)
    {
       cpp.Absyn.EMinus _eminus = (cpp.Absyn.EMinus) foo;
       if (_i_ > 11) render(_L_PAREN);
       pp(_eminus.exp_1, 11);
       render("-");
       pp(_eminus.exp_2, 12);
       if (_i_ > 11) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ERS)
    {
       cpp.Absyn.ERS _ers = (cpp.Absyn.ERS) foo;
       if (_i_ > 10) render(_L_PAREN);
       pp(_ers.exp_1, 10);
       render(">>");
       pp(_ers.exp_2, 11);
       if (_i_ > 10) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ELS)
    {
       cpp.Absyn.ELS _els = (cpp.Absyn.ELS) foo;
       if (_i_ > 10) render(_L_PAREN);
       pp(_els.exp_1, 10);
       render("<<");
       pp(_els.exp_2, 11);
       if (_i_ > 10) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ELt)
    {
       cpp.Absyn.ELt _elt = (cpp.Absyn.ELt) foo;
       if (_i_ > 9) render(_L_PAREN);
       pp(_elt.exp_1, 9);
       render("<");
       pp(_elt.exp_2, 10);
       if (_i_ > 9) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EGt)
    {
       cpp.Absyn.EGt _egt = (cpp.Absyn.EGt) foo;
       if (_i_ > 9) render(_L_PAREN);
       pp(_egt.exp_1, 9);
       render(">");
       pp(_egt.exp_2, 10);
       if (_i_ > 9) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ELtEq)
    {
       cpp.Absyn.ELtEq _elteq = (cpp.Absyn.ELtEq) foo;
       if (_i_ > 9) render(_L_PAREN);
       pp(_elteq.exp_1, 9);
       render("<=");
       pp(_elteq.exp_2, 10);
       if (_i_ > 9) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EGtWq)
    {
       cpp.Absyn.EGtWq _egtwq = (cpp.Absyn.EGtWq) foo;
       if (_i_ > 9) render(_L_PAREN);
       pp(_egtwq.exp_1, 9);
       render(">=");
       pp(_egtwq.exp_2, 10);
       if (_i_ > 9) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EEq)
    {
       cpp.Absyn.EEq _eeq = (cpp.Absyn.EEq) foo;
       if (_i_ > 8) render(_L_PAREN);
       pp(_eeq.exp_1, 8);
       render("==");
       pp(_eeq.exp_2, 9);
       if (_i_ > 8) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ENEq)
    {
       cpp.Absyn.ENEq _eneq = (cpp.Absyn.ENEq) foo;
       if (_i_ > 8) render(_L_PAREN);
       pp(_eneq.exp_1, 8);
       render("!=");
       pp(_eneq.exp_2, 9);
       if (_i_ > 8) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EAnd)
    {
       cpp.Absyn.EAnd _eand = (cpp.Absyn.EAnd) foo;
       if (_i_ > 4) render(_L_PAREN);
       pp(_eand.exp_1, 4);
       render("&&");
       pp(_eand.exp_2, 5);
       if (_i_ > 4) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EOr)
    {
       cpp.Absyn.EOr _eor = (cpp.Absyn.EOr) foo;
       if (_i_ > 3) render(_L_PAREN);
       pp(_eor.exp_1, 3);
       render("||");
       pp(_eor.exp_2, 4);
       if (_i_ > 3) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EAss)
    {
       cpp.Absyn.EAss _eass = (cpp.Absyn.EAss) foo;
       if (_i_ > 2) render(_L_PAREN);
       pp(_eass.exp_1, 3);
       render("=");
       pp(_eass.exp_2, 2);
       if (_i_ > 2) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EAssAdd)
    {
       cpp.Absyn.EAssAdd _eassadd = (cpp.Absyn.EAssAdd) foo;
       if (_i_ > 2) render(_L_PAREN);
       pp(_eassadd.exp_1, 3);
       render("+=");
       pp(_eassadd.exp_2, 2);
       if (_i_ > 2) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EAssSub)
    {
       cpp.Absyn.EAssSub _easssub = (cpp.Absyn.EAssSub) foo;
       if (_i_ > 2) render(_L_PAREN);
       pp(_easssub.exp_1, 3);
       render("-=");
       pp(_easssub.exp_2, 2);
       if (_i_ > 2) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.ECond)
    {
       cpp.Absyn.ECond _econd = (cpp.Absyn.ECond) foo;
       if (_i_ > 2) render(_L_PAREN);
       pp(_econd.exp_1, 3);
       render("?");
       pp(_econd.exp_2, 2);
       render(":");
       pp(_econd.exp_3, 2);
       if (_i_ > 2) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.EThrow)
    {
       cpp.Absyn.EThrow _ethrow = (cpp.Absyn.EThrow) foo;
       if (_i_ > 1) render(_L_PAREN);
       render("throw");
       pp(_ethrow.exp_, 0);
       if (_i_ > 1) render(_R_PAREN);
    }
  }

  private static void pp(cpp.Absyn.ListExp foo, int _i_)
  {
     for (java.util.Iterator<Exp> it = foo.iterator(); it.hasNext();)
     {
       pp(it.next(), _i_);
       if (it.hasNext()) {
         render(",");
       } else {
         render("");
       }
     }  }

  private static void pp(cpp.Absyn.PType foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.Tbool)
    {
       cpp.Absyn.Tbool _tbool = (cpp.Absyn.Tbool) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("bool");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.Tdouble)
    {
       cpp.Absyn.Tdouble _tdouble = (cpp.Absyn.Tdouble) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("double");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.Tint)
    {
       cpp.Absyn.Tint _tint = (cpp.Absyn.Tint) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("int");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.Tvoid)
    {
       cpp.Absyn.Tvoid _tvoid = (cpp.Absyn.Tvoid) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("void");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.TChar)
    {
       cpp.Absyn.TChar _tchar = (cpp.Absyn.TChar) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("char");
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.TQCon)
    {
       cpp.Absyn.TQCon _tqcon = (cpp.Absyn.TQCon) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_tqcon.listid_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
  }

  private static void pp(cpp.Absyn.RType foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.TPType)
    {
       cpp.Absyn.TPType _tptype = (cpp.Absyn.TPType) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_tptype.ptype_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.TRef)
    {
       cpp.Absyn.TRef _tref = (cpp.Absyn.TRef) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_tref.rtype_, 0);
       render("&");
       if (_i_ > 0) render(_R_PAREN);
    }
  }

  private static void pp(cpp.Absyn.Type foo, int _i_)
  {
    if (foo instanceof cpp.Absyn.TRType)
    {
       cpp.Absyn.TRType _trtype = (cpp.Absyn.TRType) foo;
       if (_i_ > 0) render(_L_PAREN);
       pp(_trtype.rtype_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
    else     if (foo instanceof cpp.Absyn.TConst)
    {
       cpp.Absyn.TConst _tconst = (cpp.Absyn.TConst) foo;
       if (_i_ > 0) render(_L_PAREN);
       render("const");
       pp(_tconst.rtype_, 0);
       if (_i_ > 0) render(_R_PAREN);
    }
  }


  private static void sh(cpp.Absyn.Program foo)
  {
    if (foo instanceof cpp.Absyn.PDefs)
    {
       cpp.Absyn.PDefs _pdefs = (cpp.Absyn.PDefs) foo;
       render("(");
       render("PDefs");
       render("[");
       sh(_pdefs.listdef_);
       render("]");
       render(")");
    }
  }

  private static void sh(cpp.Absyn.ListDef foo)
  {
     for (java.util.Iterator<Def> it = foo.iterator(); it.hasNext();)
     {
       sh(it.next());
       if (it.hasNext())
         render(",");
     }
  }

  private static void sh(cpp.Absyn.Def foo)
  {
    if (foo instanceof cpp.Absyn.DFun)
    {
       cpp.Absyn.DFun _dfun = (cpp.Absyn.DFun) foo;
       render("(");
       render("DFun");
       sh(_dfun.type_);
       sh(_dfun.id_);
       render("[");
       sh(_dfun.listarg_);
       render("]");
       render("[");
       sh(_dfun.liststm_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.DFunBody)
    {
       cpp.Absyn.DFunBody _dfunbody = (cpp.Absyn.DFunBody) foo;
       render("(");
       render("DFunBody");
       sh(_dfunbody.type_);
       sh(_dfunbody.id_);
       render("[");
       sh(_dfunbody.listarg_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.DUsing)
    {
       cpp.Absyn.DUsing _dusing = (cpp.Absyn.DUsing) foo;
       render("(");
       render("DUsing");
       render("[");
       sh(_dusing.listid_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.DInit)
    {
       cpp.Absyn.DInit _dinit = (cpp.Absyn.DInit) foo;
       render("(");
       render("DInit");
       sh(_dinit.type_);
       render("[");
       sh(_dinit.listvar_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.DTD)
    {
       cpp.Absyn.DTD _dtd = (cpp.Absyn.DTD) foo;
       render("(");
       render("DTD");
       sh(_dtd.type_);
       sh(_dtd.id_);
       render(")");
    }
  }

  private static void sh(cpp.Absyn.ListArg foo)
  {
     for (java.util.Iterator<Arg> it = foo.iterator(); it.hasNext();)
     {
       sh(it.next());
       if (it.hasNext())
         render(",");
     }
  }

  private static void sh(cpp.Absyn.ListStm foo)
  {
     for (java.util.Iterator<Stm> it = foo.iterator(); it.hasNext();)
     {
       sh(it.next());
       if (it.hasNext())
         render(",");
     }
  }

  private static void sh(cpp.Absyn.ListId foo)
  {
     for (java.util.Iterator<String> it = foo.iterator(); it.hasNext();)
     {
       sh(it.next());
       if (it.hasNext())
         render(",");
     }
  }

  private static void sh(cpp.Absyn.Arg foo)
  {
    if (foo instanceof cpp.Absyn.ADecl)
    {
       cpp.Absyn.ADecl _adecl = (cpp.Absyn.ADecl) foo;
       render("(");
       render("ADecl");
       sh(_adecl.type_);
       sh(_adecl.var_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ADeclInit)
    {
       cpp.Absyn.ADeclInit _adeclinit = (cpp.Absyn.ADeclInit) foo;
       render("(");
       render("ADeclInit");
       sh(_adeclinit.type_);
       render(")");
    }
  }

  private static void sh(cpp.Absyn.Stm foo)
  {
    if (foo instanceof cpp.Absyn.SExp)
    {
       cpp.Absyn.SExp _sexp = (cpp.Absyn.SExp) foo;
       render("(");
       render("SExp");
       sh(_sexp.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.SInit)
    {
       cpp.Absyn.SInit _sinit = (cpp.Absyn.SInit) foo;
       render("(");
       render("SInit");
       sh(_sinit.type_);
       render("[");
       sh(_sinit.listvar_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.SReturn)
    {
       cpp.Absyn.SReturn _sreturn = (cpp.Absyn.SReturn) foo;
       render("(");
       render("SReturn");
       sh(_sreturn.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.SWhile)
    {
       cpp.Absyn.SWhile _swhile = (cpp.Absyn.SWhile) foo;
       render("(");
       render("SWhile");
       sh(_swhile.exp_);
       sh(_swhile.stm_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.SBlock)
    {
       cpp.Absyn.SBlock _sblock = (cpp.Absyn.SBlock) foo;
       render("(");
       render("SBlock");
       render("[");
       sh(_sblock.liststm_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.SIf)
    {
       cpp.Absyn.SIf _sif = (cpp.Absyn.SIf) foo;
       render("(");
       render("SIf");
       sh(_sif.exp_);
       sh(_sif.stm_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.SIfElse)
    {
       cpp.Absyn.SIfElse _sifelse = (cpp.Absyn.SIfElse) foo;
       render("(");
       render("SIfElse");
       sh(_sifelse.exp_);
       sh(_sifelse.stm_1);
       sh(_sifelse.stm_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.SFor)
    {
       cpp.Absyn.SFor _sfor = (cpp.Absyn.SFor) foo;
       render("(");
       render("SFor");
       sh(_sfor.type_);
       render("[");
       sh(_sfor.listvar_);
       render("]");
       sh(_sfor.exp_1);
       sh(_sfor.exp_2);
       sh(_sfor.stm_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.SDoWhile)
    {
       cpp.Absyn.SDoWhile _sdowhile = (cpp.Absyn.SDoWhile) foo;
       render("(");
       render("SDoWhile");
       sh(_sdowhile.stm_);
       sh(_sdowhile.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.STD)
    {
       cpp.Absyn.STD _std = (cpp.Absyn.STD) foo;
       render("(");
       render("STD");
       sh(_std.type_);
       sh(_std.id_);
       render(")");
    }
  }

  private static void sh(cpp.Absyn.ListString foo)
  {
     for (java.util.Iterator<String> it = foo.iterator(); it.hasNext();)
     {
       sh(it.next());
       if (it.hasNext())
         render(",");
     }
  }

  private static void sh(cpp.Absyn.ListVar foo)
  {
     for (java.util.Iterator<Var> it = foo.iterator(); it.hasNext();)
     {
       sh(it.next());
       if (it.hasNext())
         render(",");
     }
  }

  private static void sh(cpp.Absyn.Var foo)
  {
    if (foo instanceof cpp.Absyn.VarDecl)
    {
       cpp.Absyn.VarDecl _vardecl = (cpp.Absyn.VarDecl) foo;
       render("(");
       render("VarDecl");
       sh(_vardecl.id_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.VarInit)
    {
       cpp.Absyn.VarInit _varinit = (cpp.Absyn.VarInit) foo;
       render("(");
       render("VarInit");
       sh(_varinit.id_);
       sh(_varinit.exp_);
       render(")");
    }
  }

  private static void sh(cpp.Absyn.Exp foo)
  {
    if (foo instanceof cpp.Absyn.EInt)
    {
       cpp.Absyn.EInt _eint = (cpp.Absyn.EInt) foo;
       render("(");
       render("EInt");
       sh(_eint.integer_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EDouble)
    {
       cpp.Absyn.EDouble _edouble = (cpp.Absyn.EDouble) foo;
       render("(");
       render("EDouble");
       sh(_edouble.double_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EString)
    {
       cpp.Absyn.EString _estring = (cpp.Absyn.EString) foo;
       render("(");
       render("EString");
       render("[");
       sh(_estring.liststring_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.ETrue)
    {
       cpp.Absyn.ETrue _etrue = (cpp.Absyn.ETrue) foo;
       render("ETrue");
    }
    if (foo instanceof cpp.Absyn.EFalse)
    {
       cpp.Absyn.EFalse _efalse = (cpp.Absyn.EFalse) foo;
       render("EFalse");
    }
    if (foo instanceof cpp.Absyn.EApp)
    {
       cpp.Absyn.EApp _eapp = (cpp.Absyn.EApp) foo;
       render("(");
       render("EApp");
       sh(_eapp.exp_);
       render("[");
       sh(_eapp.listexp_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.EChar)
    {
       cpp.Absyn.EChar _echar = (cpp.Absyn.EChar) foo;
       render("(");
       render("EChar");
       sh(_echar.char_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EQCon)
    {
       cpp.Absyn.EQCon _eqcon = (cpp.Absyn.EQCon) foo;
       render("(");
       render("EQCon");
       render("[");
       sh(_eqcon.listid_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.ECall)
    {
       cpp.Absyn.ECall _ecall = (cpp.Absyn.ECall) foo;
       render("(");
       render("ECall");
       sh(_ecall.exp_);
       render("[");
       sh(_ecall.listexp_);
       render("]");
       render(")");
    }
    if (foo instanceof cpp.Absyn.EStrDot)
    {
       cpp.Absyn.EStrDot _estrdot = (cpp.Absyn.EStrDot) foo;
       render("(");
       render("EStrDot");
       sh(_estrdot.exp_1);
       sh(_estrdot.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EStrArr)
    {
       cpp.Absyn.EStrArr _estrarr = (cpp.Absyn.EStrArr) foo;
       render("(");
       render("EStrArr");
       sh(_estrarr.exp_1);
       sh(_estrarr.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EIdx)
    {
       cpp.Absyn.EIdx _eidx = (cpp.Absyn.EIdx) foo;
       render("(");
       render("EIdx");
       sh(_eidx.exp_1);
       sh(_eidx.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EPIncr)
    {
       cpp.Absyn.EPIncr _epincr = (cpp.Absyn.EPIncr) foo;
       render("(");
       render("EPIncr");
       sh(_epincr.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EPDecr)
    {
       cpp.Absyn.EPDecr _epdecr = (cpp.Absyn.EPDecr) foo;
       render("(");
       render("EPDecr");
       sh(_epdecr.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EIncr)
    {
       cpp.Absyn.EIncr _eincr = (cpp.Absyn.EIncr) foo;
       render("(");
       render("EIncr");
       sh(_eincr.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EDecr)
    {
       cpp.Absyn.EDecr _edecr = (cpp.Absyn.EDecr) foo;
       render("(");
       render("EDecr");
       sh(_edecr.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ENeg)
    {
       cpp.Absyn.ENeg _eneg = (cpp.Absyn.ENeg) foo;
       render("(");
       render("ENeg");
       sh(_eneg.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EMul)
    {
       cpp.Absyn.EMul _emul = (cpp.Absyn.EMul) foo;
       render("(");
       render("EMul");
       sh(_emul.exp_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ETimes)
    {
       cpp.Absyn.ETimes _etimes = (cpp.Absyn.ETimes) foo;
       render("(");
       render("ETimes");
       sh(_etimes.exp_1);
       sh(_etimes.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EDiv)
    {
       cpp.Absyn.EDiv _ediv = (cpp.Absyn.EDiv) foo;
       render("(");
       render("EDiv");
       sh(_ediv.exp_1);
       sh(_ediv.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EMod)
    {
       cpp.Absyn.EMod _emod = (cpp.Absyn.EMod) foo;
       render("(");
       render("EMod");
       sh(_emod.exp_1);
       sh(_emod.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EPlus)
    {
       cpp.Absyn.EPlus _eplus = (cpp.Absyn.EPlus) foo;
       render("(");
       render("EPlus");
       sh(_eplus.exp_1);
       sh(_eplus.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EMinus)
    {
       cpp.Absyn.EMinus _eminus = (cpp.Absyn.EMinus) foo;
       render("(");
       render("EMinus");
       sh(_eminus.exp_1);
       sh(_eminus.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ERS)
    {
       cpp.Absyn.ERS _ers = (cpp.Absyn.ERS) foo;
       render("(");
       render("ERS");
       sh(_ers.exp_1);
       sh(_ers.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ELS)
    {
       cpp.Absyn.ELS _els = (cpp.Absyn.ELS) foo;
       render("(");
       render("ELS");
       sh(_els.exp_1);
       sh(_els.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ELt)
    {
       cpp.Absyn.ELt _elt = (cpp.Absyn.ELt) foo;
       render("(");
       render("ELt");
       sh(_elt.exp_1);
       sh(_elt.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EGt)
    {
       cpp.Absyn.EGt _egt = (cpp.Absyn.EGt) foo;
       render("(");
       render("EGt");
       sh(_egt.exp_1);
       sh(_egt.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ELtEq)
    {
       cpp.Absyn.ELtEq _elteq = (cpp.Absyn.ELtEq) foo;
       render("(");
       render("ELtEq");
       sh(_elteq.exp_1);
       sh(_elteq.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EGtWq)
    {
       cpp.Absyn.EGtWq _egtwq = (cpp.Absyn.EGtWq) foo;
       render("(");
       render("EGtWq");
       sh(_egtwq.exp_1);
       sh(_egtwq.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EEq)
    {
       cpp.Absyn.EEq _eeq = (cpp.Absyn.EEq) foo;
       render("(");
       render("EEq");
       sh(_eeq.exp_1);
       sh(_eeq.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ENEq)
    {
       cpp.Absyn.ENEq _eneq = (cpp.Absyn.ENEq) foo;
       render("(");
       render("ENEq");
       sh(_eneq.exp_1);
       sh(_eneq.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EAnd)
    {
       cpp.Absyn.EAnd _eand = (cpp.Absyn.EAnd) foo;
       render("(");
       render("EAnd");
       sh(_eand.exp_1);
       sh(_eand.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EOr)
    {
       cpp.Absyn.EOr _eor = (cpp.Absyn.EOr) foo;
       render("(");
       render("EOr");
       sh(_eor.exp_1);
       sh(_eor.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EAss)
    {
       cpp.Absyn.EAss _eass = (cpp.Absyn.EAss) foo;
       render("(");
       render("EAss");
       sh(_eass.exp_1);
       sh(_eass.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EAssAdd)
    {
       cpp.Absyn.EAssAdd _eassadd = (cpp.Absyn.EAssAdd) foo;
       render("(");
       render("EAssAdd");
       sh(_eassadd.exp_1);
       sh(_eassadd.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EAssSub)
    {
       cpp.Absyn.EAssSub _easssub = (cpp.Absyn.EAssSub) foo;
       render("(");
       render("EAssSub");
       sh(_easssub.exp_1);
       sh(_easssub.exp_2);
       render(")");
    }
    if (foo instanceof cpp.Absyn.ECond)
    {
       cpp.Absyn.ECond _econd = (cpp.Absyn.ECond) foo;
       render("(");
       render("ECond");
       sh(_econd.exp_1);
       sh(_econd.exp_2);
       sh(_econd.exp_3);
       render(")");
    }
    if (foo instanceof cpp.Absyn.EThrow)
    {
       cpp.Absyn.EThrow _ethrow = (cpp.Absyn.EThrow) foo;
       render("(");
       render("EThrow");
       sh(_ethrow.exp_);
       render(")");
    }
  }

  private static void sh(cpp.Absyn.ListExp foo)
  {
     for (java.util.Iterator<Exp> it = foo.iterator(); it.hasNext();)
     {
       sh(it.next());
       if (it.hasNext())
         render(",");
     }
  }

  private static void sh(cpp.Absyn.PType foo)
  {
    if (foo instanceof cpp.Absyn.Tbool)
    {
       cpp.Absyn.Tbool _tbool = (cpp.Absyn.Tbool) foo;
       render("Tbool");
    }
    if (foo instanceof cpp.Absyn.Tdouble)
    {
       cpp.Absyn.Tdouble _tdouble = (cpp.Absyn.Tdouble) foo;
       render("Tdouble");
    }
    if (foo instanceof cpp.Absyn.Tint)
    {
       cpp.Absyn.Tint _tint = (cpp.Absyn.Tint) foo;
       render("Tint");
    }
    if (foo instanceof cpp.Absyn.Tvoid)
    {
       cpp.Absyn.Tvoid _tvoid = (cpp.Absyn.Tvoid) foo;
       render("Tvoid");
    }
    if (foo instanceof cpp.Absyn.TChar)
    {
       cpp.Absyn.TChar _tchar = (cpp.Absyn.TChar) foo;
       render("TChar");
    }
    if (foo instanceof cpp.Absyn.TQCon)
    {
       cpp.Absyn.TQCon _tqcon = (cpp.Absyn.TQCon) foo;
       render("(");
       render("TQCon");
       render("[");
       sh(_tqcon.listid_);
       render("]");
       render(")");
    }
  }

  private static void sh(cpp.Absyn.RType foo)
  {
    if (foo instanceof cpp.Absyn.TPType)
    {
       cpp.Absyn.TPType _tptype = (cpp.Absyn.TPType) foo;
       render("(");
       render("TPType");
       sh(_tptype.ptype_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.TRef)
    {
       cpp.Absyn.TRef _tref = (cpp.Absyn.TRef) foo;
       render("(");
       render("TRef");
       sh(_tref.rtype_);
       render(")");
    }
  }

  private static void sh(cpp.Absyn.Type foo)
  {
    if (foo instanceof cpp.Absyn.TRType)
    {
       cpp.Absyn.TRType _trtype = (cpp.Absyn.TRType) foo;
       render("(");
       render("TRType");
       sh(_trtype.rtype_);
       render(")");
    }
    if (foo instanceof cpp.Absyn.TConst)
    {
       cpp.Absyn.TConst _tconst = (cpp.Absyn.TConst) foo;
       render("(");
       render("TConst");
       sh(_tconst.rtype_);
       render(")");
    }
  }


  private static void pp(Integer n, int _i_) { buf_.append(n); buf_.append(" "); }
  private static void pp(Double d, int _i_) { buf_.append(d); buf_.append(" "); }
  private static void pp(String s, int _i_) { buf_.append(s); buf_.append(" "); }
  private static void pp(Character c, int _i_) { buf_.append("'" + c.toString() + "'"); buf_.append(" "); }
  private static void sh(Integer n) { render(n.toString()); }
  private static void sh(Double d) { render(d.toString()); }
  private static void sh(Character c) { render(c.toString()); }
  private static void sh(String s) { printQuoted(s); }
  private static void printQuoted(String s) { render("\"" + s + "\""); }
  private static void indent()
  {
    int n = _n_;
    while (n > 0)
    {
      buf_.append(" ");
      n--;
    }
  }
  private static void backup()
  {
     if (buf_.charAt(buf_.length() - 1) == ' ') {
      buf_.setLength(buf_.length() - 1);
    }
  }
  private static void trim()
  {
     while (buf_.length() > 0 && buf_.charAt(0) == ' ')
        buf_.deleteCharAt(0); 
    while (buf_.length() > 0 && buf_.charAt(buf_.length()-1) == ' ')
        buf_.deleteCharAt(buf_.length()-1);
  }
  private static int _n_ = 0;
  private static StringBuilder buf_ = new StringBuilder(INITIAL_BUFFER_SIZE);
}

