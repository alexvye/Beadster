package vye;

import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

public class OffTimerTask extends TimerTask {
	private Station station;
	
	public OffTimerTask(Station station) {
		this.station = station;
	}
	
	@Override
	public void run() {
		station.setStatus(Status.Maintenance);
		station.setMaintRequested(false);
		
		Timer timer = new Timer();
		MaintTimerTask task = new MaintTimerTask(this.station);
		Random r = new Random();
		timer.schedule(task, r.nextInt(60000)+1);
	}
}
