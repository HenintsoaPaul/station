package henin;

import client.IClientEJB;
import utils.EJBGetter;
import utils.json.JsonError;

import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet( urlPatterns = "client" )
public class ClientServlet extends HeninServlet {

    private final IClientEJB clientEJB;

    public ClientServlet()
            throws NamingException {
        super();
        clientEJB = EJBGetter.getClientEJB();
    }

    @Override
    protected void doGet( HttpServletRequest req, HttpServletResponse resp )
            throws IOException {
        try {
            resp.setContentType( "application/json" );
            super.setCORS( resp );

            Object[] arr = this.clientEJB.getAll();

            resp.getWriter().println( this.gson.toJson( arr ) );
        } catch ( Exception e ) {
            resp.setStatus( HttpServletResponse.SC_INTERNAL_SERVER_ERROR );
            resp.getWriter().write( this.gson.toJson( new JsonError( "Erreur interne" ) ) );
        }
    }
}
