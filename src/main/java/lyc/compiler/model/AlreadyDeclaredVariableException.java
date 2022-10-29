package lyc.compiler.model;

public class AlreadyDeclaredVariableException extends CompilerException{

    public AlreadyDeclaredVariableException(String message) {
        super(message);
    }
}
