package utils;

//import boutik.IBoutikEJB;
import client.IClientEJB;
import utilisateurstation.IUtilisateurEJB;
import venteLubrifiant.ILubrifiantEJB;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class EJBGetter {

    //    Gallois
//    public static IBoutikEJB getBoutikEJB()
//            throws NamingException {
//        Context ctx = new InitialContext();
//        String jndi = "java:global/station/BoutikEJB!boutik.IBoutikEJB";
//        return ( IBoutikEJB ) ctx.lookup( jndi );
//    }

    public static ILubrifiantEJB getLubrifiantEJB()
            throws NamingException {
        Context ctx = new InitialContext();
        String jndi = "java:global/station/LubrifiantEJB!venteLubrifiant.ILubrifiantEJB";
        return ( ILubrifiantEJB ) ctx.lookup( jndi );
    }

    public static IUtilisateurEJB getUtilisateurEJB()
            throws NamingException {
        Context ctx = new InitialContext();
        String jndi = "java:global/station/UtilisateurEJB!utilisateurstation.IUtilisateurEJB";
        return ( IUtilisateurEJB ) ctx.lookup( jndi );
    }

    public static IClientEJB getClientEJB()
            throws NamingException {
        Context ctx = new InitialContext();
        String jndi = "java:global/station/ClientEJB!client.IClientEJB";
        return ( IClientEJB ) ctx.lookup( jndi );
    }

    //    Galana
    // ...
}
