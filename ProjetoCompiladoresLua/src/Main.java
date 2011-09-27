import java_cup.parser;
import java_cup.runtime.Symbol;
import java.io.*;

public class Main {

	static boolean do_debug_parse = false;

	public static void main(String[] args) {

		try {
			parser p = new parser(new LuaLexer(new FileReader(args[0])));
			Object result = p.parse().value;
		} catch (Exception e) {
			/* do cleanup here -- possibly rethrow e */
		} finally {
			/* do close out here */
		}
	}

}
