package lyc.compiler.files;

import javax.lang.model.type.NullType;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class IntermediateCodeGenerator implements FileGenerator {

    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        int x = 0;
        for (Terceto t: TercetoGenerator.tercetos) {
            try {
                fileWriter.write(x + ": " + t.toString());
                x++;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        fileWriter.write("TODO");
    }
}