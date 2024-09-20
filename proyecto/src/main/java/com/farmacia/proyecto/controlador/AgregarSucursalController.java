package com.farmacia.proyecto.controlador;

import com.farmacia.proyecto.modelo.Sucursal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PostMapping;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.Connection;
import java.sql.SQLException;


@Controller
public class AgregarSucursalController {
    
    @Autowired
    private Conexion conexion;

    @GetMapping("/AgregarSucursal")
    public String mostrarCrearSucursal() {
        return "AgregarSucursal"; // Retorna la vista CrearSucursal.html
    }

    
    @PostMapping("/AgregarSucursal")
    public ResponseEntity<String> agregarSucursal(
        @RequestBody Sucursal nuevaSucursal) {

        // Lógica para modificar la sucursal
        boolean modificada = agregar(nuevaSucursal);

        if (modificada) {
            return ResponseEntity.ok("Sucursal modificada exitosamente.");
        } 
        else 
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Sucursal no encontrada.");
        }
    }

    private boolean agregar(Sucursal nuevaSucursal){

        String procedimiento = "{ call crear_sucursal(?, ?, ?, ?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            
            // Crear la fecha actual
            java.util.Date utilDate = new java.util.Date();
            // Convertir java.util.Date a java.sql.Date
            Date sqlDate = new Date(utilDate.getTime());

            // Establecer los parámetros del procedimiento almacenado
            stmt.setString(1, nuevaSucursal.getNombre());  // El nuevo nombre de la sucursal
            stmt.setString(2, nuevaSucursal.getProvincia());  // La nueva provincia de la sucursal
            stmt.setString(3, nuevaSucursal.getTelefono());  // El nuevo teléfono de la sucursal
            stmt.setDate(4, sqlDate);
            stmt.execute();

        }
        catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

}
