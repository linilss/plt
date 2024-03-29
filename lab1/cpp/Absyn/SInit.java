package cpp.Absyn; // Java Package generated by the BNF Converter.

public class SInit extends Stm {
  public final Type type_;
  public final ListVar listvar_;
  public SInit(Type p1, ListVar p2) { type_ = p1; listvar_ = p2; }

  public <R,A> R accept(cpp.Absyn.Stm.Visitor<R,A> v, A arg) { return v.visit(this, arg); }

  public boolean equals(Object o) {
    if (this == o) return true;
    if (o instanceof cpp.Absyn.SInit) {
      cpp.Absyn.SInit x = (cpp.Absyn.SInit)o;
      return this.type_.equals(x.type_) && this.listvar_.equals(x.listvar_);
    }
    return false;
  }

  public int hashCode() {
    return 37*(this.type_.hashCode())+this.listvar_.hashCode();
  }


}
