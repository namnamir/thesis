package automation;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;

import org.sikuli.script.FindFailed;
import org.sikuli.script.KeyModifier;
import org.sikuli.script.Pattern;
import org.sikuli.script.Screen;


public class FirefoxSikuli {

	public static void main(String[] args) throws FindFailed, IOException {
		
		// reads websites URLs from csv file
		Scanner scanner = new Scanner(new File("D:\\VU\\THESIS\\WEBSITES\\websites.csv"));
        scanner.useDelimiter(",");
        
        // initialize screen class to control the screen events
        Screen screen = new Screen();
		Pattern icon = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\001-scrapbookiconclick.jpg");
		Pattern scrapoptions = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\002-optionsclick.jpg");
		Pattern htz = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\003-htzclick.jpg");
		Pattern folder = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\004-folderclick.jpg");
		Pattern audio = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\005-audioclick.jpg");
		Pattern audioremove = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\006-audioremove.jpg");
		Pattern video = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\007-videoclick.jpg");
		Pattern videoremove = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\008-videoremove.jpg");
		Pattern scripts = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\009-scriptsclick.jpg");
		Pattern scriptssave = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\010-scriptssave.jpg");
		Pattern save = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\011-saveclick.jpg");
		Pattern close = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\012-closeclick.jpg");
		Pattern capture = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\014-captureclick.jpg");
		Pattern selectfolder = new Pattern("E:\\GoogleDrive\\XX VRIJE UNIVERSITEIT\\2017-2018\\MASTER THESIS\\SIKULI\\016-scrapfolder.jpg");
        
		// web driver configurations
		System.setProperty("webdriver.gecko.driver", "F:\\SOFTWARE\\PROGRAMMING\\WEBDRIVER\\firefoxdriver.exe");
		FirefoxProfile profile = new FirefoxProfile();
		profile.addExtension(new File("F:\\SOFTWARE\\PROGRAMMING\\FIREFOXEXTENSIONS\\scrapbookfirefox.xpi"));
		FirefoxOptions options = new FirefoxOptions();
		options.setProfile(profile);
		WebDriver driver = new FirefoxDriver(options);
		
		// screen instructions
		screen.click(icon);
		screen.click(scrapoptions);
		screen.click(htz);
		screen.click(folder);
		screen.click(audio);
		screen.click(audioremove);
		screen.wait(video, 3.0);
		screen.click(video);
		screen.click(videoremove);
		screen.wheel(1, 3);
		screen.click(scripts);
		screen.click(scriptssave);
		screen.wheel(1, 15);
		screen.click(save);
		screen.click(close);
		
		// retrieve the websites from csv file
		while (scanner.hasNext()) {
            driver.get(scanner.next());
            screen.click(icon);
            screen.click(scrapoptions);
            screen.click(selectfolder);
            screen.type("a", KeyModifier.CTRL);
            screen.type("websites\\" + scanner.next().toString());
            screen.type("", KeyModifier.SHIFT);
            screen.wheel(1, 20);
            screen.click(save);
            screen.click(close);
            screen.click(icon);
    		screen.click(capture);
    		screen.wait(15.0);
        }
		
		// scanner is closed
		scanner.close();	
		
		// web driver is closed
		driver.close();
		
	}

}
