

<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<% request.setCharacterEncoding("UTF-8");
   %>

<%@ include file="conexion.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Proceso para agregar bitácora</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/menu.css"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">

    </head>
    <body>


        <%//Incluimos el menú con las opciones para el programador%>
        <%@ include file="include/menu_programador.jsp"%>


        <%
            String error = "";
            int porcentaje = Integer.parseInt(request.getParameter("avance"));
            if (request.getParameter("observacion") != null
                    && request.getParameter("avance") != null) {

                if (request.getParameter("observacion").trim().isEmpty()) {
                    error = "Error, no ha ingresado la observación de la nueva bitácora";

                } else if (request.getParameter("observacion").length() > 500) {
                    error = "Error, la observación de la nueva bitácora es muy"
                            + "extensa, debe ser más corta.";

                } else if (request.getParameter("avance").trim().isEmpty()) {

                    error = "Error, no ha ingresado el porcentaje de avance.";

                } else if (porcentaje < 0 || porcentaje > 100) {

                    error = "Error, el porcentaje no puede ser menor a 0 ó mayor a 100";

                }

            } else {
                error = "Error, faltan parámetros para llevar a cabo la acción.";
            }

        %>

        <%            if (error.equals("")) {

                try {
                    st = conexion.prepareStatement("insert into bitacora_caso (id_caso,observacion) values (?,?)");
                    st.setString(1, request.getParameter("id_caso"));
                    st.setString(2, request.getParameter("observacion"));

                    st.executeUpdate();

                    //Ahora actualizamos el porcentaje avance de la tabla caso.
                    if (porcentaje == 100) {
                        st = conexion.prepareStatement("update caso set porcentaje_avance=?, id_estado=? where id_caso=?");
                        st.setString(1, request.getParameter("avance"));
                        st.setString(2, "2");
                        st.setString(3, request.getParameter("id_caso"));

                    } else {
                        st = conexion.prepareStatement("update caso set porcentaje_avance=? where id_caso=?");
                        st.setString(1, request.getParameter("avance"));
                        st.setString(2, request.getParameter("id_caso"));
                    }

                    st.executeUpdate();

        %>

        <div class="m-5 alert alert-danger text-center">

            La bitácora fue agregada a la base de datos del sistema.

        </div>

        <% } catch (Exception ex) {
                       out.println(ex.toString());
                   }

               } else {%>

        <div class="m-5 alert alert-danger text-center">

            <%=error%>

        </div>


        <%   }


        %>

        <div class="d-flex justify-content-center mt-3 mb-3">

            <a class="btn btn-info" href="casos_asignados.jsp" style="color:white;">Regresar a casos asignados</a>

        </div>


    </body>
</html>
