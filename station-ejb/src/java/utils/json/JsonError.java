package utils.json;

public class JsonError {

    String message;

    public JsonError( String message ) {
        this.setMessage( message );
    }

    public String getMessage() {
        return message;
    }

    public void setMessage( String message ) {
        this.message = message;
    }
}
