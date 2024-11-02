package client;

import utilisateurstation.UtilisateurStation;

import javax.ejb.Remote;

@Remote
public interface IClientEJB {

    Client[] getAll()
            throws Exception;
}
