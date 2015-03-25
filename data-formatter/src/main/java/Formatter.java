import joptsimple.OptionParser;
import joptsimple.OptionSet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by nickozoulis on 25/3/2015.
 */
public class Formatter {

    private static final Logger logger = LoggerFactory.getLogger(Formatter.class);
    private static String inputDir, outputDir;

    public static void main(String[] args) {
        OptionParser parser = new OptionParser("i:o:");
        OptionSet options = parser.parse(args);

        if (options.hasArgument("i") && options.hasArgument("o")) {
            inputDir = options.valueOf("i").toString();
            outputDir = options.valueOf("o").toString();

            extractDataFromHtmlFiles();
        } else {

        }
    }

    private static void extractDataFromHtmlFiles() {



    }


}
