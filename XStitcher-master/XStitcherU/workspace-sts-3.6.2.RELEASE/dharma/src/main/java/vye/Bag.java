package vye;

import java.util.ArrayList;
import java.util.Random;

public class Bag {
	
	private ArrayList<Object> bag = new ArrayList<Object>();
	private Random r = new Random();
	
	public void add(Object obj, int num) {
		for(int i=0;i<num;i++) {
			bag.add(obj);
		}
	}
	
	Object draw() {
		int index = r.nextInt(bag.size());
		Object obj = bag.remove(index);
		return obj;
	}
	
	Object chance() {
		int index = r.nextInt(bag.size());
		Object obj = bag.get(index);
		return obj;
	}
}
