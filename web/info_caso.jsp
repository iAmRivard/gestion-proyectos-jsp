
<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<%@ include file="conexion.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Información de caso</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/menu.css"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">

    </head>
    <body> 


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


        <%
            /*
        select tipo_caso.descripcion,solicitud_caso.descripcion,solicitud_caso.archivo_info,
e1.nombres,e2.nombres,caso.fecha_inicio,caso.fecha_final,estado_caso.Descripción,caso.porcentaje_avance
from caso
inner join empleado e1 on caso.id_programador=e1.id_empleado
inner join empleado e2 on caso.id_empleado=e2.id_empleado
inner join solicitud_caso on caso.id_solicitud=solicitud_caso.id_solicitud
inner join tipo_caso on solicitud_caso.id_tipo=tipo_caso.id_tipo
inner join estado_caso on caso.id_estado=estado_caso.id_estado
where caso.id_caso='2'*/
            String error = "";
            ResultSet info_caso = null;
            if (request.getParameter("id_caso") != null) {

                if (!request.getParameter("id_caso").isEmpty()) {

                    String consulta = "select tipo_caso.descripcion,solicitud_caso.descripcion,"
                            + " solicitud_caso.archivo_info, concat(e1.nombres,' ',e1.apellidos),concat(e2.nombres,' ',e2.apellidos),caso.fecha_inicio,"
                            + "caso.fecha_final,estado_caso.Descripción,caso.porcentaje_avance, "
                            + "solicitud_caso.id_solicitud from caso "
                            + "inner join empleado e1 on caso.id_programador=e1.id_empleado "
                            + "inner join empleado e2 on caso.id_empleado=e2.id_empleado "
                            + "inner join solicitud_caso on caso.id_solicitud=solicitud_caso.id_solicitud "
                            + "inner join tipo_caso on solicitud_caso.id_tipo=tipo_caso.id_tipo "
                            + "inner join estado_caso on caso.id_estado=estado_caso.id_estado where caso.id_caso=?";

                    st = conexion.prepareStatement(consulta);
                    st.setString(1, request.getParameter("id_caso"));

                    info_caso = st.executeQuery();

                    if (info_caso.next()) {

                    } else {

                        error = "El ID del caso no existe.";

                    }

                } else {

                    error = "El parámetro del ID de caso está vacío.";

                }

            } else {
                error = "No se ha recibido los parámetros necesarios.";
            }

        %>


        <%            if (error.equals("")) {
        %>

        <h1 class="mt-3 mb-3 text-center">Información del caso seleccionado</h1>

        <div class="d-flex justify-content-center mt-3 mb-3">

            <form class="w-50"> 


                <div class="form-group">

                    <label>Descripción del caso.</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_caso.getString(2)%>">
                </div>

                <div class="form-group">

                    <label>Tipo de caso.</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_caso.getString(1)%>">
                </div>

                <div class="form-group">

                    <label>Programador seleccionado para llevar a cabo el proyecto.</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_caso.getString(4)%>">
                </div>

                <div class="form-group">

                    <label>Empleado encargado de realizar pruebas.</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_caso.getString(5)%>">
                </div>

                <div class="form-group">

                    <label>Fecha de inicio del proyecto.</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_caso.getString(6)%>">
                </div>


                <div class="form-group">

                    <label>Fecha de finalización del proyecto.</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_caso.getString(7)%>">
                </div>


                <div class="form-group">

                    <label>Estado del caso</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_caso.getString(8)%>">
                </div>

                <div class="form-group">

                    <label>Porcentaje de avance (%).</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_caso.getString(9)%>%">
                </div>

                <% if (info_caso.getString(3) != null) {%>
                <div class="border ml-3 mr-3">    
                    <p class="text-center m-3">Esta solicitud contiene un archivo pdf</p>
                    <div class="d-flex justify-content-center m-3">    

                        <a target="_blank" href="mostrar_pdf_solicitud.jsp?id_solicitud=<%=info_caso.getString(10)%>" class="btn btn-info">
                            Ver archivo pdf adjunto</a>

                    </div>
                </div>
                <%}%>

            </form>



        </div>

        <% } else {%>
        <div class="alert alert-danger text-center m-5">
            <%=error%>
        </div>   

        <%      }   %>

        <div class="d-flex justify-content-center mt-3 mb-3">

            <%
                if (sesion_usuario.getAttribute("rol").equals("Programador")) {
                    out.println("<a class='btn btn-primary' href='casos_asignados.jsp'>Regresar a casos asignados</a>");

                } else if (sesion_usuario.getAttribute("rol").equals("Empleado de área")) {
                    out.println("<a class='btn btn-primary' href='casos_asignados_empleado.jsp'>Regresar a casos asignados</a>");

                } else if (sesion_usuario.getAttribute("rol").equals("Jefe de desarrollo")) {
                    out.println("<a class='btn btn-primary' href='casos.jsp'>Regresar a casos</a>");
                }
            %>


        </div>


    </body>
</html>
