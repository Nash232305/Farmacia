package com.farmacia.proyecto.controlador;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.farmacia.proyecto.modelo.Sucursal;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import java.util.HashMap;
import java.util.Map;

import java.sql.Connection;




@Controller
public class LoginController {

    @Autowired
    private Conexion conexion;

    @GetMapping("/Login")
    public String mostrarLogin() {
        return "login"; // Retorna la vista login.html
    }

    @GetMapping("/menu")
    public String mostrarMenu(Model model) {
        List<Sucursal> sucursales = obtenerSucursales();
        model.addAttribute("sucursales", sucursales);
        return "menu"; // Retorna la vista menu.html
    }

    private List<Sucursal> obtenerSucursales() {
        List<Sucursal> sucursales = new ArrayList<>();
        String sql = "{ call obtener_sucursales_farmacia(?) }";

        try (CallableStatement callableStatement = conexion.conectar().prepareCall(sql)) {
            callableStatement.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
            callableStatement.execute();

            ResultSet rs = (ResultSet) callableStatement.getObject(1);

            while (rs.next()) {
                Sucursal sucursal = new Sucursal();
                sucursal.setId(rs.getLong("ID"));
                sucursal.setNombre(rs.getString("NOMBRE"));
                sucursal.setProvincia(rs.getString("PROVINCIA"));
                sucursal.setEstado(rs.getString("ESTADO").charAt(0));
                sucursal.setTelefono(rs.getString("TELEFONO"));
                sucursal.setFechaApertura(rs.getDate("FECHAAPERTURA"));
                sucursales.add(sucursal);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sucursales;
    }

    @PostMapping("/validarCredenciales")
    @ResponseBody
    public Map<String, Object> validarCredenciales(@RequestBody Map<String, String> credenciales) {
        String usuario = credenciales.get("usuario").trim();
        String contrasena = credenciales.get("contrasena").trim();
        Map<String, Object> response = new HashMap<>();
    
        // Validar que los campos no estén vacíos
        if (usuario.isEmpty()) {
            response.put("exito", false);
            response.put("mensajeUsuario", "El campo de usuario no puede estar vacío.");
            return response;
        }
        if (contrasena.isEmpty()) {
            response.put("exito", false);
            response.put("mensajeContrasena", "El campo de contraseña no puede estar vacío.");
            return response;
        }
    
        Connection conn = null;
        CallableStatement stmt = null;
    
        try {
            conn = conexion.conectar();
            String procedimiento = "{ call Validar_Credenciales(?, ?, ?) }";
            stmt = conn.prepareCall(procedimiento);
    
            // Configurar los parámetros de entrada y salida
            stmt.setString(1, usuario);
            stmt.setString(2, contrasena);
            stmt.registerOutParameter(3, java.sql.Types.INTEGER);
    
            // Ejecutar el procedimiento almacenado
            stmt.execute();
    
            // Obtener el resultado
            int resultado = stmt.getInt(3);
            System.out.println("Usuario: " + usuario + ", Contraseña: " + contrasena + ", Resultado: " + resultado);
    
            if (resultado > 0) {
                response.put("exito", true);
                response.put("mensaje", "Inicio de sesión exitoso.");
            } else if (resultado == 0) {
                response.put("exito", false);
                response.put("mensajeUsuario", "Usuario o contraseña incorrectos.");
            } else {
                response.put("exito", false);
                response.put("mensajeGeneral", "Ocurrió un error inesperado.");
            }
        } catch (SQLException e) {
            response.put("exito", false);
            response.put("mensajeGeneral", "Error al validar credenciales: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    
        return response;
    }
    

    

}
