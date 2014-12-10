package vye;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;



public class StationTimerTask extends TimerTask {
	
	private List<Station> stations = new ArrayList<Station>();
	
	public StationTimerTask(List<Station> stations) {
		this.stations.addAll(stations);
	}
	
	//
	// Check the status of all stations
	//

	@Override
	public void run() {
		
		System.out.println("=================");
		System.out.println("Status at " + (new Date()));
		System.out.println("=================");
		for(Station station:this.stations)  {
			System.out.println(station.reportStatus());
		}
		
	}

}
