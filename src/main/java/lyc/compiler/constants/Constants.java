package lyc.compiler.constants;

public final class Constants {
    public enum TIPO_DATO {
        FLOAT,
        INT,
        STRING,
        EMPTY
    }

    public static final int MAX_ID_LENGTH = 30;
    public static final int MAX_STRING_LENGTH = 40;
    public static final int MIN_INTEGER_LENGTH = -32768;
    public static final int MAX_INTEGER_LENGTH = 32767;
    //public static final double MIN_FLOAT_LENGTH = 3.402823e+38;
    public static final double MIN_FLOAT_LENGTH = -9999999999999.999999;
    //public static final double MAX_FLOAT_LENGTH = 1.175494e-38;
    public static final double MAX_FLOAT_LENGTH = 9999999999999.999999;

    private Constants(){}

}
