package app.redoge.restaurant.listener;


import org.apache.log4j.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import static app.redoge.restaurant.DAO.ConnectDB.getConnection;


/**
 * The type Application context listener.
 */
@WebListener
public class ApplicationContextListener implements ServletContextListener {
    private static final Logger log = Logger.getLogger(ApplicationContextListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Connection con = getConnection();
        if(con == null){
            log.error("Data base has disconnected");
            log.debug("Close app");
            System.exit(1);
        }else{
            log.debug("Connect to DB");
        }

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        log.debug("contextDestroy");
    }
}
