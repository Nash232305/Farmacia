package com.farmacia.proyecto.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ReportesController {

    @Autowired
    private Conexion conexion; // Inyecta tu clase Conexion

    // Método para obtener el resumen de productos desde el procedimiento almacenado
    private List<Integer> obtenerResumenProductos() {
        List<Integer> resumen = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_resumen_productos(?, ?, ?, ?) }";
        Connection conn = null;

        try {
            conn = conexion.conectar(); // Usa tu método de conexión
            CallableStatement stmt = conn.prepareCall(procedimiento);

            // Registrar parámetros de salida
            stmt.registerOutParameter(1, java.sql.Types.INTEGER); // Total de productos
            stmt.registerOutParameter(2, java.sql.Types.INTEGER); // Productos con stock bajo
            stmt.registerOutParameter(3, java.sql.Types.INTEGER); // Productos próximos a vencer
            stmt.registerOutParameter(4, java.sql.Types.INTEGER); // Sucursales activas

            // Ejecutar el procedimiento
            stmt.execute();

            // Añadir los resultados a la lista
            resumen.add(stmt.getInt(1)); // Total de productos
            resumen.add(stmt.getInt(2)); // Productos con stock bajo
            resumen.add(stmt.getInt(3)); // Productos próximos a vencer
            resumen.add(stmt.getInt(4)); // Sucursales activas

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Asegura que la conexión se cierre
            conexion.desconectar(conn);
        }
        return resumen;
    }

    private List<Map<String, Object>> obtenerProductosProximosVencer() {
        List<Map<String, Object>> productos = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_productos_proximos_a_vencer(?) }";

        try (Connection conn = conexion.conectar();
            CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Map<String, Object> producto = new HashMap<>();
                    producto.put("id", rs.getInt("ID"));
                    producto.put("nombre", rs.getString("NOMBRE"));
                    producto.put("descripcion", rs.getString("DESCRIPCION"));
                    producto.put("fechaVencimiento", rs.getDate("FECHAVENCIMIENTO"));
                    producto.put("cantidad", rs.getInt("CANTIDAD"));
                    producto.put("nombreSucursal", rs.getString("NOMBRE_SUCURSAL"));
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }


    @GetMapping("/ReportesProductos")
    public String mostrarResumen(Model model) {
        // Llamar a la función para obtener los datos del resumen
        List<Integer> resumen = obtenerResumenProductos();

        // Añadir los resultados al modelo para la vista
        if (resumen.size() == 4) {
            model.addAttribute("totalProductos", resumen.get(0));
            model.addAttribute("stockBajo", resumen.get(1));
            model.addAttribute("proximosVencer", resumen.get(2));
            model.addAttribute("sucursalesActivas", resumen.get(3));
        } else {
            model.addAttribute("error", "No se pudieron obtener los datos del resumen.");
        }

        // Llamar a la función para obtener los productos próximos a vencer
        List<Map<String, Object>> proximosVencer = obtenerProductosProximosVencer();
        model.addAttribute("productosProximosVencer", proximosVencer);

        // Retornar la vista correspondiente
        return "ReportesProductos"; // Asegúrate de tener una vista llamada ReportesProductos.html
    }

    @GetMapping("/ReporteInventario")
    public String mostrarReporteInventario(Model model) {
        // Obtener datos para los gráficos (Productos por sucursal)
        List<Map<String, Object>> productosXSucursal = obtenerProductosPorGraficacion();
        model.addAttribute("productosXSucursal", productosXSucursal);

        // Obtener todos los productos de todas las sucursales
            List<Map<String, Object>> productosDeSucursal = obtenerProductosDeSucursal(-1); // Pasamos -1 para obtener todos los productos
            model.addAttribute("productosDeSucursal", productosDeSucursal);

            // Obtener productos agrupados por sucursal
        List<Map<String, Object>> productosAgrupadosPorSucursal = obtenerProductosAgrupadosPorSucursal();
        model.addAttribute("productosXSucursal", productosAgrupadosPorSucursal);

        // Obtener etiquetas y datos para el gráfico
        List<String> labels = new ArrayList<>();
        List<Integer> data = new ArrayList<>();

        for (Map<String, Object> sucursal : productosAgrupadosPorSucursal) {
            labels.add((String) sucursal.get("NombreSucursal"));

            // Verificar si "productos" es realmente una lista de mapas antes de castear
            Object productosObj = sucursal.get("productos");
            if (productosObj instanceof List<?>) {
                List<?> productosList = (List<?>) productosObj;

                // Verificar si los elementos de la lista son del tipo esperado
                int totalProductos = 0;
                for (Object item : productosList) {
                    if (item instanceof Map) {
                        totalProductos++;
                    }
                }

                data.add(totalProductos);
            } else {
                // Manejo del error si el tipo no es el esperado
                System.err.println("Error: 'productos' no es una lista de mapas.");
                data.add(0); // Agrega un valor por defecto si hay un error
            }
        }

        model.addAttribute("labels", labels);
        model.addAttribute("data", data);

            // Retorna la vista correspondiente
            return "ReporteInventario";
    }

    // Métodos del controlador para llamar a los SPs
    private List<Map<String, Object>> obtenerProductosPorGraficacion() {
        List<Map<String, Object>> productosGraficacion = new ArrayList<>();
        String procedimiento = "{ call SP_ProductosGraficacion(?) }";

        try (Connection conn = conexion.conectar();
            CallableStatement stmt = conn.prepareCall(procedimiento)) {
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Map<String, Object> producto = new HashMap<>();
                    producto.put("NombreSucursal", rs.getString("NombreSucursal"));
                    producto.put("ProductoNombre", rs.getString("ProductoNombre"));
                    producto.put("CantidadDisponible", rs.getInt("CantidadDisponible"));

                    productosGraficacion.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productosGraficacion;
    }

    private List<Map<String, Object>> obtenerProductosAgrupadosPorSucursal() {
        List<Map<String, Object>> productosXSucursal = obtenerProductosPorGraficacion();
        Map<String, List<Map<String, Object>>> agrupadosPorSucursal = new HashMap<>();
    
        // Agrupar productos por sucursal
        for (Map<String, Object> producto : productosXSucursal) {
            String sucursalNombre = (String) producto.get("NombreSucursal");
            agrupadosPorSucursal.computeIfAbsent(sucursalNombre, k -> new ArrayList<>()).add(producto);
        }
    
        // Imprimir para depurar
        System.out.println("Agrupados por Sucursal: " + agrupadosPorSucursal);
    
        // Convertir el Map agrupado en una lista para Thymeleaf
        List<Map<String, Object>> sucursalesAgrupadas = new ArrayList<>();
        for (Map.Entry<String, List<Map<String, Object>>> entry : agrupadosPorSucursal.entrySet()) {
            Map<String, Object> sucursalMap = new HashMap<>();
            sucursalMap.put("NombreSucursal", entry.getKey());
            sucursalMap.put("productos", entry.getValue());
            sucursalesAgrupadas.add(sucursalMap);
        }
    
        // Imprimir la lista final
        System.out.println("Sucursales Agrupadas: " + sucursalesAgrupadas);
    
        return sucursalesAgrupadas;
    }
    
    

    private List<Map<String, Object>> obtenerProductosDeSucursal(int idSucursal) {
        List<Map<String, Object>> productosDeSucursal = new ArrayList<>();
        String procedimiento = "{ call SP_ProductoSucursal(?, ?) }";

        try (Connection conn = conexion.conectar();
            CallableStatement stmt = conn.prepareCall(procedimiento)) {
            stmt.setInt(1, idSucursal); // Si idSucursal es -1, obtendrá todos los productos
            stmt.registerOutParameter(2, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {
                    Map<String, Object> producto = new HashMap<>();
                    producto.put("NombreSucursal", rs.getString("NombreSucursal"));
                    producto.put("ProvinciaSucursal", rs.getString("ProvinciaSucursal"));
                    producto.put("TelefonoSucursal", rs.getString("TelefonoSucursal"));
                    producto.put("ProductoID", rs.getInt("ProductoID"));
                    producto.put("ProductoNombre", rs.getString("ProductoNombre"));
                    producto.put("ProductoDescripcion", rs.getString("ProductoDescripcion"));
                    producto.put("ProductoCosto", rs.getDouble("ProductoCosto"));
                    producto.put("FabricanteNombre", rs.getString("FabricanteNombre"));
                    producto.put("CantidadDisponible", rs.getInt("CantidadDisponible"));

                    productosDeSucursal.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productosDeSucursal;
    }


    
    
}
