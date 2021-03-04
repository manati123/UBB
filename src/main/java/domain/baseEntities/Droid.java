package domain.baseEntities;

import java.util.Objects;

public class Droid extends BaseEntity<Long> {


    private final double powerUsage;
    private final double price;
    private final int batteryTime;
    private final String model;
    private final boolean driver;


    public Droid(double powerUsage, double price, int batteryTime, String model, boolean driver) {
        this.powerUsage = powerUsage;
        this.price = price;
        this.batteryTime = batteryTime;
        this.model = model;
        this.driver = driver;
    }

    @Override
    public int hashCode() {
        return Objects.hash(powerUsage, price, batteryTime, model, driver);
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Droid Droid = (Droid) o;
        return Double.compare(Droid.powerUsage, powerUsage) == 0 && Double.compare(Droid.price, price) == 0 && batteryTime == Droid.batteryTime && driver == Droid.driver && Objects.equals(model, Droid.model);
    }

    @Override
    public String toString() {
        return "Droid{" +
                "powerUsage=" + powerUsage +
                ", price=" + price +
                ", batteryTime=" + batteryTime +
                ", model='" + model + '\'' +
                ", driver=" + driver +
                '}';
    }

    public double getPowerUsage() {
        return powerUsage;
    }

    public double getPrice() {
        return price;
    }

    public int getBatteryTime() {
        return batteryTime;
    }

    public String getModel() {
        return model;
    }

}