package utils;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public abstract class DateUtil {
    public static Date strToDate( String daty )
            throws ParseException {
        SimpleDateFormat sd = new SimpleDateFormat( "yyyy-MM-dd" );
        java.util.Date util = sd.parse( daty );
        return new Date( util.getTime() );
    }
}
