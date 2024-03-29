package cpp.Absyn; // Java Package generated by the BNF Converter.

public class VarDecl extends Var {
  public final String id_;
  public VarDecl(String p1) { id_ = p1; }

  public <R,A> R accept(cpp.Absyn.Var.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.VarDecl) {
      cpp.Absyn.VarDecl x = (cpp.Absyn.VarDecl)o;
      return this.id_.equals(x.id_);
    }
    return false;
  }

  public int hashCode() {
    return this.id_.hashCode();
  }


}
