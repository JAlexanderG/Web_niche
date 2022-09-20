<%@page import="java.util.List"%>
<%@page import="Modelo.Producto"%>
<%@page import="Modelo.ProductoDAO"%>
<%@page session="true"%>
<%@page import="java.util.HashMap"%>
<%@page import="Modelo.Usuario"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="Modelo.EmpleadoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/style-admin.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
              integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
        <title>Niche</title>
        <style>
            .btn-usuario{
                background-color: var(--color-fondo-oscuro);
                color: #fcbe6795;
                text-align: center;
                display: inline-block;
                font-size: 1.10rem;
                font-weight: bold;
                cursor: pointer;
                width: 160px;
                border-radius: 0.5rem;
                border: none;
                padding: 0.75rem;
                transition: all 0.1s ease-out;
            }
            .btn-usuario:hover{
                text-decoration: none;
                color: var(--color-primario);
                transform: scale(1.02, 1.02)
            }

            .btn-opcion-modal{
                background-color: var(--color-fondo-oscuro);
                color: #fcbe6795;
                text-align: center;
                display: inline-block;
                font-size: 1.10rem;
                font-weight: bold;
                cursor: pointer;
                width: 160px;
                border-radius: 0.5rem;
                border: none;
                padding: 0.75rem;
                transition: all 0.1s ease-out;
                width: 150px;
            }
            .btn-opcion-modal:hover{
                text-decoration: none;
                color: var(--color-primario);
                transform: scale(1.02, 1.02)
            }

        </style>
    </head>
    <body style="font-family:'Nunito Sans', sans-serif">
        <%
            HttpSession sesion = request.getSession();
            if ((sesion.getAttribute("correo") != null) && ((session.getAttribute("rol") == "1") || (session.getAttribute("rol") == "2"))) {
        %>  
        <header  class="cabecera">
            <div class="cabecera-grupo">                
                <h2 style="margin:0; font-size: 2rem">Bienvenid@ al Sistema ...</h2>
                <div class="dropdown">
                    <a style="color: #c04c71; font-size: 1.35rem" class="dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-user"></i>
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="SrvAcceso?accion=cerrar" >Salir</a>
                    </div>
                </div>
            </div>
        </header>

        <div class="contenedor">
            <section class="contenedor-nav">                
                <nav class="menu">
                    <span><b>MANTENIMIENTO</b></span>
                    <a href="admin.jsp">Inicio</a>
                    <a href="admin.jsp" >Pedidos</a>
                    <a href="admin.jsp" >Ventas</a>
                    <a href="productos.jsp" >Productos</a>
                    <span><b>ADMINISTRACION</b></span>
                    <a href="empleados.jsp">Empleados</a>
                    <a href="admin.jsp" >Informe Ventas</a>
                </nav>
            </section>
            <section class="contenedor-contenido">     
                <div class="encabezado-group">
                    <p>Productos<p>
                        <button type="button" class="btn-usuario" data-toggle="modal" data-target="#modal_empleado" onclick="limpiar()">Nuevo producto</button>
                </div>

                <div class="cont">

                    <div class="modal fade" id="modal_empleado" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 style="text-align: center;" class="modal-title" id="staticBackdropLabel">Datos empleado</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="SrvProducto" method="post" class="form-group">
                                        <label for="txt_id"><b>Código</b></label>                                            
                                        <input type="number" name="txt_id" id="txt_id" class="form-control" value="0" required readonly>
                                        <label for="txt_nombre"><b>Nombre</b></label>                                            
                                        <input type="text" name="txt_nombre" id="txt_nombre" class="form-control" required>
                                        <label for="txt_detalle"><b>Detalle</b></label>
                                        <input type="text" name="txt_detalle" id="txt_detalle" class="form-control" required>
                                        <label for="txt_marca"><b>Marca</b></label>
                                        <input type="text" name="txt_marca" id="txt_marca" class="form-control" required>
                                        <label for="txt_talla"><b>Talla</b></label>
                                        <input type="text" name="txt_talla" id="txt_talla" class="form-control" required>                                        
                                        <label for="txt_color"><b>Color</b></label>
                                        <input type="text" name="txt_color" id="txt_color" class="form-control" required>   
                                        <label for="txt_precio"><b>Precio</b></label>
                                        <input type="number" name="txt_precio" id="txt_precio" class="form-control" required>
                                        <label for="txt_estado"><b>Estado</b></label>                                            
                                        <input type="number" name="txt_estado" id="txt_estado" class="form-control" value="0" required readonly>
                                        
                                        
                                        <label for="txt_telefono"><b>Teléfono</b></label>
                                        <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" required>
                                        <label for="txt_fn"><b>Fecha nacimiento</b></label>
                                        <input type="date" name="txt_fn" id="txt_fn" class="form-control" required>
                                        <label for="drop_usuario"><b>Usuario</b></label><br>
                                        <select name="drop_usuario" id="drop_usuario" class="form-control">
                                            <%
                                                Usuario usuario = new Usuario();
                                                HashMap<String, String> drop = usuario.drop_usuario();
                                                for (String i : drop.keySet()) {
                                                    out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                                }
                                            %>
                                        </select>
                                        <br>
                                        <button type="submit" name="accion" class="btn-opcion-modal" value="agregar">Agregar</button>
                                        <button type="submit" name="accion" class="btn-opcion-modal" value="modificar">Modificar</button>
                                        <button type="submit" name="accion" class="btn-opcion-modal" value="eliminar" onclick="javascript:if (!confirm('¿Desea Eliminar?'))
                                                    return false">Eliminar</button>
                                    </form>
                                </div>                                
                            </div>
                        </div>
                    </div>
                </div>

                <section class="contenedor-tabla">
                    <table class="table">
                        <thead style="background-color: var(--color-fondo-oscuro); color: white" >
                            <tr>
                                <th scope="col">Código</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Marca</th>
                                <th scope="col">Talla</th>
                                <th scope="col">Color</th>
                                <th scope="col">Precio</th>
                                <th scope="col">Fecha ingreso</th>
                                <th scope="col">Categoria</th>
                                <th scope="col">Promoción</th>
                                <th scope="col">Empleado</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_productos">                         

                            <%                                
                                ProductoDAO productoDao = new ProductoDAO();
                                List<Producto> lista = productoDao.listar();

                                request.setAttribute("lista", lista);
                            %>  
                            <c:forEach var="dato" items="${lista}">
                                <tr data-id_categoria="${dato.getId_categoria()}" data-id_promocion="${dato.getId_promocion()}" data-id_empleado="${dato.getId_empleado()}">
                                    <td>${dato.getId_producto()}</td>
                                    <td>${dato.getNombre()}</td>
                                    <td style="display:none;">${dato.getDetalle()}</td>
                                    <td>${dato.getMarca()}</td>
                                    <td>${dato.getTalla()}</td>
                                    <td>${dato.getColor()}</td>
                                    <td>${dato.getPrecio()}</td>
                                    <td style="display:none;">${dato.getEstado()}</td>
                                    <td>${dato.getFecha()}</td>
                                    <td>${dato.getCategoria()}</td>
                                    <td>${dato.getPromocion()}</td>
                                    <td>${dato.getEmpleado()}</td>                                    
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </section>

            </section>




        </div>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
        <script>
                                            function limpiar() {
                                                $("#txt_id").val(0);
                                                $("#txt_cui").val('');
                                                $("#txt_nombres").val('');
                                                $("#txt_apellidos").val('');
                                                $("#txt_correo").val('');
                                                $("#txt_pass").val('');
                                                $("#txt_direccion").val('');
                                                $("#txt_telefono").val('');
                                                $("#txt_fn").val('');
                                                $("#drop_usuario").val(1);
                                            }


                                            $('#tbl_productos').on('click', 'tr td', function (evt) {
                                                var target, id, id_usuario, cui, nombres, apellidos, correo, password, direccion, telefono, nacimiento; // target, sirve para extraer los elementos de id, id_puesto
                                                target = $(event.target);
                                                id = target.parent().data('id');
                                                id_usuario = target.parent().data('id_usuario');
                                                cui = target.parent("tr").find("td").eq(0).html();
                                                nombres = target.parent("tr").find("td").eq(1).html();
                                                apellidos = target.parent("tr").find("td").eq(2).html();
                                                correo = target.parent("tr").find("td").eq(3).html();
                                                password = target.parent("tr").find("td").eq(4).html();
                                                direccion = target.parent("tr").find("td").eq(5).html();
                                                telefono = target.parent("tr").find("td").eq(6).html();
                                                nacimiento = target.parent("tr").find("td").eq(7).html();

                                                $("#txt_id").val(id);
                                                $("#txt_cui").val(cui);
                                                $("#txt_nombres").val(nombres);
                                                $("#txt_apellidos").val(apellidos);
                                                $("#txt_correo").val(correo);
                                                $("#txt_pass").val(password);
                                                $("#txt_direccion").val(direccion);
                                                $("#txt_telefono").val(telefono);
                                                $("#txt_fn").val(nacimiento);
                                                $("#drop_usuario").val(id_usuario);
                                                $("#modal_empleado").modal('show');
                                            });
        </script>



        <%            }

            
                else {
                response.sendRedirect("admin.jsp");
            }
        %> 
    </body> 

</html>
