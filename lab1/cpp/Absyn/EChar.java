package cpp.Absyn; // Java Package generated by the BNF Converter.

public class EChar extends Exp {
  public final Character char_;
  public EChar(Character p1) { char_ = p1; }

  public <R,A> R accept(cpp.Absyn.Exp.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.EChar) {
      cpp.Absyn.EChar x = (cpp.Absyn.EChar)o;
      return this.char_.equals(x.char_);
    }
    return false;
  }

  public int hashCode() {
    return this.char_.hashCode();
  }


}
