package com.farmacia.proyecto.controlador;

import com.farmacia.proyecto.modelo.Producto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ProductoController {

    @Autowired
    private Conexion conexion;


    @GetMapping("/Productos")
    public String mostrarProductos(@RequestParam(value = "query", required = false) String query, Model model) {
        List<Producto> productos;
        if (query != null && !query.isEmpty()) {
            productos = buscarProductos(query); // Método para buscar productos por nombre
        } else {
            productos = obtenerProductos(); // Método para obtener todos los productos
        }
        model.addAttribute("productos", productos);
        
        // Check if the request is from Ajax
        if (query != null) {
            return "productos :: product-gallery"; // Solo devuelve la parte de la galería de productos
        }
        
        return "productos"; // Devolver la página completa de productos
    }



    // Método para obtener todos los productos
    private List<Producto> obtenerProductos() {
        List<Producto> productos = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_productos(?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getLong("ID"));
                    producto.setNombre(rs.getString("NOMBRE"));
                    producto.setDescripcion(rs.getString("DESCRIPCION"));
                    producto.setFechaVencimiento(rs.getDate("FECHAVENCIMIENTO"));
                    producto.setCosto(rs.getDouble("COSTO"));
                    producto.setCantidad(rs.getInt("CANTIDAD"));
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

    // Método para buscar productos por nombre
    private List<Producto> buscarProductos(String query) {
        List<Producto> productos = new ArrayList<>();
        String procedimiento = "{ call sp_buscar_productos(?, ?) }"; // Procedimiento almacenado para buscar

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.setString(1, query);
            stmt.registerOutParameter(2, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getLong("ID"));
                    producto.setNombre(rs.getString("NOMBRE"));
                    producto.setDescripcion(rs.getString("DESCRIPCION"));
                    producto.setFechaVencimiento(rs.getDate("FECHAVENCIMIENTO"));
                    producto.setCosto(rs.getDouble("COSTO"));
                    producto.setCantidad(rs.getInt("CANTIDAD"));
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }
}
