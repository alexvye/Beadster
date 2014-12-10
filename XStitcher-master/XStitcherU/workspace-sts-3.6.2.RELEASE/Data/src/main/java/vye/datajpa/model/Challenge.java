package vye.datajpa.model;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "Challenge")
@Table(name = "challenge")
public class Challenge {
	
	@Id
	@Column(name = "id", unique = true, nullable = false)
    @GeneratedValue
    private long id;
	
	@Column(name = "name")
	private String name;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
