package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class AsmCodeGenerator implements FileGenerator {
    //Aca se va a escribir todo el código asm que luego se volcará en generate()
    public static List<String> buffer = new LinkedList<String>();
    //Relaciona un id de un terceto objetivo de un salto con un tag en asm
    /*
        Ej: [BLT, [1], _] 0
            [+,1,2] 1
        El mapa contendria
        [
            1 -> "tag_aux1"
        ]
        Para que el asm quede
        JB tag_aux1
    */
    private Map<Integer,String> idTercetoATag = new HashMap<Integer, String>();
    private static Map<String,String> saltos = Map.of(
            "BLT", "JB",
            "BLE", "JNA",
            "BGT", "JA",
            "BGE", "JAE",
            "BEQ", "JE",
            "BNE", "JNE",
            "BI", "JI"
    );
    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        for(String str: buffer) {
            fileWriter.write(str + "\n");
        }
        fileWriter.write("TODO");
    }

    public void generarAsm() {
        new IntermediateCodeGenerator().crearListaFinalDeTercetos();
        this.escribirTablaDeVariables();
        this.tagearSaltos();
        this.escribirHeader();
        for(Terceto t: IntermediateCodeGenerator.tercetosFinal) {
            this.convertirTerceto(t);
        }
        this.escribirFooter();
    }

    private void tagearSaltos() {
        for(Terceto t: IntermediateCodeGenerator.tercetosFinal) {
            String op = t.primerElemento.toString();
            if(saltos.containsKey(op)) {
                String tercetoObj = t.segundoElemento.toString();
                String idTerceto = tercetoObj.substring(1,tercetoObj.length()-1);
                Integer id = Integer.valueOf(idTerceto);
                this.idTercetoATag.put(id,"tag_aux" + id);
            }
        }
    }

    private void convertirTerceto(Terceto t) {
        String operador = t.primerElemento.toString();
        switch (operador){
            case "=":
                this.convertirTercetoDeAsignacion(t);
                break;
            case "+":
                this.convertirTercetoDeSuma(t);
                break;
            case "-":
                this.convertirTercetoDeResta(t);
                break;
            case "*":
                this.convertirTercetoDeMultiplicacion(t);
                break;
            case "/":
                this.convertirTercetoDeDivision(t);
                break;
            case "CMP":
                this.convertirTercetoDeComparacion(t);
                break;
            case "BLT":
                this.convertirTercetoDeSalto(t);
                break;
            case "BLE":
                this.convertirTercetoDeSalto(t);
                break;
            case "BGT":
                this.convertirTercetoDeSalto(t);
                break;
            case "BGE":
                this.convertirTercetoDeSalto(t);
                break;
            case "BEQ":
                this.convertirTercetoDeSalto(t);
                break;
            case "BNE":
                this.convertirTercetoDeSalto(t);
                break;
            case "BI":
                this.convertirTercetoDeSalto(t);
                break;
            case "READ":
                this.convertirTercetoDeLectura(t);
                break;
            case "WRITE":
                this.convertirTercetoDeEscritura(t);
                break;
            default:
                System.out.println("NO SE RECONOCIO OPERADOR " + t.primerElemento.toString());
        }
    }

    private void convertirTercetoDeAsignacion(Terceto t) {
        buffer.add("MOV eax, " + t.tercerElemento.toString());
        buffer.add("MOV " + t.segundoElemento.toString() + ", eax");
    }

    private void convertirTercetoDeSuma(Terceto t) {
        buffer.add("FLD " + t.segundoElemento);
        buffer.add("FLD " + t.tercerElemento);
        buffer.add("FADD");
        buffer.add("FSTP " + t.segundoElemento);
    }

    private void convertirTercetoDeResta(Terceto t) {
        buffer.add("FLD " + t.segundoElemento);
        buffer.add("FLD " + t.tercerElemento);
        buffer.add("FSUB");
        buffer.add("FSTP " + t.segundoElemento);
    }

    private void convertirTercetoDeDivision(Terceto t) {
        buffer.add("FLD " + t.segundoElemento);
        buffer.add("FLD " + t.tercerElemento);
        buffer.add("FDIV");
        buffer.add("FSTP " + t.segundoElemento);
    }

    private void convertirTercetoDeMultiplicacion(Terceto t) {
        buffer.add("FLD " + t.segundoElemento);
        buffer.add("FLD " + t.tercerElemento);
        buffer.add("FMUL");
        buffer.add("FSTP " + t.segundoElemento);
    }

    private void convertirTercetoDeComparacion(Terceto t) {
        buffer.add("FLD " + t.segundoElemento);
        buffer.add("FCOMP " + t.tercerElemento);
        buffer.add("FSTSW ax");
        buffer.add("SAHF");
    }

    private void convertirTercetoDeSalto(Terceto t) {
        String tercetoObj = t.segundoElemento.toString();
        String idTerceto = tercetoObj.substring(1,tercetoObj.length()-1);
        Integer id = Integer.valueOf(idTerceto);
        buffer.add(saltos.get(t.primerElemento.toString()) + " " + this.idTercetoATag.get(id));
    }

    private void convertirTercetoDeLectura(Terceto t) { // read(var) // @TODO revisar

        buffer.add("LEA bx, "+ t.segundoElemento.toString());

    }
    private void convertirTercetoDeEscritura(Terceto t) { // write("cte_string") write(varNumerica) // @TODO revisar

        /* PRINT STRINGS */

        //SymbolTableGenerator stg = new SymbolTableGenerator();        //if(stg.isString(t.segundoElemento.toString())) { }

        buffer.add("MOV dx, OFFSET "+ t.segundoElemento); // ==> buffer.add("LEA dx "+ t.segundoElemento.toString());
        buffer.add("MOV ah, 9"); // rutina para imprimir por pantalla strings
        buffer.add("INT 21h"); // interrumpe y envía una cadena de caracteres al dispositivo estándar de salida
        // Para salto de linea
        buffer.add("ifnb 1");
        buffer.add("MOV cx, 1");
        buffer.add("endif");

    }

    private void escribirTablaDeVariables() {
        buffer.add(".DATA");
        List<String> serializedSymbolTable = new SymbolTableGenerator().getSymbolTableAsStringList();
        buffer.addAll(serializedSymbolTable);
        escribirVariablesDeCompilacion();
    }

    private void escribirVariablesDeCompilacion() {
        buffer.add(String.format("%-30s","@BoolAux")+" dd "+ String.format("%-40s","?"));
        buffer.add(String.format("%-30s","@BoolAuxTemp")+" dd "+ String.format("%-40s","?"));
        buffer.add(String.format("%-30s","@aux")+" dd "+ String.format("%-40s","?"));
        buffer.add(String.format("%-30s","@Cont")+" dd "+ String.format("%-40s","?"));
    }

    private void escribirHeader() {
        buffer.add(".CODE");
        buffer.add("MOV ax,@DATA");
        buffer.add("MOV ds,ax");
        buffer.add("MOV es,ax");
    }

    private void escribirFooter() {
        buffer.add("MOV ax,4c00h");
        buffer.add("Int 21h");
        buffer.add("End");
    }
}
