package vye;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class Initializer {
	public static List<Staff> loadRandomStaff(String filename) throws Exception {
		
		ArrayList<Staff> staffs = new ArrayList<Staff>();
		
		BufferedReader reader = new BufferedReader(new FileReader(filename));
		String line = reader.readLine();
		
		StringTokenizer tokenizer;
		while(line!=null) {
			tokenizer = new StringTokenizer(line,",");
			String firstName = tokenizer.nextToken();
			String lastName = tokenizer.nextToken();
			staffs.add(new Staff(firstName,lastName));
			line = reader.readLine();
		}
		reader.close();
		return staffs;
	}
	
	public static List<Station> loadStations(String filename) throws Exception {
		ArrayList<Station> stations = new ArrayList<Station>();
		
		BufferedReader reader = new BufferedReader(new FileReader(filename));
		String line = reader.readLine();

		while(line!=null) {
			stations.add(new Station(line));
			line = reader.readLine();
		}
		reader.close();
		return stations;
	}
}
