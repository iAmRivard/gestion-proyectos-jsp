
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="conexion.jsp"%>

<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis casos asignados</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


    </head>
    <body>
        <%            st = conexion.prepareStatement("select porcentaje_avance "
                    + "from caso where id_caso=?");
            st.setString(1, request.getParameter("id_caso"));

            ResultSet porcentaje = st.executeQuery();
            String porc_avance;
            if (porcentaje.next()) {
                porc_avance = porcentaje.getString(1);
            } else {
                porc_avance = "0";
            }

        %>




        <%//Incluimos el menú con las opciones para el programador%>


        <%
            if (sesion_usuario.getAttribute("rol").equals("Programador")) { %>
        <%@ include file="include/menu_programador.jsp"%>

        <%  } else if (sesion_usuario.getAttribute("rol").equals("Empleado de área")) { %>
        <%@ include file="include/menu_empleado.jsp"%>

        <%   } else if (sesion_usuario.getAttribute("rol").equals("Jefe de desarrollo")) { %>
        <%@ include file="include/menu_jefe_sistemas.jsp"%>

        <%     }
        %>

        <h1 class="text-center mt-3 mb-3" style="margin-left:70px;">Bitacora de caso</h1>

        <p class="text-center mt-3 mb-3" style="font-size:18px;margin-left:70px;" >En esta página se muestran las bitácoras
            del caso seleccionado.</p>


        <sql:query var="bitacora" dataSource="jdbc/mysql">

            select observacion,fecha,id_entrada
            from bitacora_caso
            where id_caso=?

            <sql:param value="${param.id_caso}" />
        </sql:query>

        <% if (sesion_usuario.getAttribute("rol").equals("Programador")) {%>
        <div class="mt-5 mb-5">
            <h3 class="text-center">Formulario para agregar nueva bitácora.</h3>
            <div class="d-flex justify-content-center mt-3 mb-3">

                <form action="agregar_bitacora.jsp" method="post" class="w-50"> 

                    <div class="form-group">
                        <label for="observacion">Ingrese la observación de la nueva bitácora</label>
                        <textarea class="form-control textarea" id="descripcion" name="observacion" rows="3" ></textarea>
                    </div>


                    <div class="form-group">
                        <label for="avance">Porcentaje de avance del caso (modifiquelo si lo cree necesario)</label>
                        <input type="number" class="form-control" min="0" max="100" name="avance" value="<%=porc_avance%>">
                    </div>

                    <input type="hidden" value="<%=request.getParameter("id_caso")%>" name="id_caso">

                    <div class="d-flex justify-content-center mt-3 mb-3">
                        <input type="submit" class="btn btn-success" value="Ingresar nueva bitácora">
                    </div>

                </form>

            </div>
        </div>                
        <% } %>

        <h3 class="text-center">Lista de bitácoras del caso.</h3>
        <div class="d-flex justify-content-center w-100" >    

            <table id="tabla_solicitudes" class="w-100 table table-striped table-bordered" style="width:100%;">
                <thead>
                    <tr>
                        <th>Descripción de caso</th>
                        <th>Fecha de inicio</th>
   
                            <% if (sesion_usuario.getAttribute("rol").equals("Programador")) { %>

                        <th>Actualizar</th>
                        <th>Eliminar</th>
                            <% } %>

                    </tr>
                </thead>
                <tbody>

                    <c:forEach var="bitacora" items="${bitacora.rowsByIndex}">
                        <tr>

                            <td><c:out value="${bitacora[0]}"/></td>
                            <td><c:out value="${bitacora[1]}"/></td>
                            <% if (sesion_usuario.getAttribute("rol").equals("Programador")) { %>
                            <td>
                                <div class="d-flex justify-content-center flex-wrap">
                                    <a href="formulario_actualizar_bitacora.jsp?id_bitacora=${bitacora[2]}" >Actualizar</a>
                                </div>
                            </td>
                            <td>
                                <div class="d-flex justify-content-center flex-wrap">
                                    <a href="eliminar_bitacora.jsp?id_bitacora=${bitacora[2]}" >Eliminar</a>
                                </div>
                            </td>
                            <% } %>
                        </tr>

                    </c:forEach>


                </tbody>

            </table>
        </div>

        <div class="d-flex justify-content-center mt-3 mb-3">

            <%
                if (sesion_usuario.getAttribute("rol").equals("Programador")) {
                    out.println("<a class='btn btn-primary' style='color:white;' href='casos_asignados.jsp'>Regresar a casos asignados</a>");

                } else if (sesion_usuario.getAttribute("rol").equals("Empleado de área")) {
                    out.println("<a class='btn btn-primary' style='color:white;' href='casos_asignados_empleado.jsp'>Regresar a casos asignados</a>");

                } else if (sesion_usuario.getAttribute("rol").equals("Jefe de desarrollo")) {
                    out.println("<a class='btn btn-primary' style='color:white;' href='casos.jsp'>Regresar a casos</a>");
                }
            %>
        </div>

    </body>
</html>
