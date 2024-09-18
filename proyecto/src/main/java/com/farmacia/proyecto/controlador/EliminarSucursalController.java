package com.farmacia.proyecto.controlador;
import com.farmacia.proyecto.modelo.Sucursal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class EliminarSucursalController {
    
    @Autowired
    private Conexion conexion;

    @GetMapping("/EliminarSucursal")
    public String mostrarSucursales(@RequestParam(value = "query", required = false) String query, Model model) {
        List<Sucursal> sucursales;
        if (query != null && !query.isEmpty()) {
            sucursales = buscarSucursales(query); // Método para buscar sucursales
        } else {
            sucursales = obtenerSucursales(); // Método para obtener todas las sucursales
        }
        model.addAttribute("sucursales", sucursales);
        
        // Comprobar si la solicitud es de Ajax
        if (query != null) {
            return "Sucursales :: sucursal-gallery"; // Solo devuelve la parte de la galería de sucursales
        }
        
        return "EliminarSucursal"; // Devolver la página completa de sucursales
    }

    // Método para obtener todas las sucursales
    private List<Sucursal> obtenerSucursales() {
        List<Sucursal> sucursales = new ArrayList<>();
        String procedimiento = "{ call obtener_sucursales_farmacia(?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sucursales;
    }

    // Método para buscar sucursales
    private List<Sucursal> buscarSucursales(String query) {
        List<Sucursal> sucursales = new ArrayList<>();
        String procedimiento = "{ call buscar_sucursales_farmacia(?, ?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.setString(1, query);
            stmt.registerOutParameter(2, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sucursales;
    }

    @DeleteMapping("/EliminarSucursal/{id}")
    public ResponseEntity<String> deleteSucursal(@PathVariable("id") int id) {
        // Aquí va la lógica para eliminar la sucursal
        System.out.println("Eliminar sucursal con ID: " + id);
        
        // Lógica para eliminar la sucursal (por ejemplo, eliminando de la base de datos)
        boolean isDeleted = eliminarSucursal(id); // Suponiendo que tienes un servicio
    
        if (isDeleted) {
            return ResponseEntity.ok("Sucursal eliminada");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Sucursal no encontrada");
        }
    }

    private boolean eliminarSucursal(int Id){

        String procedimiento = "{ call eliminar_sucursal_logico(?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.setInt(1, Id);
            stmt.execute();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
