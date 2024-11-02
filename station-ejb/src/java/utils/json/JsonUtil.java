package utils.json;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class JsonUtil {

    public static String getFromWeb( HttpServletRequest request )
            throws IOException {
        InputStream inputStream = request.getInputStream();
        BufferedReader reader = new BufferedReader( new InputStreamReader( inputStream ) );
        StringBuilder sb = new StringBuilder();
        String line;
        while ( ( line = reader.readLine() ) != null ) {
            sb.append( line );
        }
        reader.close();
        return sb.toString();
    }
}
