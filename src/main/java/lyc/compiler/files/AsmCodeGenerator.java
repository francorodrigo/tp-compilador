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
            "BI", "JMP"
    );
    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        for(String str: buffer) {
            fileWriter.write(str + "\n");
        }
    }

    public void generarAsm() {
        new IntermediateCodeGenerator().crearListaFinalDeTercetos();
        this.escribirHeader();
        this.escribirTablaDeVariables();
        this.tagearSaltos();
        this.escribirHeaderCodigo();
        int x = 0;
        for(Terceto t: IntermediateCodeGenerator.tercetosFinal) {
            if(idTercetoATag.containsKey(x)) {
                this.buffer.add(idTercetoATag.get(x) + ":");
            }
            this.convertirTerceto(t);
            x++;
        }
        this.escribirFooter();
    }

    private void escribirHeader() {
        buffer.add("include number.asm");
        buffer.add("include macros2.asm");
        buffer.add("include macros.asm");
        buffer.add(".MODEL LARGE");
        buffer.add(".386");
        buffer.add(".STACK 200h");
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
        this.idTercetoATag.put(IntermediateCodeGenerator.tercetosFinal.size(),"tag_end");
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
        SymbolTableGenerator stg = new SymbolTableGenerator();
        /*
        [=,@aux0,_a_es_mas]
        [=,p1,@aux0]
         */
        if(stg.isString(t.tercerElemento.toString()) || stg.isString(t.segundoElemento.toString()) ){
            buffer.add("MOV SI, OFFSET " + t.tercerElemento.toString());
            buffer.add("MOV DI, OFFSET " + t.segundoElemento.toString());
            buffer.add("STRCPY");
        } else {
            buffer.add("MOV eax, " + t.tercerElemento.toString());
            buffer.add("MOV " + t.segundoElemento.toString() + ", eax");
        }
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
        String numbers = "0123456789";
        if(numbers.contains("" + t.tercerElemento.toString().charAt(0))) {
            buffer.add("FCOMP _" + t.tercerElemento);
        } else {
            buffer.add("FCOMP " + t.tercerElemento);
        }
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

        SymbolTableGenerator stg = new SymbolTableGenerator();
        if(stg.isString(t.segundoElemento.toString())) {
            buffer.add("getString "+ t.segundoElemento.toString());
        } else {
            buffer.add("GetFloat " + t.segundoElemento.toString());
        }

    }
    private void convertirTercetoDeEscritura(Terceto t) { // write("cte_string") write(varNumerica) // @TODO revisar

        /* PRINT STRINGS */
        SymbolTableGenerator stg = new SymbolTableGenerator();
        if(stg.isString(t.segundoElemento.toString())) {
            buffer.add("displayString "+ t.segundoElemento.toString());
        } else {
            buffer.add("DisplayFloat " + t.segundoElemento.toString() + ", 2");
        }
        buffer.add("newLine 1");

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

    private void escribirHeaderCodigo() {
        buffer.add(".CODE");
        buffer.add ("START:");
        buffer.add("MOV ax,@DATA");
        buffer.add("MOV ds,ax");
        buffer.add("MOV es,ax");
    }

    private void escribirFooter() {
        buffer.add("tag_end:");
        buffer.add("MOV ax,4c00h");
        buffer.add("Int 21h");
        buffer.add("END START");
    }
}
