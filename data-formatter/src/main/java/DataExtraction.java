import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.regex.*;

public class DataExtraction {
	
	private ArrayList<String> rows;
	
	public DataExtraction() {
		setRows(new ArrayList<String>());		
	}
	
	private String extractTable(String filename) {
		String text = "", regex = "<?xml(.*)</DIV>";
		Scanner sc = null;
		
		try {
			sc = new Scanner(new File(filename));
			
			while (sc.hasNext()) {				
				text = text + " " + sc.next();
			}						
			
			Pattern p = Pattern.compile(regex);
		    Matcher m = p.matcher(text); 
		    
		    text = "";		    
		    while (m.find()) {	  		    	
		    	text = text + " " + m.group(1);
		    }		    		    		   
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			sc.close();
		}				
		return text;	
	}

	public ArrayList<String> extractRows(String filename) {		
		String text = extractTable(filename), regex = "\">?(.*?)</";			
			
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(text); 
		    
		while (m.find()) {			
		    getRows().add(m.group(1));
		}		   				
		
		return getRows();
	}
	
	public void setRows(ArrayList<String> rows) {this.rows = rows;}		
	public ArrayList<String> getRows() {return rows;}	

}
