package controller;

import domain.baseEntities.Droid;
import exceptions.ExistingDroidException;
import repo.IRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

public class Controller {
    IRepository<Long, Droid> repository;

    public Controller(IRepository<Long, Droid> repository) {
        this.repository = repository;
    }

    public void addDroid(Droid newDroid) throws ExistingDroidException {
        var droid = repository.findOne(newDroid.getId());
        try {
            droid.get();
            throw new ExistingDroidException("droid exists");
        } catch (NoSuchElementException e) {
            repository.save(newDroid);
        }
        // IMO THIS IS CLEANER
//        if (repository.findOne(newDroid.getId()).isPresent()) {
//            throw new ExistingDroidException("droid exists");
//        }
//        repository.save(newDroid);
    }

    public List<Droid> getDroids() {
        var droids = new ArrayList<Droid>();
        repository.findAll().forEach(droids::add);
        return droids;
    }

    public List<Droid> filterDroidsByModel(String msg) {
        var droids = new ArrayList<Droid>();
        repository.findAll().forEach(droids::add);
        return droids.stream()
                .filter(s -> s.getModel().contains(msg))
                .collect(Collectors.toList());
    }
}
