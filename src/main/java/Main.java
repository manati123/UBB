import controller.Controller;
import domain.baseEntities.Droid;
import domain.validators.IValidator;
import domain.validators.DroidValidator;
import repo.IRepository;
import repo.InMemoryRepository;
import view.View;

public class Main {
    public static void main(String[] args) {

        //in-memory repo
        IValidator<Droid> droidValidator = new DroidValidator();
        IRepository<Long, Droid> droidRepository = new InMemoryRepository<>(droidValidator);
        Controller droidService = new Controller(droidRepository);
        View console = new View(droidService);
        console.runView();//this is a comment for the attendance

    }
}
