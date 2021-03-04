package view;

import controller.Controller;
import domain.baseEntities.Droid;
import exceptions.ExistingDroidException;
import exceptions.ValidatorException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Scanner;

public class View {

    private Controller ctrl;

    public View(Controller dr) {
        this.ctrl = dr;
    }


    public void menu() {
        System.out.println("    Choose one: ");
        System.out.println("1. Add a droid.");
        System.out.println("2. Print all droids.");
        System.out.println("3. Filter droids by model.");
        System.out.println("0. Exit");
    }


    public void runView() throws ValidatorException {
        while(true) {
            Scanner keyboard = new Scanner(System.in);
            this.menu();
            int command;
            System.out.println("Insert command:");
            command = keyboard.nextInt();
            switch (command) {
                case (0) -> {
                }
                case (1) -> {
                    addDroid();
                    runView();
                }
                case (2) -> {
                    printAllDroids();
                    runView();
                }
                case (3) -> {
                    filterDroids();
                    runView();
                }
                default -> runView();
            }
            break;
        }
    }

    private void filterDroids() {
        System.out.println("Filtered droids (name containing 'r2'):");
        List<Droid> droids = ctrl.filterDroidsByModel("r2");
        droids.forEach(System.out::println);
    }

    private void printAllDroids() {
        List<Droid> droids = ctrl.getDroids();
        droids.forEach(System.out::println);
    }

    public void addDroid() throws ValidatorException{
        while (true) {
            Droid droid = readDroid();
            if (droid == null || droid.getId() < 0) {
                continue;
            }
            try {
                ctrl.addDroid(droid);
                return;
            } catch (ValidatorException | exceptions.ExistingDroidException e) {
                e.printStackTrace();
            }
        }
    }

    private Droid readDroid() throws ValidatorException{
        System.out.println("Read droid {id, powerUsage, price, batteryTime, model, driver}.");

        BufferedReader bufferRead = new BufferedReader(new InputStreamReader(System.in));
        try {
            Long id = Long.valueOf(bufferRead.readLine());// ...
            double powerUsage = Double.parseDouble(bufferRead.readLine());
            double price = Double.parseDouble(bufferRead.readLine());
            int batteryTime = Integer.parseInt(bufferRead.readLine());
            String model = bufferRead.readLine();// ...
            boolean driver = Boolean.parseBoolean(bufferRead.readLine());

            Droid droid = new Droid(powerUsage, price, batteryTime, model, driver);
            droid.setId(id);
            System.out.println("trecut");
            return droid;
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }

}
