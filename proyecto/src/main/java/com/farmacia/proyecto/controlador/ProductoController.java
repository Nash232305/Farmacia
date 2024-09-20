package com.farmacia.proyecto.controlador;

import com.farmacia.proyecto.modelo.Producto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
public class ProductoController {

    @Autowired
    private Conexion conexion;
    @Autowired
    private JdbcTemplate jdbcTemplate; // Inyecta JdbcTemplate



    @GetMapping("/Productos")
    public String mostrarProductos(@RequestParam(value = "query", required = false) String query, Model model) {
        try {
            List<Producto> productos;
            if (query != null && !query.isEmpty()) {
                productos = buscarProductos(query); // Método para buscar productos
            } else {
                productos = obtenerProductos(); // Método para obtener todos los productos
            }
            model.addAttribute("productos", productos);

            // Comprobar si la solicitud es de Ajax
            if (query != null) {
                return "Productos :: product-gallery"; // Solo devuelve la parte de la galería de productos
            }

            return "Productos"; // Devolver la página completa de productos

        } catch (Exception e) {
            // Manejar excepción y registrar el error
            e.printStackTrace();
            model.addAttribute("error", "Ocurrió un error al procesar la solicitud.");
            return "error"; // Devolver a una página de error
        }
    }


    // Método para obtener todos los productos
    private List<Producto> obtenerProductos() {
        List<Producto> productos = new ArrayList<>();
        String procedimiento = "{ call PCK_CRUD_PRODUCTOS.sp_obtener_productos(?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("ID"));
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

    // Método para buscar productos
    private List<Producto> buscarProductos(String query) {
        List<Producto> productos = new ArrayList<>();
        String procedimiento = "{ call PCK_CRUD_PRODUCTOS.sp_buscar_productos(?, ?) }";

        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.setString(1, query);
            stmt.registerOutParameter(2, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("ID"));
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

    @GetMapping("/AgregarProducto")
    public String mostrarFormularioAgregarProducto(Model model) {
        model.addAttribute("producto", new Producto());

        // Obtener productos
        List<Producto> productos = obtenerIdsYNombreDeProductos();
        model.addAttribute("productos", productos);

        // Obtener proveedores
        List<Map<String, Object>> proveedores = obtenerIdsYNombreDeProveedores();
        model.addAttribute("proveedores", proveedores);

        // Obtener fabricantes
        List<Map<String, Object>> fabricantes = obtenerIdsYNombreDeFabricantes();
        model.addAttribute("fabricantes", fabricantes);

        // Obtener sucursales
        List<Map<String, Object>> sucursales = obtenerIdsYNombresDeSucursales();
        model.addAttribute("sucursales", sucursales);
        

        return "AgregarProducto";
    }

   
    @PostMapping("/AgregarProducto")
    public String agregarProducto(@ModelAttribute("producto") Producto producto, Model model) {
        // Validación del servidor
        if (producto.getId() <= 0 || 
            producto.getNombre() == null || producto.getNombre().isEmpty() ||
            producto.getDescripcion() == null || producto.getDescripcion().isEmpty() ||
            producto.getFechaVencimiento() == null ||  
            producto.getCosto() == null || producto.getCosto() <= 0 ||
            producto.getIdFabricante() <= 0 || producto.getIdProveedor() <= 0 ||
            producto.getCantidad() == null || producto.getCantidad() <= 0  ||
            producto.getIdSucursal() <= 0)
        {
                
            
            model.addAttribute("errorMessage", "Todos los campos son obligatorios y deben ser válidos.");
            cargarDatosParaVista(model);  // Recarga las listas necesarias
            return "AgregarProducto";
        }

        try {
            // Verifica si el ID del producto ya existe
            List<Integer> idsExistentes = obtenerIdsDeProductos();
            if (idsExistentes.contains(producto.getId())) {
                model.addAttribute("errorMessage", "El ID ya existe. Por favor, elija un ID diferente.");
                cargarDatosParaVista(model);  // Recarga las listas necesarias
                return "AgregarProducto";
            }

            // Verifica si el ID del proveedor y del fabricante existen
            if (!obtenerIdsDeProveedores().contains(producto.getIdProveedor())) {
                model.addAttribute("errorMessage", "El ID del proveedor no existe.");
                cargarDatosParaVista(model);  // Recarga las listas necesarias
                return "AgregarProducto";
            }
            if (!obtenerIdsDeFabricantes().contains(producto.getIdFabricante())) {
                model.addAttribute("errorMessage", "El ID del fabricante no existe.");
                cargarDatosParaVista(model);  // Recarga las listas necesarias
                return "AgregarProducto";
            }
            if (!obtenerIdsDeSucursales().contains(producto.getIdSucursal())) {
                model.addAttribute("errorMessage", "El ID de la sucursal no existe.");
                cargarDatosParaVista(model);  // Recarga las listas necesarias
                return "AgregarProducto";
                
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error en la validación de IDs: " + e.getMessage());
            cargarDatosParaVista(model);  // Recarga las listas necesarias
            return "AgregarProducto";
        }

        try {
            // Llamada directa al procedimiento almacenado usando JdbcTemplate
            String sql = "CALL PCK_CRUD_PRODUCTOS.C_PRODUCTO(?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?)";
            jdbcTemplate.update(sql,
                producto.getId(),
                producto.getNombre(),
                producto.getDescripcion(),
                producto.getFechaVencimiento().toString(), 
                producto.getCosto(),
                producto.getIdFabricante(),
                producto.getIdProveedor(),
                producto.getCantidad(),
                producto.getIdSucursal()
            );

            System.out.println("Producto agregado correctamente.");

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Error al guardar el producto: " + e.getMessage());
            cargarDatosParaVista(model);  // Recarga las listas necesarias
            return "AgregarProducto";
        }

        return "redirect:/Productos";
    }

    private void cargarDatosParaVista(Model model) {
        List<Producto> productos = obtenerIdsYNombreDeProductos();
        model.addAttribute("productos", productos);

        List<Map<String, Object>> proveedores = obtenerIdsYNombreDeProveedores();
        model.addAttribute("proveedores", proveedores);

        List<Map<String, Object>> fabricantes = obtenerIdsYNombreDeFabricantes();
        model.addAttribute("fabricantes", fabricantes);

        List<Map<String, Object>> sucursales = obtenerIdsYNombresDeSucursales();
        model.addAttribute("sucursales", sucursales);
    }   
    

    private List<Integer> obtenerIdsDeProductos() {
        List<Integer> ids = new ArrayList<>();
        String procedimiento = "{ call PCK_CRUD_PRODUCTOS.sp_obtener_ids_nombres_productos(?) }";
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    ids.add(rs.getInt("ID"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ids;
    }

    private List<Integer> obtenerIdsDeProveedores() {
        List<Integer> ids = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_ids_nombres_proveedores(?) }";
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    ids.add(rs.getInt("ID"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ids;
    }

    private List<Integer> obtenerIdsDeFabricantes() {
        List<Integer> ids = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_ids_nombres_fabricantes(?) }";
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    ids.add(rs.getInt("ID"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ids;
    }

    private List<Map<String, Object>> obtenerIdsYNombresDeSucursales() {
        List<Map<String, Object>> sucursal = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_sucursales_activas(?) }";
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
            
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Map<String, Object> sucursales = new HashMap<>();
                    sucursales.put("id", rs.getInt("ID"));
                    sucursales.put("nombre", rs.getString("NOMBRE"));
                    sucursal.add(sucursales);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sucursal;
    }
    

    private List<Integer> obtenerIdsDeSucursales() {
        List<Integer> sucursal = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_sucursales_activas(?) }";
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
            
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    sucursal.add(rs.getInt("ID"));  // Solo agrega el ID
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sucursal;
    }
    

    private List<Producto> obtenerIdsYNombreDeProductos() {
        List<Producto> productos = new ArrayList<>();
        String procedimiento = "{ call PCK_CRUD_PRODUCTOS.sp_obtener_ids_nombres_productos(?) }";
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("ID"));
                    producto.setNombre(rs.getString("NOMBRE"));
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

    private List<Map<String, Object>> obtenerIdsYNombreDeProveedores() {
        List<Map<String, Object>> proveedores = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_ids_nombres_proveedores(?) }";
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Map<String, Object> proveedor = new HashMap<>();
                    proveedor.put("id", rs.getInt("ID"));
                    proveedor.put("nombre", rs.getString("NOMBRE"));
                    proveedores.add(proveedor);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return proveedores;
    }

    private List<Map<String, Object>> obtenerIdsYNombreDeFabricantes() {
        List<Map<String, Object>> fabricantes = new ArrayList<>();
        String procedimiento = "{ call sp_obtener_ids_nombres_fabricantes(?) }";
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Map<String, Object> fabricante = new HashMap<>();
                    fabricante.put("id", rs.getInt("ID"));
                    fabricante.put("nombre", rs.getString("NOMBRE"));
                    fabricantes.add(fabricante);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fabricantes;
    }

    // Método para mostrar el formulario de modificación de productos
    @GetMapping("/ModificarProducto")
    public String mostrarFormularioModificarProducto(Model model) {
        // Obtener proveedores
        List<Map<String, Object>> proveedores = obtenerIdsYNombreDeProveedores();
        model.addAttribute("proveedores", proveedores);

        // Obtener fabricantes
        List<Map<String, Object>> fabricantes = obtenerIdsYNombreDeFabricantes();
        model.addAttribute("fabricantes", fabricantes);

        // Asegurar que se incluyen productos o mensajes si son necesarios
        model.addAttribute("productos", new ArrayList<Producto>());
        model.addAttribute("mensajeError", "Por favor, realice una búsqueda para modificar un producto.");
        
        return "ModificarProducto"; // Nombre del archivo HTML
    }

    


    @PostMapping("/buscarProducto")
    public String buscarProductoPorNombre(@RequestParam("nombreProducto") String nombreProducto, Model model) {
        List<Producto> productos = obtenerProductosPorNombre(nombreProducto);

        if (productos != null && !productos.isEmpty()) {
            model.addAttribute("productoEncontrado", true);
            model.addAttribute("productos", productos);
        } else {
            model.addAttribute("productoEncontrado", false);
            model.addAttribute("mensajeError", "El producto no existe.");
        }

        // Cargar los datos de proveedores y fabricantes para la vista
        model.addAttribute("proveedores", obtenerIdsYNombreDeProveedores());
        model.addAttribute("fabricantes", obtenerIdsYNombreDeFabricantes());

        return "ModificarProducto";
    }

    @PostMapping("/modificarProducto")
    public String modificarProducto(
            @RequestParam("id") int id,
            @RequestParam(value = "nombre", required = false) String nombreNuevo,
            @RequestParam(value = "descripcion", required = false) String descripcionNueva,
            @RequestParam(value = "fechaVencimiento", required = false) String fechaVencimientoNueva,
            @RequestParam(value = "costo", required = false) Double costoNuevo,
            @RequestParam(value = "idFabricante", required = false) Integer idFabricanteNuevo,
            @RequestParam(value = "idProveedor", required = false) Integer idProveedorNuevo,
            @RequestParam(value = "cantidad", required = false) Integer cantidadNueva,
            @RequestParam(value = "idSucursal", required = false) Integer idSucursalNuevo,
            Model model) {

        try {
            // Valida si el producto existe
            if (!productoExiste(id)) {
                model.addAttribute("mensajeError", "El producto no existe.");
                cargarDatosParaVista(model); // Carga de nuevo los datos necesarios
                return "ModificarProducto";
            }

            // Valida si los IDs del fabricante y proveedor son válidos
            if ((idProveedorNuevo != null && !idProveedorExiste(idProveedorNuevo)) || 
                (idFabricanteNuevo != null && !idFabricanteExiste(idFabricanteNuevo))) {
                model.addAttribute("mensajeError", "El ID del proveedor o fabricante no existe. Verifique los datos ingresados.");
                cargarDatosParaVista(model); // Carga de nuevo los datos necesarios
                return "ModificarProducto";
            }

            //valdiar si el id de la sucursal es valido
            if(idSucursalNuevo != null && !idSucursalExiste(idSucursalNuevo)){
                model.addAttribute("mensajeError", "El ID de la sucursal no existe. Verifique los datos ingresados.");
                cargarDatosParaVista(model); // Carga de nuevo los datos necesarios
                return "ModificarProducto";
            }

            // Procedimiento para modificar el producto
            String procedimiento = "{ call PCK_CRUD_PRODUCTOS.U_PRODUCTO(?, ?, ?, ?, ?, ?, ?, ?,?) }";

            try (Connection conn = conexion.conectar();
                CallableStatement stmt = conn.prepareCall(procedimiento)) {

                // Asignar parámetros al procedimiento
                stmt.setInt(1, id);
                stmt.setString(2, nombreNuevo != null && !nombreNuevo.isEmpty() ? nombreNuevo : null);
                stmt.setString(3, descripcionNueva != null && !descripcionNueva.isEmpty() ? descripcionNueva : null);

                // Manejo de la fecha de vencimiento
                if (fechaVencimientoNueva != null && !fechaVencimientoNueva.isEmpty()) {
                    stmt.setDate(4, java.sql.Date.valueOf(fechaVencimientoNueva));
                } else {
                    stmt.setNull(4, java.sql.Types.DATE);
                }

                stmt.setDouble(5, costoNuevo != null ? costoNuevo : null);
                stmt.setInt(6, idFabricanteNuevo != null ? idFabricanteNuevo : null);
                stmt.setInt(7, idProveedorNuevo != null ? idProveedorNuevo : null);
                stmt.setInt(8, cantidadNueva != null ? cantidadNueva : null);
                stmt.setInt(9, idSucursalNuevo != null ? idSucursalNuevo : null);

                stmt.execute();
                model.addAttribute("mensajeExito", "Producto modificado correctamente.");

            }
        } catch (SQLException e) {
            if (e.getErrorCode() == 2291) { // Código de error de clave foránea
                model.addAttribute("mensajeError", "El ID del proveedor o fabricante no existe. Verifique los datos ingresados.");
            } else {
                model.addAttribute("mensajeError", "Error al modificar el producto: " + e.getMessage());
            }
            return "ModificarProducto";
        }

        return "Productos";
    }



    // Método para verificar si el producto existe
    private boolean productoExiste(int id) {
        String sql = "SELECT COUNT(*) FROM PRODUCTO_FARMACIA WHERE ID = ?";
        int count = jdbcTemplate.queryForObject(sql, Integer.class, id);
        return count > 0;
    }

    // Método para verificar si el ID del proveedor existe
    private boolean idProveedorExiste(int idProveedor) {
        String sql = "SELECT COUNT(*) FROM PROVEEDOR_FARMACIA WHERE ID = ?";
        int count = jdbcTemplate.queryForObject(sql, Integer.class, idProveedor);
        return count > 0;
    }

    // Método para verificar si el ID del fabricante existe
    private boolean idFabricanteExiste(int idFabricante) {
        String sql = "SELECT COUNT(*) FROM FABRICANTE_FARMACIA WHERE ID = ?";
        int count = jdbcTemplate.queryForObject(sql, Integer.class, idFabricante);
        return count > 0;
    }

    private boolean idSucursalExiste(int idSucursal) {
        String sql = "SELECT COUNT(*) FROM SUCURSAL_FARMACIA WHERE ID = ?";
        int count = jdbcTemplate.queryForObject(sql, Integer.class, idSucursal);
        return count > 0;
    }

    private List<Producto> obtenerProductosPorNombre(String nombre) {
        List<Producto> productos = new ArrayList<>();
        String procedimiento = "{ call PCK_CRUD_PRODUCTOS.sp_obtener_producto_por_nombre(?, ?) }";
    
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
    
            stmt.setString(1, nombre);
            stmt.registerOutParameter(2, java.sql.Types.REF_CURSOR);
            stmt.execute();
    
            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {  // Cambiar de if a while para iterar sobre todos los resultados
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("ID"));
                    producto.setNombre(rs.getString("NOMBRE"));
                    producto.setDescripcion(rs.getString("DESCRIPCION"));
                    producto.setFechaVencimiento(rs.getDate("FECHAVENCIMIENTO"));
                    producto.setCosto(rs.getDouble("COSTO"));
                    producto.setCantidad(rs.getInt("CANTIDAD"));
                    producto.setIdFabricante(rs.getInt("IDFABRICANTE"));
                    producto.setIdProveedor(rs.getInt("IDPROVEEDOR"));
                    
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

    @GetMapping("/EliminarProducto")
    public String mostrarEliminarProductos(@RequestParam(value = "query", required = false) String query, Model model) {
        try {
            List<Producto> productos;
            if (query != null && !query.isEmpty()) {
                productos = buscarProductosEliminar(query); // Método para buscar productos
            } else {
                productos = obtenerProductosEliminar(); // Método para obtener todos los productos
            }
            model.addAttribute("productos", productos);

            // Comprobar si la solicitud es de Ajax
            if (query != null) {
                return "EliminarProducto :: product-gallery"; // Solo devuelve la parte de la galería de productos
            }

            return "EliminarProducto"; // Devolver la página completa de eliminación de productos

        } catch (Exception e) {
            // Manejar excepción y registrar el error
            e.printStackTrace();
            model.addAttribute("error", "Ocurrió un error al procesar la solicitud.");
            return "error"; // Devolver a una página de error
        }
    }


    

    // Método para obtener todos los productos con toda la información
    private List<Producto> obtenerProductosEliminar() {
        List<Producto> productos = new ArrayList<>();
        String procedimiento = "{ call PCK_CRUD_PRODUCTOS.sp_obtener_toda_info_productos(?) }";
    
        try (Connection conn = conexion.conectar();
             CallableStatement stmt = conn.prepareCall(procedimiento)) {
    
            stmt.registerOutParameter(1, java.sql.Types.REF_CURSOR);
            stmt.execute();
    
            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("ID"));
                    producto.setNombre(rs.getString("NOMBRE"));
                    producto.setDescripcion(rs.getString("DESCRIPCION"));
                    producto.setFechaVencimiento(rs.getDate("FECHAVENCIMIENTO"));
                    producto.setCosto(rs.getDouble("COSTO"));
                    producto.setIdFabricante(rs.getInt("IDFABRICANTE"));
                    producto.setIdProveedor(rs.getInt("IDPROVEEDOR"));
                    producto.setCantidad(rs.getInt("CANTIDAD"));
                    producto.setIdSucursal(rs.getInt("IDSUCURSAL"));
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

    // Método para buscar productos por nombre
    private List<Producto> buscarProductosEliminar(String query) {
        List<Producto> productos = new ArrayList<>();
        String procedimiento = "{ call PCK_CRUD_PRODUCTOS.sp_buscar_productos_por_nombreE(?, ?) }";

        try (Connection conn = conexion.conectar();
            CallableStatement stmt = conn.prepareCall(procedimiento)) {

            stmt.setString(1, query);  
            stmt.registerOutParameter(2, java.sql.Types.REF_CURSOR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("ID"));
                    producto.setNombre(rs.getString("NOMBRE"));
                    producto.setDescripcion(rs.getString("DESCRIPCION"));
                    producto.setFechaVencimiento(rs.getDate("FECHAVENCIMIENTO"));
                    producto.setCosto(rs.getDouble("COSTO"));
                    producto.setIdFabricante(rs.getInt("IDFABRICANTE"));
                    producto.setIdProveedor(rs.getInt("IDPROVEEDOR"));
                    producto.setCantidad(rs.getInt("CANTIDAD"));
                    producto.setIdSucursal(rs.getInt("IDSUCURSAL"));
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error ejecutando el procedimiento almacenado para buscar productos: " + e.getMessage());
            e.printStackTrace();
        }
        return productos;
    }
    
    @DeleteMapping("/EliminarProducto/{id}")
    @ResponseBody
    public ResponseEntity<String> eliminarProducto(@PathVariable Integer id) {
        try {
            String procedimiento = "{ call PCK_CRUD_PRODUCTOS.D_PRODUCTO(?) }";

            try (Connection conn = conexion.conectar();
                CallableStatement stmt = conn.prepareCall(procedimiento)) {

                // Elimina el producto solo por su ID
                stmt.setInt(1, id);
                stmt.execute();
            }
            return ResponseEntity.ok("Producto eliminado correctamente.");
        } catch (SQLException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al eliminar el producto: " + e.getMessage());
        }
    }





}
