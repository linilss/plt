package cpp.Absyn; // Java Package generated by the BNF Converter.

public class VarInit extends Var {
  public final String id_;
  public final Exp exp_;
  public VarInit(String p1, Exp p2) { id_ = p1; exp_ = p2; }

  public <R,A> R accept(cpp.Absyn.Var.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.VarInit) {
      cpp.Absyn.VarInit x = (cpp.Absyn.VarInit)o;
      return this.id_.equals(x.id_) && this.exp_.equals(x.exp_);
    }
    return false;
  }

  public int hashCode() {
    return 37*(this.id_.hashCode())+this.exp_.hashCode();
  }


}
