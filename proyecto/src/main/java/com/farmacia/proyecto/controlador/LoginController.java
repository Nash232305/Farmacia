package com.farmacia.proyecto.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.farmacia.proyecto.modelo.Sucursal;

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
}
