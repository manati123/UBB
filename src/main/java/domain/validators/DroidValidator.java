package domain.validators;

import domain.baseEntities.Droid;
import exceptions.ValidatorException;

public class DroidValidator implements IValidator<Droid> {
    @Override
    public void validate(Droid entity) throws ValidatorException {
        var msg = "";

        if (entity.getBatteryTime() < 0) {
            msg += "battery time cannot be negative;";
        }
        if (entity.getPrice() < 0) {
            msg += "price cannot be negative;";
        }
        if (entity.getPowerUsage() < 0) {
            msg += "power usage cannot be negative;";
        }

        if (!msg.equals("")) {
            throw new ValidatorException(msg);
        }
    }
}
