package vye;

import java.util.Random;
import java.util.Timer;

public class Station {
	private Status status;
	private String name;
	private static Bag bag = null;
	private boolean maintRequested = false;
	
	Random r = new Random();
	private static final int TWO_HOURS = 120000;
	
	public Station(String name) {
		if(bag == null) {
			bag = new Bag();
			bag.add(Status.Active, 15);
			bag.add(Status.Offline, 2);
			bag.add(Status.Maintenance, 2);
			bag.add(Status.Suspicious, 1);
		} 
		
		
		this.name = name;
		this.status = Status.Active;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	
	
	public boolean isMaintRequested() {
		return maintRequested;
	}

	public void setMaintRequested(boolean maintRequested) {
		this.maintRequested = maintRequested;
	}

	public String reportStatus() {
		
		switch(status) {
		case Active:
			this.status = (Status)bag.chance();
			break;
		case Offline:
			if(!this.maintRequested) {
				this.maintRequested = true;
				int wait = r.nextInt(TWO_HOURS) + 1;
				Timer timer = new Timer();
				MaintTimerTask task = new MaintTimerTask(this);
				timer.schedule(task, wait);
			}
			break;
		case Maintenance:
			break;
		case Suspicious:
			this.status = (Status)bag.chance();
			break;
		}
		return name+" : "+status;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
