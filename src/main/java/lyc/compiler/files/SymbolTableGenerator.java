package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;
import java.util.*;
import static lyc.compiler.constants.Constants.*;
import lyc.compiler.model.*;
public class SymbolTableGenerator implements FileGenerator {

    public class TableEntry {
        public TIPO_DATO tipoDato;
        public String valor;
        public String longitud;

        TableEntry(TIPO_DATO tipoDato, String valor, String longitud) {
            this.tipoDato = tipoDato;
            this.valor = valor;
            this.longitud = longitud;
        }
    }
    public static Map<String,TableEntry> symbolTable = new LinkedHashMap<String,TableEntry>();
    public final static Map<TIPO_DATO,String> dictionaryHelper = Map.of(
            TIPO_DATO.FLOAT, "FLOAT",
            TIPO_DATO.INT, "INT",
            TIPO_DATO.STRING, "STRING",
            TIPO_DATO.EMPTY, ""
    );
    public final static Map<String,TIPO_DATO> conversionDataTypeHelper = Map.of(
            "FLOAT", TIPO_DATO.FLOAT,
            "INT", TIPO_DATO.INT,
            "STRING", TIPO_DATO.STRING,
            "", TIPO_DATO.EMPTY
    );

    public static void cleanUp() {
        symbolTable = new LinkedHashMap<String,TableEntry>();
    }
    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        fileWriter.write(String.format("%-30s","NAME")+String.format("%-20s","VALUE TYPE")+ String.format("%-40s","VALUE")+ String.format("%-10s\n","LENGTH"));
        writeSymbolTable(fileWriter);
    }

    private void writeSymbolTable(FileWriter fileWriter) throws IOException {
        for (Map.Entry<String,TableEntry> entry: symbolTable.entrySet()) {
            String name = entry.getKey();
            TableEntry tableEntry = entry.getValue();

            fileWriter.write(String.format("%-30s",name)+String.format("%-20s",dictionaryHelper.get(tableEntry.tipoDato))+ String.format("%-40s",tableEntry.valor)+ String.format("%-10s",tableEntry.longitud) + "\n");
        }
    }

    public void addToSymbolTable(String name, TIPO_DATO valueType, String value, String length) throws AlreadyDeclaredVariableException {
       if(symbolTable.containsKey(name)) {
            return;
       }
       System.out.println("SE AGREGA A SYMBOL TABLE: " + name + " -> " + value);
       TableEntry entry = new TableEntry(valueType,value,length);
       symbolTable.put(name,entry);
    }

    public void updateDataType(String name, String valueType) throws UndeclaredVariableException {
        if (name == null) {
            return;
        }
        if(!symbolTable.containsKey(name)) {
            throw new UndeclaredVariableException("La variable" + name+ " no existe. \n");
        }
        TableEntry entry = symbolTable.get(name);
        if(entry == null){
            throw new UndeclaredVariableException("La variable" + name+ " no existe. \n");
        }
        System.out.println("SE ACTUALIZA TIPO DE DATO EN SYMBOL TABLE: " + name + " : " + valueType);
        entry.tipoDato = conversionDataTypeHelper.get(valueType.toUpperCase());
        symbolTable.put(name,entry);
    }

    public void updateSymbolValue(String name, String value) throws UndeclaredVariableException {
        System.out.println("Name: " + name + ", ValueType: " + value);
        if (name == null) {
            return;
        }
        TableEntry entry = symbolTable.get(name);
        if(entry == null){
            throw new UndeclaredVariableException("La variable" + name+ " no existe. \n");
        }
        System.out.println("SE ACTUALIZA TIPO DE DATO EN SYMBOL TABLE: " + name + " : " + value);
        entry.valor = value;
        entry.longitud = Integer.valueOf(value.length()).toString();
        symbolTable.put(name,entry);
    }

    public static void mostrarTabla() {
        for (Map.Entry<String,TableEntry> entry: SymbolTableGenerator.symbolTable.entrySet()) {
            String name = entry.getKey();
            TableEntry tableEntry = entry.getValue();

            System.out.println(String.format("%-30s",name)+String.format("%-20s",dictionaryHelper.get(tableEntry.tipoDato))+ String.format("%-40s",tableEntry.valor)+ String.format("%-10s",tableEntry.longitud) + "\n");
        }
    }

    public boolean isString(String name) {
        return symbolTable.containsKey(name) && symbolTable.get(name).tipoDato == TIPO_DATO.STRING;
    }
    public boolean isFloat(String name) {
        return symbolTable.containsKey(name) && symbolTable.get(name).tipoDato == TIPO_DATO.FLOAT;
    }
    public boolean isInteger(String name) {
        return symbolTable.containsKey(name) && symbolTable.get(name).tipoDato == TIPO_DATO.INT;
    }
    public boolean isType(String name, String type) {
        return symbolTable.containsKey(name) && symbolTable.get(name).tipoDato == conversionDataTypeHelper.get(type.toUpperCase());
    }
    public boolean assertSameType(String name1, String name2) {
        return symbolTable.containsKey(name1) && symbolTable.containsKey(name2)
                && symbolTable.get(name1).tipoDato.equals(symbolTable.get(name2).tipoDato);
    }
    public boolean assertExists(String name) {
        TableEntry entry = symbolTable.get(name);
        return (entry != null && entry.tipoDato != TIPO_DATO.EMPTY);
    }
    public boolean isUninitialized(String name) {
        //System.out.println("Name: " + name + " existe?: " + symbolTable.containsKey(name) + " Tipo de dato: " + symbolTable.get(name).tipoDato);
        return symbolTable.containsKey(name) &&  symbolTable.get(name) != null && symbolTable.get(name).tipoDato == TIPO_DATO.EMPTY;
    }
}
