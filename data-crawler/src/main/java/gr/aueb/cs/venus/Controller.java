package gr.aueb.cs.venus;

import edu.uci.ics.crawler4j.crawler.CrawlConfig;
import edu.uci.ics.crawler4j.crawler.CrawlController;
import edu.uci.ics.crawler4j.fetcher.PageFetcher;
import edu.uci.ics.crawler4j.robotstxt.RobotstxtConfig;
import edu.uci.ics.crawler4j.robotstxt.RobotstxtServer;
import joptsimple.OptionParser;
import joptsimple.OptionSet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

/**
 * Created by nickozoulis on 9/12/2014.
 */
public class Controller {

    static final Logger logger = LoggerFactory.getLogger(Controller.class);
    private static String inputDomain, outputPath = "/var/tmp/";

    public static void main(String[] args) {
        OptionParser parser = new OptionParser("i:o:");
        OptionSet options = parser.parse(args);

        if (options.hasArgument("i"))
            inputDomain = options.valueOf("i").toString();
        else
            inputDomain = "http://e-grammateia.aueb.gr/unistudent/courselist.asp?filter=0&mnuid=mnu5&/";

        if (options.hasArgument("o")) {
            outputPath = options.valueOf("o").toString();

            File folder = new File(outputPath);
            try {
                if (!folder.exists()) {
                    logger.info("Output directory does not exist. Will be now created.");
                    folder.mkdir();
                }
            } catch (SecurityException e) {
                logger.info("Could not create directory. Exiting now.");
                e.printStackTrace();
                System.exit(1);
            }

            crawl();
        } else {
            logger.error("Output directory must be specified. Exiting now.");
            System.exit(1);
        }
    }

    private static void crawl() {
        CrawlConfig config = new CrawlConfig();
        config.setCrawlStorageFolder(outputPath);

        try {
            /*
             * Instantiate the controller for this crawl.
             */
            PageFetcher pageFetcher = new PageFetcher(config);
            RobotstxtConfig robotstxtConfig = new RobotstxtConfig();
            RobotstxtServer robotstxtServer = new RobotstxtServer(robotstxtConfig, pageFetcher);
            CrawlController controller = new CrawlController(config, pageFetcher, robotstxtServer);

            /*
             * For each crawl, you need to add some seed urls. These are the first
             * URLs that are fetched and then the crawler starts following links
             * which are found in these pages
             */
            controller.addSeed(inputDomain);

            /*
             * Start the crawl. This is a blocking operation, meaning that your code
             * will reach the line after this only when crawling is finished.
             */
            controller.start(Crawler.class, 1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
