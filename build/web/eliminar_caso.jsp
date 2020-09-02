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
        <title>Eliminar caso</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">

    </head>
    <body>

        <%            //delete from caso WHERE id_caso=?
            if (request.getParameter("id_caso") != null) {

                try {

                    st = conexion.prepareStatement("delete from caso WHERE id_caso=?");
                    st.setString(1, request.getParameter("id_caso"));

                    st.executeUpdate();

                    response.sendRedirect("tabla_modificar_casos.jsp");

                } catch (Exception ex) {

                    out.println(ex.toString());

                }

            } else { %>

        <div class="alert alert-danger m-5 text-center">
            Error, no se han recibido los parámetros necesarios para llevar
            a cabo el proceso.
        </div>
        <%       }%>

    </body>
</html>
