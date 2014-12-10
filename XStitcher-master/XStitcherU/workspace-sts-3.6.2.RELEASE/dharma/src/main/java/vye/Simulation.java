package vye;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Timer;

public class Simulation {
	
	private List<Staff> names = new ArrayList<Staff>();
	private List<Station> stations = new ArrayList<Station>();
	
	public Simulation() throws Exception {
		this.names.addAll(Initializer.loadRandomStaff("/Users/alexvye/Documents/workspace-sts-3.6.2.RELEASE/dharma/src/main/java/vye/names.txt"));
		this.stations.addAll(Initializer.loadStations("/Users/alexvye/Documents/workspace-sts-3.6.2.RELEASE/dharma/src/main/java/vye/station.txt"));
	}
	
	public void startup() {
		StationTimerTask stationTask = new StationTimerTask(this.stations);
		Timer stationTimer = new Timer();
		stationTimer.scheduleAtFixedRate(stationTask, new Date(), 5000);
	}

}
