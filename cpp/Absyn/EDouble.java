package cpp.Absyn; // Java Package generated by the BNF Converter.

public class EDouble extends Exp {
  public final Double double_;
  public EDouble(Double p1) { double_ = p1; }

  public <R,A> R accept(cpp.Absyn.Exp.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.EDouble) {
      cpp.Absyn.EDouble x = (cpp.Absyn.EDouble)o;
      return this.double_.equals(x.double_);
    }
    return false;
  }

  public int hashCode() {
    return this.double_.hashCode();
  }


}
