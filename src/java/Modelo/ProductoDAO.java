
package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ProductoDAO {
    
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    
    public List listar() {      
        List<Producto> lista = new ArrayList();
        String sql = "select p.id_producto, p.nombre, p.detalle, p.marca, p.talla, p.color, p.precio, p.imagen, p.estado, p.fecha_ingreso, c.descripcion as categoria, p.id_categoria, pr.descripcion as promocion, p.id_promocion, e.nombres as empleado, p.id_empleado from productos p inner join categorias c on p.id_categoria = c.id_categoria inner join promociones pr on p.id_promocion = pr.id_promocion inner join empleados e on p.id_empleado = e.id_empleado;";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto p = new Producto();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDetalle(rs.getString("detalle"));
                p.setMarca(rs.getString("marca"));
                p.setTalla(rs.getString("talla"));
                p.setColor(rs.getString("color"));
                p.setPrecio(rs.getInt("precio"));
                p.setImagen(rs.getBinaryStream("imagen"));
                p.setEstado(rs.getInt("estado"));
                p.setFecha(rs.getString("fecha_ingreso"));
                p.setCategoria(rs.getString("categoria"));
                p.setId_categoria(rs.getInt("id_categoria"));
                p.setPromocion(rs.getString("promocion"));
                p.setId_promocion(rs.getInt("id_promocion"));
                p.setEmpleado(rs.getString("empleado"));
                p.setId_empleado(rs.getInt("id_empleado"));
                lista.add(p);                
            }
        cn.cerrar_conexion();
        } catch (Exception e) {
        }
        return lista;
    }
    
    
}
