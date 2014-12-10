/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
 *
 * Copyright 2014 Medavie BlueCross. All rights reserved.
 *
 * The contents of this file are subject to the Medavie Blue Cross
 * Application Code terms of use policy, for more information contact
 * Medavie Blue Cross.
 */
package vye.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import vye.datajpa.model.Challenge;


/**
 * @author bcavye
 *
 */
@Repository
public interface ChallengesRepository extends CrudRepository<Challenge, Integer> {
	
	public final static String FIND_BY_ADDRESS_QUERY = "SELECT p " + 
            "FROM Person p LEFT JOIN p.addresses a " +
            "WHERE a.address = :address";
	
	  Challenge save(Challenge challenge);

	  //void delete(UUID key);

	  Challenge findByName(String name);

	  List<Challenge> findAll();
}
