package vye;

import java.util.TimerTask;

public class MaintTimerTask extends TimerTask {
	private Station station;
	
	public MaintTimerTask(Station station) {
		this.station = station;
	}
	
	@Override
	public void run() {
		station.setStatus(Status.Active);
	}
}
