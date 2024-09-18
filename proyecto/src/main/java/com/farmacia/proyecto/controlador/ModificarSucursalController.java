package com.farmacia.proyecto.controlador;
import com.farmacia.proyecto.modelo.Sucursal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ModificarSucursalController {
    
    @Autowired
    private Conexion conexion;

    @GetMapping("/ModificarSucursal")
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
        
        return "ModificarSucursal"; // Devolver la página completa de sucursales
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


    @PutMapping("/ModificarSucursal/{id}")
    public ResponseEntity<String> modificarSucursal(
        @PathVariable("id") int id,
        @RequestBody Sucursal sucursalModificada) {

        // Lógica para modificar la sucursal
        boolean modificada = modificar(id, sucursalModificada);

        if (modificada) {
            return ResponseEntity.ok("Sucursal modificada exitosamente.");
        } 
        else 
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Sucursal no encontrada.");
        }
    }
    
    private boolean modificar(int Id, Sucursal sucursalModificada){

        String procedimiento = "{ call actualizar_sucursal(?, ?, ?, ?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            // Establecer los parámetros del procedimiento almacenado
            stmt.setInt(1, Id);  // El ID de la sucursal
            stmt.setString(2, sucursalModificada.getNombre());  // El nuevo nombre de la sucursal
            stmt.setString(3, sucursalModificada.getProvincia());  // La nueva provincia de la sucursal
            stmt.setString(4, sucursalModificada.getTelefono());  // El nuevo teléfono de la sucursal
            stmt.execute();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
