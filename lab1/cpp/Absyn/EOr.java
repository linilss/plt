package cpp.Absyn; // Java Package generated by the BNF Converter.

public class EOr extends Exp {
  public final Exp exp_1, exp_2;
  public EOr(Exp p1, Exp p2) { exp_1 = p1; exp_2 = p2; }

  public <R,A> R accept(cpp.Absyn.Exp.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.EOr) {
      cpp.Absyn.EOr x = (cpp.Absyn.EOr)o;
      return this.exp_1.equals(x.exp_1) && this.exp_2.equals(x.exp_2);
    }
    return false;
  }

  public int hashCode() {
    return 37*(this.exp_1.hashCode())+this.exp_2.hashCode();
  }


}
