package Controlador;

import Modelo.Empleado;
import Modelo.EmpleadoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SrvEmpleado extends HttpServlet {

    Empleado empleado;
    EmpleadoDAO empleadoDao = new EmpleadoDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");

        empleado = new Empleado(Integer.valueOf(request.getParameter("txt_id")), Integer.valueOf(request.getParameter("txt_cui")), request.getParameter("txt_nombres"),
                request.getParameter("txt_apellidos"), request.getParameter("txt_correo"), request.getParameter("txt_pass"),
                request.getParameter("txt_direccion"), Integer.valueOf(request.getParameter("txt_telefono")), request.getParameter("txt_fn"),
                Integer.valueOf(request.getParameter("drop_usuario")));

        if (accion.equals("agregar")) {
            if (empleadoDao.agregar(empleado) > 0) {
                response.sendRedirect("empleados.jsp");
            } else {
                request.getRequestDispatcher("admin.jsp");
            }
        }

        if (accion.equals("modificar")) {
            if (empleadoDao.modificar(empleado) > 0) {
                response.sendRedirect("empleados.jsp");
            } else {
                request.getRequestDispatcher("admin.jsp");
            }
        }
        
        
        if (accion.equals("eliminar")) {
            if (empleadoDao.eliminar(empleado) > 0) {
                response.sendRedirect("empleados.jsp");
            } else {
                request.getRequestDispatcher("admin.jsp");
            }
        }
        
        if (accion.equals("modificarUsuario")) {
            if (empleadoDao.modificar(empleado) > 0) {
                response.sendRedirect("SrvAcceso?accion=cerrar");
            } else {
                request.getRequestDispatcher("admin.jsp");
            }
        }
        

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
