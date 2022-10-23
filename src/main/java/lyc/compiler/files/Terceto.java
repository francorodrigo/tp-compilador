package lyc.compiler.files;

import java.io.Serializable;

public class Terceto implements Serializable {
    public Object primerElemento;
    public Object segundoElemento;
    public Object tercerElemento;

    public Terceto(Object primero, Object segundo, Object tercero) {
        this.primerElemento = primero;
        this.segundoElemento = segundo;
        this.tercerElemento = tercero;
    }

    @Override
    public String toString() {
        String primerElemn = primerElemento == null ? "_" : primerElemento.toString();
        String segundoElemn = segundoElemento == null ? "_" : segundoElemento.toString();
        String tercerElemn = tercerElemento == null ? "_" : tercerElemento.toString();
        return "["+primerElemn+","
                + segundoElemn+","
                + tercerElemn+"]"+"\n";
    }
}
