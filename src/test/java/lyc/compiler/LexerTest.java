package lyc.compiler;

import lyc.compiler.factories.LexerFactory;
import lyc.compiler.model.*;
import org.apache.commons.text.CharacterPredicates;
import org.apache.commons.text.RandomStringGenerator;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import java.io.IOException;

import static com.google.common.truth.Truth.assertThat;
import static lyc.compiler.constants.Constants.*;
import static org.junit.jupiter.api.Assertions.assertThrows;


public class LexerTest {

  private Lexer lexer;


  @Test
  public void comment() throws Exception{
    scan("/*This is a comment*/");
    assertThat(nextToken()).isEqualTo(ParserSym.EOF);
  }

  @Test
  public void invalidStringConstantLength() {
    assertThrows(InvalidLengthException.class, () -> {
      scan("\"%s\"".formatted(getRandomString()));
      nextToken();
    });
  }

  @Test
  public void invalidIdLength() {
    assertThrows(InvalidLengthException.class, () -> {
      scan(getRandomString());
      nextToken();
    });
  }

  @Test
  public void invalidPositiveIntegerConstantValue() {
    assertThrows(InvalidIntegerException.class, () -> {
      scan("%d".formatted(9223372036854775807L));
      nextToken();
    });
  }

  @Test
  public void invalidNegativeIntegerConstantValue() {
    assertThrows(InvalidIntegerException.class, () -> {
      scan("%d".formatted(-9223372036854775807L));
      nextToken();
    });
  }

  @Test
  public void invalidNegativeFloatConstantValue() {
    assertThrows(InvalidFloatException.class, () -> {
      scan("-99999999099999.999999");
      nextToken();
    });
  }

  @Test
  public void invalidPositiveFloatConstantValue() {
    assertThrows(InvalidFloatException.class, () -> {
      scan("99999999099999.999999");
      nextToken();
    });
  }

  @Test
  public void invalidIntegerLength() {
    assertThrows(InvalidLengthException.class, () -> {
      scan("000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
      nextToken();
    });
  }

  @Test
  public void invalidFloatLength() {
    assertThrows(InvalidLengthException.class, () -> {
      scan("00000000000000000000000000000000000000000000000000.00000000000000000000000000000000000000000000001");
      nextToken();
    });
  }

  @Test
  public void assignmentWithExpressions() throws Exception {
    scan("c = d * ( e - 21 ) / 4");
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.ASSIG);
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.MULT);
    assertThat(nextToken()).isEqualTo(ParserSym.OPEN_BRACKET);
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.SUB);
    assertThat(nextToken()).isEqualTo(ParserSym.INTEGER_CONSTANT);
    assertThat(nextToken()).isEqualTo(ParserSym.CLOSE_BRACKET);
    assertThat(nextToken()).isEqualTo(ParserSym.DIV);
    assertThat(nextToken()).isEqualTo(ParserSym.INTEGER_CONSTANT);
    assertThat(nextToken()).isEqualTo(ParserSym.EOF);
  }

  @Test
  public void igualesBuiltInFunction() throws Exception {
    scan("#Iguales ( a+w/b, [(d - 3) * 2,e,f] )");
    assertThat(nextToken()).isEqualTo(ParserSym.IGUALES);
    assertThat(nextToken()).isEqualTo(ParserSym.OPEN_BRACKET);
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.PLUS);
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.DIV);
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.COMMA);
    assertThat(nextToken()).isEqualTo(ParserSym.OPEN_SQUARE_BRACKET);
    assertThat(nextToken()).isEqualTo(ParserSym.OPEN_BRACKET);
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.SUB);
    assertThat(nextToken()).isEqualTo(ParserSym.INTEGER_CONSTANT);
    assertThat(nextToken()).isEqualTo(ParserSym.CLOSE_BRACKET);
    assertThat(nextToken()).isEqualTo(ParserSym.MULT);
    assertThat(nextToken()).isEqualTo(ParserSym.INTEGER_CONSTANT);
    assertThat(nextToken()).isEqualTo(ParserSym.COMMA);
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.COMMA);
    assertThat(nextToken()).isEqualTo(ParserSym.IDENTIFIER);
    assertThat(nextToken()).isEqualTo(ParserSym.CLOSE_SQUARE_BRACKET);
    assertThat(nextToken()).isEqualTo(ParserSym.CLOSE_BRACKET);
  }

  @Test
  public void unknownCharacter() {
    assertThrows(UnknownCharacterException.class, () -> {
      scan("#");
      nextToken();
    });
    assertThrows(UnknownCharacterException.class, () -> {
      scan("@");
      nextToken();
    });
  }

  @AfterEach
  public void resetLexer() {
    lexer = null;
  }

  private void scan(String input) {
    lexer = LexerFactory.create(input);
  }

  private int nextToken() throws IOException, CompilerException {
    return lexer.next_token().sym;
  }

  private static String getRandomString() {
    return new RandomStringGenerator.Builder()
            .filteredBy(CharacterPredicates.LETTERS)
            .withinRange('a', 'z')
            .build().generate(MAX_STRING_LENGTH * 2);
  }

}
