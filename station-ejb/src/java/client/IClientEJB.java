package client;

import javax.ejb.Remote;

@Remote
public interface IClientEJB {

    Client[] getAll()
            throws Exception;
}
