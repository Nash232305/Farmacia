package com.farmacia.proyecto.controlador;

import com.farmacia.proyecto.modelo.Empleado;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

@Controller
public class AgregarEmpleadoController {

    @Autowired
    private Conexion conexion;

    @GetMapping("/AgregarEmpleado")
    public String mostrarCrearEmpleado() {
        return "AgregarEmpleado"; // Retorna la vista AgregarEmpleado.html
    }

    @PostMapping("/AgregarEmpleado")
    public ResponseEntity<String> agregarEmpleado(@RequestBody Empleado nuevoEmpleado) {
        // Lógica para agregar el empleado
        boolean agregado = agregar(nuevoEmpleado);

        if (agregado) {
            return ResponseEntity.ok("Empleado creado exitosamente.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al crear el empleado.");
        }
    }

    private boolean agregar(Empleado nuevoEmpleado) {
        String procedimiento = "{ call PKG_Empleado_Farmacia_CRUD.Crear_Empleado(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";
    
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
    
            // Imprimir los parámetros antes de ejecutar
            System.out.println("Parámetros:");
            System.out.println("Cedula: " + nuevoEmpleado.getCedula());
            System.out.println("Nombre: " + nuevoEmpleado.getNombre());
            System.out.println("Apellido: " + nuevoEmpleado.getApellido());
            System.out.println("Sexo: " + nuevoEmpleado.getSexo());
            System.out.println("Edad: " + nuevoEmpleado.getEdad());
            System.out.println("Salario: " + nuevoEmpleado.getSalario());
            System.out.println("Email: " + nuevoEmpleado.getEmail());
            System.out.println("Número de Teléfono: " + nuevoEmpleado.getNumeroTelefono());
            System.out.println("ID Sucursal: " + nuevoEmpleado.getIdSucursal());
            System.out.println("Usuario: " + nuevoEmpleado.getUsuario());
            System.out.println("Contraseña: " + nuevoEmpleado.getContrasena());
    
            // Establecer los parámetros del procedimiento almacenado
            stmt.setString(1, nuevoEmpleado.getCedula());
            stmt.setString(2, nuevoEmpleado.getNombre());
            stmt.setString(3, nuevoEmpleado.getApellido());
            stmt.setString(4, Character.toString(nuevoEmpleado.getSexo()));
            stmt.setInt(5, nuevoEmpleado.getEdad());
            stmt.setDouble(6, nuevoEmpleado.getSalario());
            stmt.setString(7, nuevoEmpleado.getEmail());
            stmt.setString(8, nuevoEmpleado.getNumeroTelefono());
            stmt.setInt(9, nuevoEmpleado.getIdSucursal());
            stmt.setString(10, nuevoEmpleado.getUsuario());
            stmt.setString(11, nuevoEmpleado.getContrasena());
    
            // Registrar el parámetro de salida
            stmt.registerOutParameter(12, java.sql.Types.NUMERIC);
    
            // Ejecutar el procedimiento
            stmt.execute();
    
            // Obtener el valor del parámetro de salida
            int resultado = stmt.getInt(12);
            return resultado == 1;
    
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
}
