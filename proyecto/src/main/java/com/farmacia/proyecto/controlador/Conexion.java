package com.farmacia.proyecto.controlador;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.farmacia.proyecto.utilitaria.Archivos;
import org.springframework.stereotype.Service;


/**
 *
 * @author Nash
 */
@Service // o @Repository si es más adecuado
public class Conexion {
    private Connection con;
    private String url;
    private String user;
    private String pass;

    public Connection conectar() {
        String[] credenciales = Archivos.leer("C:/db_wallets/db_wallets/credenciales.rsa").split(";");
        url = credenciales[0];
        user = credenciales[1];
        pass = credenciales[2];
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Open a connection
            System.out.println("Conectando a la base de datos...");
            con = DriverManager.getConnection(url, user, pass);
            System.out.println("Conectado a la base de datos oracle");
        } catch (Exception e) {
            System.out.println(e);
            System.out.println("Error al conectar la base de datos");
        }
        return con;
    }
    
    public void desconectar() {
        try {
            con.close();
            url = "";
            user = "";
            pass = "";
            System.out.println("Desconectado de la base de datos.");
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public PreparedStatement prepararSql(String sql) {
        try {
            return con.prepareStatement(sql);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }
    
    public ResultSet ejecutarSql (PreparedStatement sqlPreparado) {
        try {
            return sqlPreparado.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }


}
