package cpp.Absyn; // Java Package generated by the BNF Converter.

public class Tbool extends PType {
  public Tbool() { }

  public <R,A> R accept(cpp.Absyn.PType.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.Tbool) {
      return true;
    }
    return false;
  }

  public int hashCode() {
    return 37;
  }


}
