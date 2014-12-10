package vye.config;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import vye.config.ApplicationContext;
import vye.datajpa.model.Challenge;
import vye.repository.ChallengesRepository;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;
 
//Configuration is omitted.
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = ApplicationContext.class)
@WebAppConfiguration
public class ITChallengeIntegrationTest {
 
    @Autowired
    private ChallengesRepository repository;
 
    @Test
    public void search_NoTodoEntriesFound_ShouldReturnEmptyList() {
    	if(repository == null) {
    		System.out.println("*************NULL*******");
    	}
        List<Challenge> challengeEntries = repository.findAll();
    	//List<Challenge> challengeEntries = new ArrayList<Challenge>();
        assertThat(challengeEntries.size(), is(0));
    }
}