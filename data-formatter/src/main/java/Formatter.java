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
        ArrayList<String> ids = new ArrayList<String>();
        ArrayList<String> grades = new ArrayList<String>();
        ArrayList<String> examEras = new ArrayList<String>();

        ArrayList<String> array = new DataExtraction().extractRows("src/data/html.txt");

        for(int i=4; i<array.size(); i+=3) {
            ids.add(array.get(i).substring(array.get(i).length() - 7, array.get(i).length() - 4));
            grades.add(array.get(i + 1).substring(array.get(i + 1).length() - 3, array.get(i + 1).length()));
            examEras.add(array.get(i + 2).substring(array.get(i + 2).length() - 4, array.get(i + 2).length()));
        }

        writeFile(ids, cleanGrades(grades), examEras);


    }

    private static ArrayList<String> cleanGrades(ArrayList<String> grad) {
        ArrayList<String> cleaned = new ArrayList<String>();
        String temp = "";

        for(String s : grad) {
            temp = s.replaceAll(">", "");
            temp = temp.replaceAll("\"", "");
            cleaned.add(temp);
        }

        return cleaned;
    }


    private static void writeFile(ArrayList<String> ids, ArrayList<String> grades, ArrayList<String> examEras) {
        FileWriter fw1 = null, fw2 = null, fw3 = null;
        BufferedWriter bw1 = null, bw2 = null, bw3 = null;

        try{
            if (examEras.contains(examEra1)) {
                fw1 = new FileWriter("src/data/February.txt");
                bw1 = new BufferedWriter(fw1);
            }
            if (examEras.contains(examEra2)) {
                fw2 = new FileWriter("src/data/June.txt");
                bw2 = new BufferedWriter(fw2);
            }
            if (examEras.contains(examEra3)) {
                fw3 = new FileWriter("src/data/September.txt");
                bw3 = new BufferedWriter(fw3);
            }

            for (int i=0; i<examEras.size(); i++) {
                if (examEras.get(i).equals(examEra1)) {
                    bw1.write(ids.get(i));
                    bw1.newLine();
                }
                else if (examEras.get(i).equals(examEra2)) {
                    bw2.write(ids.get(i));
                    bw2.newLine();
                }
                else if (examEras.get(i).equals(examEra3)) {
                    bw3.write(ids.get(i));
                    bw3.newLine();
                }
            }

            if (bw1 != null) bw1.newLine();
            if (bw2 != null) bw2.newLine();
            if (bw3 != null) bw3.newLine();

            for (int i=0; i<examEras.size(); i++) {
                if (examEras.get(i).equals(examEra1)) {
                    bw1.write(grades.get(i));
                    bw1.newLine();
                }
                else if (examEras.get(i).equals(examEra2)) {
                    bw2.write(grades.get(i));
                    bw2.newLine();
                }
                else if (examEras.get(i).equals(examEra3)) {
                    bw3.write(grades.get(i));
                    bw3.newLine();
                }
            }

            if (bw1 != null) bw1.close();
            if (bw2 != null) bw2.close();
            if (bw3 != null) bw3.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
