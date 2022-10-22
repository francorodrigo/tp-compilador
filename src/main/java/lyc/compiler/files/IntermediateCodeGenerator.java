package lyc.compiler.files;

import javax.lang.model.type.NullType;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class IntermediateCodeGenerator implements FileGenerator {

    public class Terceto<A,B,C> {
        private A primerElemento;
        private B segundoElemento;
        private C tercerElemento;

        public Terceto(A primero, B segundo, C tercero) {
            this.primerElemento = primero;
            this.segundoElemento = segundo;
            this.tercerElemento = tercero;
        }
        public Terceto(A primero) {
            this.primerElemento = primero;
        }
        //[ primero, segundo, tercero]
        @Override
        public String toString() {
            String primerElemn = primerElemento == null ? "_" : primerElemento.toString();
            String segundoElemn = segundoElemento == null ? "_" : segundoElemento.toString();
            String tercerElemn = tercerElemento == null ? "_" : tercerElemento.toString();
            return "\n["+primerElemn+","
                    + segundoElemn+","
                    + tercerElemn+"]"+"\n";
        }
    }
    public static Stack<Terceto> pilaTercetos = new Stack<Terceto>();
    public static List<Terceto> tercetos = new LinkedList<Terceto>();
    public static Map<String, Terceto> indices = new HashMap<String, Terceto>();
    private static IntermediateCodeGenerator instance;
    public static IntermediateCodeGenerator getInstance() {
        if (instance == null) {
            instance = new IntermediateCodeGenerator();
        }
        return instance;
    }
    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        System.out.println("SOY EL MAPA: " + indices.toString());
        for (Map.Entry<String, Terceto> entry: indices.entrySet()) {
            try {
                fileWriter.write(entry.getValue().toString());
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        fileWriter.write("TODO");
    }
    public void crearYAsignarTerceto(Object o1, Object o2, Object o3, String elementoNoTerminal) {
        System.out.println(elementoNoTerminal + " -> " + o1.toString() + "," + o2.toString() + "," + o3.toString());
        Terceto t = new Terceto<Object, Object, Object>(o1,o2,o3);
        indices.put(elementoNoTerminal, t);
    }
    public void crearYAsignarTerceto(Object o1, String elementoNoTerminal) {
        System.out.println(elementoNoTerminal + " -> " + o1.toString());
        Terceto t = new Terceto<Object, String, String>(o1, "_", "_");
        indices.put(elementoNoTerminal, t);
        System.out.println("VALUE DEL MAPA :" + indices.get(elementoNoTerminal).toString());
    }
    //term ::= factor asignarTerceto("TermIndex", "FactorIndex")
    public void asignarTerceto(String ind1, String ind2) {
        indices.put(ind1,indices.get(ind2));
        System.out.println(ind1 + "->" + ind2 + " Valor mapa" + indices.get(ind1));
    }
}
/*
a = 2;
b = 3;

[=, a , 2] -> 0x100b

Aind -> 0x100b
Lind -> Ain
[=, b, 3] -> 0x200b

Aind -> 0x200b
* */