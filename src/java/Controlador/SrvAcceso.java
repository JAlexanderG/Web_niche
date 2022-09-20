package Controlador;

import Modelo.Usuarios;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SrvAcceso extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Usuarios usuarios = new Usuarios();
        HttpSession sesion = request.getSession();

        String accion = request.getParameter("accion");
        String mensaje;
        
        
        if (accion.equals("ingresar")) {
                String correo = request.getParameter("txt_correo");
                String pass = request.getParameter("txt_pass");

                switch (usuarios.loguear(correo, pass)) {
                    case 1:
                        sesion.setAttribute("correo", correo);
                        sesion.setAttribute("rol", "1");
                        mensaje = "";
                        sesion.setAttribute("error", mensaje);
                        sesion.setAttribute("empleado", usuarios);
                        response.sendRedirect("admin.jsp");
                        break;
                    case 2:
                        sesion.setAttribute("correo", correo);
                        sesion.setAttribute("rol", "2");
                        mensaje = "";
                        sesion.setAttribute("error", mensaje);
                        sesion.setAttribute("empleado", usuarios);
                        response.sendRedirect("admin.jsp");
                        break;
                    default:
                        mensaje = "Credenciales invalidas";
                        sesion.setAttribute("error", mensaje);
                        response.sendRedirect("login.jsp");
                        break;
                }

            } else if (accion.equals("cerrar")) {
            sesion.invalidate();
            response.sendRedirect("login.jsp");
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
