package prelevementLub;

import venteLubrifiant.henin.MyPrelevementLub;

import javax.ejb.Remote;

@Remote
public interface IPrelevementLubEJB {

    void reglerPrelevementLub( MyPrelevementLub myPrelevementLub )
            throws Exception;
}
