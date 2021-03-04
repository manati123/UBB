package domain.baseEntities;

public class BaseEntity<ID> {
    private ID id;

    public ID getId(){
        return this.id;
    }

    public void setId(ID id){
        this.id = id;
    }

    @Override
    public String toString() {
        return "BaseEntity{"+
                "id = " + id +
                "}";
    }
}
