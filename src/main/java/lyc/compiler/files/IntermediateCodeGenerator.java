package lyc.compiler.files;

import javax.lang.model.type.NullType;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class IntermediateCodeGenerator implements FileGenerator {
    private List<Terceto> tercetosFinal = new ArrayList<Terceto>(TercetoGenerator.tercetos.size()*2);
    private Map<Integer,List<Terceto>> pendientesDeOffset = new HashMap<Integer,List<Terceto>>();
    private int variablesAgregadas = 0;
    private int indiceDeTercetoActual = 0;
    private Set<String> saltos = Set.of(
            "BLT",
            "BLE",
            "BGT",
            "BGE",
            "BEQ",
            "BNE",
            "BI"
    );
    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        fileWriter.write("_______LISTA ORIGINAL___________\n");
        int x = 0;
        for (Terceto t: TercetoGenerator.tercetos) {
            fileWriter.write(x + ": " + t.toString());
            x++;
        }
        fileWriter.write("_______LISTA OPTIMIZADA___________\n");
        this.crearListaFinalDeTercetos();
        x = 0;
        for (Terceto t: this.tercetosFinal) {
            try {
                fileWriter.write(x + ": " + t.toString());
                x++;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        fileWriter.write("TODO");
    }
    /**
     * Sea en lista de tercetos:
     * 5: ["PEPE",_,_]
     * 6: [=,p1,[5]]
     * En lugar de [5] tenemos que lograr poner en lista final de tercetos
     * 5: ["PEPE",_,_]
     * 6: [=,@Aux5,"PEPE"]
     * 7: [=,p,@Aux5]
     *
     * Sea en lista de tercetos:
     * 12: [e,_,_]
     * 13: [21,_,_]
     * 14: [-,[12],[13]]
     * En lugar de [12] y [13] tenemos que lograr poner en lista final de tercetos
     * 12: [e,_,_]
     * 13: [21,_,_]
     * 14: [=,@Aux14,e]
     * 15: [=,@Aux15,21]
     * 16: [-,@Aux14,@Aux15]
     *
     * Sea en lista de tercetos:
     * 13: [21,_,_]
     * 14: [-,@Aux14,@Aux15]
     * 15: [*,[13],[14]]
     * En lugar de [13] y [14] tenemos que lograr poner en lista final de tercetos
     * 13: [21,_,_]
     * 14: [-,@Aux14,@Aux15]
     * 15: [=,@Aux15,21]
     * 16: [=,@Aux16,@Aux14]
     * 17: [*,@Aux16,@Aux15]
     *
     * En general:
     * Sea cualquier referencia [N] a un terceto generado tenemos que
     *  Si el primer elemento del terceto NO es un operador => Creamos el terceto [=,@AuxI,t.PrimerElemento] y reemplazamos el [N] por @AuxI
     *  Si el primer elemento del terceto SÍ es un operador => Creamos el terceto [=,@AuxI,t.SegundoElemento] y reemplazamos el [N] por @AuxI
     *   donde I es el índice ACTUAL.
     *
     */
    private Object obtenerTercetoEnVarAuxiliar(Terceto t, boolean esOperacionNoDestructiva) {
        if(this.esDeclaracionConstante(t)) {
            //Es una declaracion de una constante [123,_,_] o ["string",_,_]. Las variables son _123 o _string
            return "_" + t.primerElemento.toString().replace("\"","");
        }

        Terceto tAux = new Terceto("=");
        String nombreVarAux = "@Aux" + this.tercetosFinal.size();
        tAux.segundoElemento = nombreVarAux;

        if(this.esOperacion(t)) {
            //Es una operacion [+,algo,otracosa]
            tAux.tercerElemento = t.segundoElemento.toString();
        } else {
            //Es la declaracion de una var [a,_,_].
            if(esOperacionNoDestructiva) {
                /*
                * Si es una comparacion, no es necesario meter la variable en una variable auxiliar, puesto que la operacion no modifica el valor del elemento.
                * Ej:
                * [a,_,_] 1
                * [b,_,_] 2
                * [CMP, [1], [2]] 3
                * En este caso no es necesario hacer [=,@Aux1,a] ni [=,@Aux2,b] porque CMP no pisa el valor de los operandos.
                *  por lo que se puede reducir a [CMP,a,b]
                * */
                return t.primerElemento;
            }
            tAux.tercerElemento = t.primerElemento.toString();
        }
        System.out.println("Aniadiendo: " + tAux);
        this.tercetosFinal.add(tAux);
        this.variablesAgregadas++;
        return nombreVarAux;
    }

    /**
     * Sea la entrada "[1]" devuelve el terceto en la posición 1 de la lista
     */
    private Terceto obtenerTercetoDesdeReferenciaEnTerceto(Object refEnTerceto) {
        int indiceDeTercetoEnLista = Integer.parseInt(""+ obtenerIdDeRefDeTerceto(refEnTerceto));
        return TercetoGenerator.tercetos.get(indiceDeTercetoEnLista);
    }

    private Object obtenerIdDeRefDeTerceto(Object refEnTerceto) {
        return refEnTerceto.toString().substring(1, refEnTerceto.toString().length() - 1);
    }

    /**
     * Sea el terceto [+,[X],[Y]] transforma el terceto original a [+,@AuxI,@AuxJ]
     * donde @AuxI contiene el resultado del terceto [X] y @AuxJ el del [Y]
     * Si el terceto de entrada es una operacion no destructiva no se usan variables auxiliares intermedias  (ej: [CMP,[1],[2]] -> [CMP,a,b])
     * Si el terceto de entrada es un salto, se guarda el salto para recalcular su offset luego de la optimizacion.
     */
    private Terceto desreferenciarTerceto(Terceto t) {
        if(this.esSalto(t)) {
            //Los saltos son a lineas las cuales solo requieren ser offseteadas luego de la optimizacion.
            return t;
        }
        if(t.segundoElemento.toString().charAt(0) == '[') {
            t.segundoElemento = this.obtenerTercetoEnVarAuxiliar(this.obtenerTercetoDesdeReferenciaEnTerceto(t.segundoElemento), this.esOperacionNoDestructiva(t));
        }
        if(t.tercerElemento.toString().charAt(0) == '[') {
            t.tercerElemento = this.obtenerTercetoEnVarAuxiliar(this.obtenerTercetoDesdeReferenciaEnTerceto(t.tercerElemento), this.esOperacionNoDestructiva(t));
        }
        if(t.segundoElemento.toString().charAt(0) == '_' && t.tercerElemento.toString().charAt(0) == '_') {
            //Al desreferenciar, quedaron suma de constantes. Hay que agregar un terceto auxiliar con el resultado de la suma
            String nombreVarAux = "@Aux" + this.tercetosFinal.size();
            String nombreVarRes = "@Aux" + ( this.tercetosFinal.size() + 2 );
            //Si tenemos [+,_2,_3] -> [=,@aux1,_2]; [+,@aux1,3]; [=,@auxres,@aux1]
            Terceto tAux = new Terceto("=",nombreVarAux,t.segundoElemento);
            Terceto tAux2 = new Terceto(t.primerElemento,nombreVarAux,t.tercerElemento);
            //Terceto tAuxRes = new Terceto("=",nombreVarRes,nombreVarAux);
            t.primerElemento = "=";
            t.segundoElemento = nombreVarRes;
            t.tercerElemento = nombreVarAux;
            this.variablesAgregadas+=2;
            this.tercetosFinal.add(tAux);
            this.tercetosFinal.add(tAux2);
        }
        return t;
    }


    private void crearListaFinalDeTercetos() {
        this.llenarListaDeSaltos();
        for (Terceto t: TercetoGenerator.tercetos) {
            System.out.println("Procesando terceto: " + indiceDeTercetoActual + ". " + t);
            this.recalcularSaltosSiEsNecesario();
            if(!this.esOperacion(t)) {
                //Los tercetos del tipo ["algunvalor",_,_] no se escriben, no aportan info al programa final
                //Solo se usan para las desreferencias.
                System.out.println("Optimizacion! Se elimina terceto: " + t);
                this.variablesAgregadas--;
            } else {
                Terceto t2 = this.desreferenciarTerceto(t);
                this.tercetosFinal.add(t2);
            }
            this.indiceDeTercetoActual++;
        }
        int finalDelCodigo = this.indiceDeTercetoActual + this.variablesAgregadas;
        //Los saltos que no se pudieron resolver es porque saltaban al final del programa.
        for(List<Terceto> saltos : this.pendientesDeOffset.values()) {
            for(Terceto t : saltos) {
                t.segundoElemento = "[" + finalDelCodigo + "]";
            }
        }
        if(this.variablesAgregadas < 0)
            System.out.println("Se lograron eliminar " + Math.abs(this.variablesAgregadas) + " tercetos! yaay");
    }



    /**
     * Todos los saltos se tienen que recalcular debido a que eliminamos ciertos tercetos innecesarios, como [a,_,_]
     * Podemos tener varios saltos distintos a la misma linea (do-case con mas de 1 case) por lo que la estructura
     *  a recorrer es un mapa de NumeroDeTerceto->TercetosQueSaltanAEsteNumeroDeTerceto.
     * Si ya procesamos NumeroDeTerceto entonces ya sabemos que no se van a agregar ni quitar tercetos, por lo que
     *  podemos recorrer todos los Tercetos que tengan saltos a dicho numero y offsetearlos.
     *
     */
    private void recalcularSaltosSiEsNecesario() {
        if(this.pendientesDeOffset.containsKey(this.indiceDeTercetoActual)) {
            List<Terceto> saltos = this.pendientesDeOffset.get(this.indiceDeTercetoActual);
            int idOffseteado = this.indiceDeTercetoActual + this.variablesAgregadas;
            System.out.println("Se recalculan los saltos de: " + this.indiceDeTercetoActual + " -> " + idOffseteado);
            for(Terceto t : saltos) {
                t.segundoElemento = "[" + idOffseteado + "]";
            }
            this.pendientesDeOffset.remove(this.indiceDeTercetoActual);
        }
    }

    private void llenarListaDeSaltos() {
        for(Terceto t : TercetoGenerator.tercetos) {
            if(this.esSalto(t)){
                int idDeSalto = Integer.parseInt(this.obtenerIdDeRefDeTerceto(t.segundoElemento).toString());
                if(!this.pendientesDeOffset.containsKey(idDeSalto)) {
                    this.pendientesDeOffset.put(idDeSalto,new LinkedList<Terceto>());
                }
                this.pendientesDeOffset.get(idDeSalto).add(t);
            }
        }
    }

    private boolean esOperacion(Terceto t) {
        return t.primerElemento.toString().equals("+")
                || t.primerElemento.toString().equals("-")
                || t.primerElemento.toString().equals("*")
                || t.primerElemento.toString().equals("/")
                || t.primerElemento.toString().equals("=")
                || t.primerElemento.toString().equals("CMP")
                || this.esSalto(t)
                || t.primerElemento.toString().equals("WRITE")
                || t.primerElemento.toString().equals("READ");
    }

    private boolean esSalto(Terceto t) {
        return this.saltos.contains(t.primerElemento.toString());
    }

    private boolean esDeclaracionConstante(Terceto t) {
        return t.primerElemento.toString().charAt(0) == '"'
                || t.primerElemento.toString().charAt(0) == '0'
                || t.primerElemento.toString().charAt(0) == '1'
                || t.primerElemento.toString().charAt(0) == '2'
                || t.primerElemento.toString().charAt(0) == '3'
                || t.primerElemento.toString().charAt(0) == '4'
                || t.primerElemento.toString().charAt(0) == '5'
                || t.primerElemento.toString().charAt(0) == '6'
                || t.primerElemento.toString().charAt(0) == '7'
                || t.primerElemento.toString().charAt(0) == '8'
                || t.primerElemento.toString().charAt(0) == '9'
                || t.primerElemento.toString().charAt(0) == '.';

    }

    private boolean esOperacionNoDestructiva(Terceto t) {
        return t.primerElemento.toString().equals("CMP")
                ||t.primerElemento.toString().equals("WRITE"); //Operaciones que no modifican el segundo elemento.
    }

}