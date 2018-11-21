package cpp.Absyn; // Java Package generated by the BNF Converter.

public class TQCon extends PType {
  public final ListId listid_;
  public TQCon(ListId p1) { listid_ = p1; }

  public <R,A> R accept(cpp.Absyn.PType.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.TQCon) {
      cpp.Absyn.TQCon x = (cpp.Absyn.TQCon)o;
      return this.listid_.equals(x.listid_);
    }
    return false;
  }

  public int hashCode() {
    return this.listid_.hashCode();
  }


}
