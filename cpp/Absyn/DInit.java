package cpp.Absyn; // Java Package generated by the BNF Converter.

public class DInit extends Def {
  public final Type type_;
  public final ListVar listvar_;
  public DInit(Type p1, ListVar p2) { type_ = p1; listvar_ = p2; }

  public <R,A> R accept(cpp.Absyn.Def.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.DInit) {
      cpp.Absyn.DInit x = (cpp.Absyn.DInit)o;
      return this.type_.equals(x.type_) && this.listvar_.equals(x.listvar_);
    }
    return false;
  }

  public int hashCode() {
    return 37*(this.type_.hashCode())+this.listvar_.hashCode();
  }


}
