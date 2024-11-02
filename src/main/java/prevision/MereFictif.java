package prevision;
import bean.ClassMere;

public class MereFictif extends ClassMere{
    private String id;

    public MereFictif() {
        this.setNomTable("merefictif");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
}
