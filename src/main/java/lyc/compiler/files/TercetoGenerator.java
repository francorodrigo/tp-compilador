package lyc.compiler.files;

import java.io.Serializable;
import java.util.*;

public class TercetoGenerator {
    public static final Map<String, String> operadores = Map.of(
            ">=", "BLT",
            ">", "BLE",
            "<=", "BGT",
            "<", "BGE",
            "<>", "BEQ",
            "==", "BNE"
    );
    public static Stack<Terceto> pilaTercetos = new Stack<Terceto>();
    public static Stack<Integer> pilaIndices = new Stack<Integer>();
    public static Stack<String> pilaOperadores = new Stack<String>();
    public static List<Terceto> tercetos = new LinkedList<Terceto>();
    public static Map<String, Integer> indices = new HashMap<String, Integer>();
    /*
    "ExpressionIndex" -> 2
    2 -> Terceto [a,b,c]
    * */
    private static TercetoGenerator instance;

    public static TercetoGenerator getInstance() {
        if (instance == null) {
            instance = new TercetoGenerator();
        }
        return instance;
    }
    public int crearYAsignarTerceto(Object o1, Object o2, Object o3, String elementoNoTerminal) {
        System.out.println(elementoNoTerminal + " -> " + o1.toString() + "," + o2.toString() + "," + o3.toString());
        Terceto t = new Terceto(o1,o2,o3);
        tercetos.add(t);
        indices.put(elementoNoTerminal, tercetos.size()-1);
        return tercetos.size()-1;
    }
    public int crearYAsignarTerceto(Object o1, String elementoNoTerminal) {
        System.out.println(elementoNoTerminal + " -> " + o1.toString());
        Terceto t = new Terceto(o1, "_", "_");
        tercetos.add(t);
        indices.put(elementoNoTerminal, tercetos.size()-1);
        System.out.println("VALUE DEL MAPA :" + indices.get(elementoNoTerminal).toString());
        return tercetos.size()-1;
    }
    public int crearTerceto(Object o1, Object o2, Object o3) {
        Terceto t = new Terceto(o1,o2,o3);
        tercetos.add(t);
        return tercetos.size()-1;
    }
    //term ::= factor asignarTerceto("TermIndex", "FactorIndex")
    public void asignarTerceto(String ind1, String ind2) {
        indices.put(ind1,indices.get(ind2));
        System.out.println(ind1 + "->" + ind2 + " Valor mapa " + indices.get(ind1));
    }

    public void apilarTerceto(String elementoNoTerminal) {
        pilaTercetos.push(tercetos.get(indices.get(elementoNoTerminal)));
    }

    public void apilarIndiceDeTerceto(String elementoNoTerminal) {
        pilaIndices.push(indices.get(elementoNoTerminal));
    }

    public Object obtenerTercetoDelENT(String elementoNoTerminal) {
        Integer index = indices.get(elementoNoTerminal);
        if (index != null) {
            //return tercetos.get(index);
            return "["+ index + "]";
        }
        return null;
    }
}