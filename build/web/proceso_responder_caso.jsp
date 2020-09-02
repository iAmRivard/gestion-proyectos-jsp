
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>

<%@ include file="conexion.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Respuesta a caso seleccionado</title>
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
                if (request.getParameter("motivo_rechazo") != null && request.getParameter("id_caso") != null) {

                    if (request.getParameter("motivo_rechazo").trim().isEmpty()) {

                        error_proceso = "Error, no ha ingresado el motivo de rechazo.";

                    } else if (request.getParameter("motivo_rechazo").length() > 500) {

                        error_proceso = "Error, el motivo de rechazo es muy extenso, debe ser más corto.";

                    } else if (request.getParameter("id_caso").trim().isEmpty()) {
                        error_proceso = "Error, no se ha recibido el ID del caso.";

                    } else if (request.getParameter("id_caso").length() > 11) {

                        error_proceso = "Error, el ID del caso es muy extenso.";
                    }

                } else {

                    error_proceso = "Error, no se ha recibido los parámetros para llevar"
                            + " a cabo el proceso de rechazo de un caso.";
                }

            } else if (request.getParameter("btn_aceptar") != null) {
                solicitud = "Aceptar";
                // out.println("Aceptar");

                if (request.getParameter("id_caso") != null) {

                    if (request.getParameter("id_caso").trim().isEmpty()) {
                        error_proceso = "Error, no se ha recibido el ID del caso";

                    } else if (request.getParameter("id_caso").length() > 11) {

                        error_proceso = "Error, el ID del caso es muy extenso.";
                    }

                } else {

                    error_proceso = "Error, faltan parámetros para llevar a cabo el proceso de aceptación"
                            + " del caso seleccionado.";

                }

            } else {
                error_proceso = "Error, no ha seleccionado rechazar o aceptar un caso.";
            }


        %>

        <% if (!error_proceso.equals("")) {%>

        <div class="alert alert-danger text-center m-5">
            <%=error_proceso%>
        </div>    


        <% } else {
            //Verificamos cuál ha sido la decisión del usuario.
            Boolean respuesta = false;
            //El usuario quiere rechazar el caso.
            if (solicitud.equals("Rechazar")) {

                try {
                    st = conexion.prepareStatement("SELECT date_add(DATE_FORMAT(now(), '%Y-%m-%d'), "
                            + " INTERVAL 7 DAY)");
                    ResultSet nueva_fecha = st.executeQuery();
                    nueva_fecha.next();

                    //Actualizamos el estado del caso y el porcentaje de avance se asigna a 0.
                    st = conexion.prepareStatement("update caso set id_estado=?,porcentaje_avance=?,"
                            + " fecha_final=? where id_caso=?");
                    st.setString(1, "4");
                    st.setString(2, "0");
                    st.setString(3, nueva_fecha.getString(1));
                    st.setString(4, request.getParameter("id_caso"));

                    st.executeUpdate();

                    //Se ingresa la observación del por qué se rechazó el caso.
                    st = conexion.prepareStatement("insert into observaciones_caso (id_caso,observaciones,Entrega) "
                            + "VALUES (?,?,?)");
                    st.setString(1, request.getParameter("id_caso"));
                    st.setString(2, request.getParameter("motivo_rechazo"));
                    st.setString(3, null);

                    st.executeUpdate();

                    respuesta = true;
                } catch (Exception ex) {

                    out.println(ex.toString());

                }

            } else if (solicitud.equals("Aceptar")) {

                try {

                    //Cambiamos el estado del caso a "finalizado".
                    st = conexion.prepareStatement("update caso set id_estado=? where id_caso=?");
                    st.setString(1, "5");
                    st.setString(2, request.getParameter("id_caso"));

                    st.executeUpdate();

                    respuesta = true;

                } catch (Exception ex) {
                    out.println(ex.toString());
               }

           }

           if (respuesta == true) { %>
        <div class="alert alert-success text-center m-5">
            El proceso de respuesta al caso seleccionado se ha llevado a cabo con éxito.
        </div> 
        <%   }

            }

        %>

        <div class="d-flex justify-content-center mt-3 mb-3">
            <a class="btn btn-primary" href="casos_revisar_empleado.jsp">Regresar al listado de casos por revisar</a>
        </div> 

    </body>
</html>
