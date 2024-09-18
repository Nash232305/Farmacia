package com.farmacia.proyecto.controlador;

import com.farmacia.proyecto.modelo.Empleado;
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
public class EliminarEmpleadoController {
    
    @Autowired
    private Conexion conexion;

    @GetMapping("/EliminarEmpleado")
    public String mostrarEmpleados(@RequestParam(value = "query", required = false) String query, Model model) {
        List<Empleado> empleados;
        if (query != null && !query.isEmpty()) {
            empleados = buscarEmpleados(query); // Método para buscar empleados
        } else {
            empleados = obtenerEmpleados(); // Método para obtener todos los empleados
        }
        model.addAttribute("empleados", empleados);
        
        // Comprobar si la solicitud es de Ajax
        if (query != null) {
            return "Empleados :: empleado-gallery"; // Solo devuelve la parte de la galería de empleados
        }
        
        return "EliminarEmpleado"; // Devolver la página completa de empleados
    }

    // Método para obtener todos los empleados
    public List<Empleado> obtenerEmpleados() {
        List<Empleado> empleados = new ArrayList<>();
        String procedimiento = "{ call PKG_Empleado_Farmacia_CRUD.obtener_empleados (?) }"; // Asumiendo que el paquete está en el esquema por defecto
    
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
    
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
    
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Empleado empleado = new Empleado();
                    empleado.setId(rs.getLong("ID"));
                    empleado.setCedula(rs.getString("CEDULA"));
                    empleado.setNombre(rs.getString("NOMBRE"));
                    empleado.setApellido(rs.getString("APELLIDO"));
                    empleado.setSexo(rs.getString("SEXO").charAt(0)); // Asegúrate de que SEXO sea un CHAR o VARCHAR
                    empleado.setEdad(rs.getInt("EDAD"));
                    empleado.setSalario(rs.getDouble("SALARIO"));
                    empleado.setEmail(rs.getString("EMAIL"));
                    empleado.setNumeroTelefono(rs.getString("NUMEROTELEFONO"));
                    empleado.setEstado(rs.getString("ESTADO").charAt(0)); // Asegúrate de que ESTADO sea un CHAR o VARCHAR
                    empleado.setIdSucursal(rs.getInt("IDSUCURSAL"));
                    empleados.add(empleado);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return empleados;
    }

    // Método para buscar empleados
    private List<Empleado> buscarEmpleados(String query) {
        List<Empleado> empleados = new ArrayList<>();
        String procedimiento = "{ call PKG_Empleado_Farmacia_CRUD.buscar_empleados(?, ?) }"; // Nombre del procedimiento almacenado
    
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
    
            // Establece el parámetro de entrada
            stmt.setString(1, query);
            // Registra el parámetro de salida
            stmt.registerOutParameter(2, java.sql.Types.REF_CURSOR);
            // Ejecuta el procedimiento
            stmt.execute();
    
            // Obtiene el resultado del cursor
            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {
                    Empleado empleado = new Empleado();
                    empleado.setId(rs.getLong("ID"));
                    empleado.setCedula(rs.getString("CEDULA"));
                    empleado.setNombre(rs.getString("NOMBRE"));
                    empleado.setApellido(rs.getString("APELLIDO"));
                    empleado.setSexo(rs.getString("SEXO").charAt(0));
                    empleado.setEdad(rs.getInt("EDAD"));
                    empleado.setSalario(rs.getDouble("SALARIO"));
                    empleado.setEmail(rs.getString("EMAIL"));
                    empleado.setNumeroTelefono(rs.getString("NUMEROTELEFONO"));
                    empleado.setEstado(rs.getString("ESTADO").charAt(0));
                    empleado.setIdSucursal(rs.getInt("IDSUCURSAL"));
                    empleados.add(empleado);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return empleados;
    }

    @DeleteMapping("/EliminarEmpleado/{cedula}")
    public ResponseEntity<String> deleteEmpleado(@PathVariable("cedula") String cedula) {
        System.out.println("Eliminar empleado con cédula: " + cedula);
        
        // Lógica para eliminar el empleado
        boolean isDeleted = eliminarEmpleado(cedula); // Suponiendo que tienes un procedimiento almacenado para esto
    
        if (isDeleted) {
            return ResponseEntity.ok("Empleado eliminado");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Empleado no encontrado");
        }
    }

    private boolean eliminarEmpleado(String cedula) {
        String procedimiento = "{ call PKG_Empleado_Farmacia_CRUD.Eliminar_Empleado(?, ?) }";
    
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
    
            // Registrar el parámetro de salida
            stmt.setString(1, cedula);
            stmt.registerOutParameter(2, java.sql.Types.INTEGER); // Cambia el tipo si es diferente
    
            // Ejecutar la llamada
            stmt.execute();
    
            // Obtener el resultado después de la ejecución
            int resultado = stmt.getInt(2);
            System.out.println("Resultado: " + resultado);
    
            // Aquí puedes agregar lógica para manejar el resultado
    
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
}
