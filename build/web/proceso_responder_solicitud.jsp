
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>

<%@ include file="conexion.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Respuesta a solicitud</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    </head>
    <body>



        <%            String error_proceso = ""; //Declaramos una variable para presentar el
            String solicitud = "";
            //mensaje de error.

            if (request.getParameter("btn_rechazar") != null) {

                //out.println("Rechazar");
                solicitud = "Rechazar";
                if (request.getParameter("motivo_rechazo") != null && request.getParameter("id_solicitud") != null) {

                    if (request.getParameter("motivo_rechazo").trim().isEmpty()) {

                        error_proceso = "Error, no ha ingresado el motivo de rechazo.";

                    } else if (request.getParameter("motivo_rechazo").length() > 500) {

                        error_proceso = "Error, el motivo de rechazo es muy extenso, debe ser más corto.";

                    } else if (request.getParameter("id_solicitud").trim().isEmpty()) {
                        error_proceso = "Error, no se ha recibido el ID de la solicitud.";

                    } else if (request.getParameter("id_solicitud").length() > 11) {

                        error_proceso = "Error, el ID de la solicitud es muy extenso.";
                    }

                } else {

                    error_proceso = "Error, no se ha recibido los parámetros para llevar"
                            + " a cabo el proceso de rechazo de una solicitud";
                }

            } else if (request.getParameter("btn_aceptar") != null) {
                solicitud = "Aceptar";
                // out.println("Aceptar");
                SimpleDateFormat validador = new SimpleDateFormat("yyyy-MM-dd");

                if (request.getParameter("programador") != null && request.getParameter("empleado") != null
                        && request.getParameter("fecha_inicio") != null && request.getParameter("fecha_final") != null
                        && request.getParameter("id_solicitud") != null) {

                    if (request.getParameter("programador").trim().isEmpty()) {

                        error_proceso = "Error, No ha seleccionado a un programador para llevar a cabo el caso.";

                    } else if (request.getParameter("programador").length() > 11) {

                        error_proceso = "Error, el ID del programador seleccionado es muy extenso.";

                    } else if (request.getParameter("empleado").trim().isEmpty()) {

                        error_proceso = "Error, No ha seleccionado a un empleado que lleve a cabo las pruebas del caso.";

                    } else if (request.getParameter("empleado").length() > 11) {

                        error_proceso = "Error, el ID del empleado seleccionado es muy extenso.";

                    } else if (request.getParameter("fecha_inicio").trim().isEmpty()) {

                        error_proceso = "Error, no ha seleccionado la fecha de inicio del proyecto.";

                    } else if (request.getParameter("fecha_final").trim().isEmpty()) {

                        error_proceso = "Error, no ha seleccionado la fecha final del proyecto.";

                    } else if (request.getParameter("id_solicitud").trim().isEmpty()) {
                        error_proceso = "Error, no se ha recibido el ID de la solicitud";

                    } else if (request.getParameter("id_solicitud").length() > 11) {

                        error_proceso = "Error, el ID de la solicitud es muy extenso.";
                    }

                    if (error_proceso.equals("")) {

                        String fecha1 = request.getParameter("fecha_inicio");
                        String fecha2 = request.getParameter("fecha_final");

                        try {

                            Date fecha_inicio = validador.parse(fecha1);
                            Date fecha_final = validador.parse(fecha2);

                            if (fecha_inicio.compareTo(fecha_final) < 0) {

                            } else if (fecha_inicio.compareTo(fecha_final) > 0) {

                                error_proceso = "Error, la fecha inicial no puede ser mayor a la fecha final";

                            } else {

                                error_proceso = "Error, la fecha inicial y final no pueden ser las mismas, debe haber por lo menos 1 día"
                                        + " de diferencia.";

                            }

                        } catch (ParseException ex) {

                            out.println("Ha ocurrido una excepción con el manejo de las fechas:" + ex.toString());

                        }

                    }

                } else {

                    error_proceso = "Error, faltan parámetros para llevar a cabo el proceso de aceptación"
                            + " de solicitud.";

                }

            } else {
                error_proceso = "Error, no ha seleccionado rechazar o aceptar una solicitud";
            }


        %>

        <% if (!error_proceso.equals("")) {%>

        <div class="alert alert-danger text-center m-5">
            <%=error_proceso%>
        </div>    


        <% } else {
            //Verificamos cuál ha sido la decisión del usuario.
            Boolean respuesta = false;
            //El usuario quiere rechazar la solicitud.
            if (solicitud.equals("Rechazar")) {

                try {

                    st = conexion.prepareStatement("update solicitud_caso set id_estado=?,"
                            + " argumento_rechazo=? where id_solicitud=?");
                    st.setString(1, "2");
                    st.setString(2, request.getParameter("motivo_rechazo"));
                    st.setString(3, request.getParameter("id_solicitud"));

                    st.executeUpdate();
                    respuesta = true;
                } catch (Exception ex) {

                    out.println(ex.toString());

                }

            } else if (solicitud.equals("Aceptar")) {

                //insert into caso VALUES ('','','','','','','','')
                //Cambiamos el estado de la solicitud a aprobado (en desarrollo).
                try {

                    //Ingresamos el caso a la tabla "casos".
                    st = conexion.prepareStatement("select max(id_caso) from caso ");
                    ResultSet ultimo_ID = st.executeQuery();
                    int nuevoID;

                    if (ultimo_ID.next()) {

                        nuevoID = (ultimo_ID.getInt(1) + 1);

                    } else {
                        nuevoID = 1;
                    }

                    st = conexion.prepareStatement("insert into caso VALUES (?,?,?,?,?,?,?,?)");
                    st.setString(1, String.valueOf(nuevoID));
                    st.setString(2, request.getParameter("id_solicitud"));
                    st.setString(3, request.getParameter("programador"));
                    st.setString(4, request.getParameter("empleado"));
                    st.setString(5, request.getParameter("fecha_inicio"));
                    st.setString(6, request.getParameter("fecha_final"));
                    st.setString(7, "1");
                    st.setString(8, "0");

                    st.executeUpdate();

                    //Cambiamos el estado de la solicitud a "en desarrollo" (aprobado)
                    //para que ya no aparezca en la lista de solicitudes pendientes.
                    st = conexion.prepareStatement("update solicitud_caso set id_estado=? "
                            + " where id_solicitud=?");
                    st.setString(1, "3");
                    st.setString(2, request.getParameter("id_solicitud"));

                    st.executeUpdate();

                    respuesta = true;

                } catch (Exception ex) {
                    out.println(ex.toString());
               }

           }

           if (respuesta == true) { %>
        <div class="alert alert-success text-center m-5">
            El proceso de respuesta a la solicitud se ha llevado a cabo con éxito.
        </div> 
        <%   }

            }

        %>

        <div class="d-flex justify-content-center mt-3 mb-3">
            <a class="btn btn-primary" href="solicitudes_en_espera.jsp">Regresar al listado de solicitudes</a>
        </div> 

    </body>
</html>
