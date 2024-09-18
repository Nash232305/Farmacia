package com.farmacia.proyecto.controlador;

import com.farmacia.proyecto.modelo.Empleado;
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
public class ModificarEmpleadoController {

    @Autowired
    private Conexion conexion;

    @GetMapping("/ModificarEmpleado")
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

        return "ModificarEmpleado"; // Devolver la página completa de empleados
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

    @PutMapping("/ModificarEmpleado/{id}")
    public ResponseEntity<String> modificarEmpleado(
            @PathVariable("id") long id,
            @RequestBody Empleado empleadoModificado) {

        // Lógica para modificar el empleado
        boolean modificada = modificar(id, empleadoModificado);

        if (modificada) {
            return ResponseEntity.ok("Empleado modificado exitosamente.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Empleado no encontrado.");
        }
    }

    private boolean modificar(long id, Empleado empleadoModificado) {

        String procedimiento = "{ call PKG_Empleado_Farmacia_CRUD.Modificar_Empleado(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            // Establecer los parámetros del procedimiento almacenado
            System.out.println("Cedula: " + empleadoModificado.getCedula());
            System.out.println("Nombre: " + empleadoModificado.getNombre());
            System.out.println("Apellido: " + empleadoModificado.getApellido());
            System.out.println("Sexo: " + empleadoModificado.getSexo());
            System.out.println("Edad: " + empleadoModificado.getEdad());
            System.out.println("Salario: " + empleadoModificado.getSalario());
            System.out.println("Email: " + empleadoModificado.getEmail());
            System.out.println("NumeroTelefono: " + empleadoModificado.getNumeroTelefono());
            System.out.println("IdSucursal: " + empleadoModificado.getIdSucursal());

            
            stmt.setString(1, empleadoModificado.getCedula()); // El Cedula del empleado
            stmt.setString(2, empleadoModificado.getNombre()); // El nuevo nombre del empleado
            stmt.setString(3, empleadoModificado.getApellido()); // El nuevo apellido del empleado
            stmt.setString(4, String.valueOf(empleadoModificado.getSexo())); // El nuevo sexo del empleado
            stmt.setInt(5, empleadoModificado.getEdad()); // La nueva edad del empleado
            stmt.setDouble(6, empleadoModificado.getSalario()); // El nuevo salario del empleado
            stmt.setString(7, empleadoModificado.getEmail()); // El nuevo email del empleado
            stmt.setString(8, empleadoModificado.getNumeroTelefono()); // El nuevo teléfono del empleado
            stmt.setInt(9, empleadoModificado.getIdSucursal()); // La nueva sucursal del empleado
    
            // Registrar el parámetro de salida
            stmt.registerOutParameter(10, java.sql.Types.NUMERIC);

            stmt.execute();

            // Obtener el valor del parámetro de salida
            int resultado = stmt.getInt(10);
            System.out.println("Resultado" + resultado);
            return resultado == 1;           

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
