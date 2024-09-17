package com.farmacia.proyecto.controlador;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.farmacia.proyecto.utilitaria.Archivos;
import org.springframework.stereotype.Service;

@Service // o @Repository si es más adecuado
public class Conexion {

    private String url;
    private String user;
    private String pass;

    public Conexion() {
        // Cargar credenciales al inicializar
        String[] credenciales = Archivos.leer("C:/db_wallets/db_wallets/credenciales.rsa").split(";");
        url = credenciales[0];
        user = credenciales[1];
        pass = credenciales[2];
    }

    public Connection conectar() {
        Connection con = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Conectando a la base de datos...");
            con = DriverManager.getConnection(url, user, pass);
            System.out.println("Conectado a la base de datos Oracle");
        } catch (Exception e) {
            System.out.println("Error al conectar la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
        return con;
    }

    public void desconectar(Connection con) {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                System.out.println("Desconectado de la base de datos.");
            }
        } catch (SQLException ex) {
            System.out.println("Error al desconectar: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public PreparedStatement prepararSql(Connection con, String sql) {
        try {
            return con.prepareStatement(sql);
        } catch (SQLException ex) {
            System.out.println("Error al preparar el SQL: " + ex.getMessage());
            ex.printStackTrace();
        }
        return null;
    }

    public ResultSet ejecutarSql(Connection con, String sql) {
        try (PreparedStatement sqlPreparado = con.prepareStatement(sql)) {
            return sqlPreparado.executeQuery();
        } catch (SQLException ex) {
            System.out.println("Error al ejecutar el SQL: " + ex.getMessage());
            ex.printStackTrace();
        }
        return null;
    }
}
