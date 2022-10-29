package lyc.compiler.model;
import java.util.*;
import lyc.compiler.files.*;
public class IncompatibleTypeException extends CompilerException {
    public IncompatibleTypeException(String message) {
        super(message);
        SymbolTableGenerator.mostrarTabla();
    }
}
