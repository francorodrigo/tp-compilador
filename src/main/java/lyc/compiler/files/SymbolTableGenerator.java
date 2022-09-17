package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;
import java.util.*;
import static lyc.compiler.constants.Constants.*;

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

    public void addToSymbolTable(String name, TIPO_DATO valueType, String value, String length) {
       if(symbolTable.containsKey(name)) {
            return;
        }
       System.out.println("SE AGREGA A SYMBOL TABLE: " + name + " -> " + value);
       TableEntry entry = new TableEntry(valueType,value,length);
       symbolTable.put(name,entry);
    }
}
