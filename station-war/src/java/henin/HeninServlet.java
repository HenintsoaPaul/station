package henin;

import com.google.gson.Gson;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public abstract class HeninServlet extends HttpServlet {

    protected Gson gson;

    protected HeninServlet() {
        this.gson = new Gson();
    }

    protected void setCORS( HttpServletResponse response ) {
        response.setHeader( "Access-Control-Allow-Origin", "*" );
        response.setHeader( "Access-Control-Allow-Methods", "GET, POST, PUT, OPTIONS, DELETE" );
        response.setHeader( "Access-Control-Allow-Headers", "Content-Type, Authorization" );
        response.setHeader( "Access-Control-Allow-Credentials", "true" );
    }

    protected void dataOk(HttpServletResponse response)
            throws IOException {
        response.setStatus( HttpServletResponse.SC_OK );
        PrintWriter out = response.getWriter();
        out.write( "\"Données reçues avec succès\"" );
        out.close();
    }

    protected Gson getGson() {
        return gson;
    }
}
