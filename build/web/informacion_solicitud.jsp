
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
        <%@ include file="include/menu_jefe_area.jsp"%>




        <%
            String error = "";
            ResultSet info_soli = null;
            if (request.getParameter("id_solicitud") != null) {

                if (!request.getParameter("id_solicitud").isEmpty()) {

                    String consulta = "select tipo_caso.descripcion,solicitud_caso.descripcion,"
                            + "solicitud_caso.argumento_rechazo,solicitud_caso.archivo_info, "
                            + "estado_solicitud.descripcion,solicitud_caso.fecha from solicitud_caso "
                            + "inner join tipo_caso on solicitud_caso.id_tipo = tipo_caso.id_tipo "
                            + "inner join estado_solicitud on solicitud_caso.id_estado=estado_solicitud.id_estado "
                            + "where solicitud_caso.id_solicitud=?";

                    st = conexion.prepareStatement(consulta);
                    st.setString(1, request.getParameter("id_solicitud"));

                    info_soli = st.executeQuery();

                    if (info_soli.next()) {

                    } else {

                        error = "El ID de la solicitud no existe.";

                    }

                } else {

                    error = "El parámetro del ID de la solicitud está vacío.";

                }

            } else {
                error = "No se ha recibido los parámetros necesarios.";
            }

        %>


        <%            if (error.equals("")) {
        %>

        <h1 class="mt-3 mb-3 text-center">Información de la solicitud seleccionado</h1>

        <div class="d-flex justify-content-center mt-3 mb-3">

            <form class="w-50"> 


                <div class="form-group">

                    <label>Descripción de la solicitud</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_soli.getString(2)%>">
                </div>

                <div class="form-group">

                    <label>Tipo de caso</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_soli.getString(1)%>">
                </div>

                <div class="form-group">

                    <label>Estado de la solicitud</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_soli.getString(5)%>">
                </div>

                <div class="form-group">

                    <label>Fecha de la solicitud</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_soli.getString(6)%>">
                </div>

                <% if (info_soli.getString(3) != null) {%>
                <div class="form-group">
                    <label>Motivo de rechazo de solicitud</label>
                    <textarea class="form-control textarea" readonly="on" rows="3" ><%=info_soli.getString(3)%></textarea>
                </div>
                <%}%>


                <% if (info_soli.getString(4) != null) {%>
                <div class="border ml-3 mr-3">    
                    <p class="text-center m-3">Esta solicitud contiene un archivo pdf</p>
                    <div class="d-flex justify-content-center m-3">    

                        <a target="_blank" href="mostrar_pdf_solicitud.jsp?id_solicitud=<%=info_soli.getString(4)%>" class="btn btn-info">
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

                out.println("<a class='btn btn-primary' href='solicitudes.jsp'>Regresar a solicitudes</a>");

            %>

        </div>


    </body>
</html>
