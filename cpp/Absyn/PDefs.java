package cpp.Absyn; // Java Package generated by the BNF Converter.

public class PDefs extends Program {
  public final ListDef listdef_;
  public PDefs(ListDef p1) { listdef_ = p1; }

  public <R,A> R accept(cpp.Absyn.Program.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.PDefs) {
      cpp.Absyn.PDefs x = (cpp.Absyn.PDefs)o;
      return this.listdef_.equals(x.listdef_);
    }
    return false;
  }

  public int hashCode() {
    return this.listdef_.hashCode();
  }


}
