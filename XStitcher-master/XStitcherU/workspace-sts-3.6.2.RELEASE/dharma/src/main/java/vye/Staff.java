package vye;

import java.sql.Date;

public class Staff {
	private String first;
	private String last;
	private Date birthday;
	
	public Staff(String first, String last) {
		this.first = first;
		this.last = last;
	}
	
	public String getFirst() {
		return first;
	}
	public void setFirst(String first) {
		this.first = first;
	}
	public String getLast() {
		return last;
	}
	public void setLast(String last) {
		this.last = last;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	
	
}
