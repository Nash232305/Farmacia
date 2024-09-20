package com.farmacia.proyecto.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.farmacia.proyecto.modelo.ReporteProductoPF;
import com.farmacia.proyecto.modelo.Sucursal;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

@Controller
public class ReporteProductoPFController {

    @Autowired
    private Conexion conexion;
    @Autowired
    private JdbcTemplate jdbcTemplate; // Inyecta JdbcTemplate

    @GetMapping("/ReporteProductoPF")
    public String mostrarReporteProductoPF(@RequestParam(value = "query", required = false) String query, Model model) {
        List<ReporteProductoPF> reporteProductoPF = obtenerReporteProductoPF();
        model.addAttribute("reporteProductoPF", reporteProductoPF);  // Agrega la lista al modelo
        
        return "ReporteProductoPF";  // Retorna el nombre de la vista HTML (ReporteProductoPF.html)
    }

    // Método para obtener todas las sucursales
    private List<ReporteProductoPF> obtenerReporteProductoPF() {
        List<ReporteProductoPF> ReporteProductoPF = new ArrayList<>();
        String procedimiento = "{ call SP_ObtenerProductos(?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    ReporteProductoPF reporteProductoPF = new ReporteProductoPF();
                    reporteProductoPF.setIDProveedor(rs.getInt("IDProveedor"));
                    reporteProductoPF.setNombreProveedor(rs.getString("NombreProveedor"));
                    reporteProductoPF.setTelefonoProveedor(rs.getString("TelefonoProveedor"));
                    reporteProductoPF.setIDProducto(rs.getInt("IDProducto"));
                    reporteProductoPF.setNombreProducto(rs.getString("NombreProducto"));
                    reporteProductoPF.setDescripcionProducto(rs.getString("DescripcionProducto"));
                    reporteProductoPF.setNombreFabricante(rs.getString("NombreFabricante"));
                    reporteProductoPF.setCostoProducto(rs.getInt("CostoProducto"));
                    ReporteProductoPF.add(reporteProductoPF);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ReporteProductoPF;
    }
}

