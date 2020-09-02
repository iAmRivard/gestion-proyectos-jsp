
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
        <title>Actualizar caso</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">

    </head>
    <body>

        <%            if (request.getParameter("id_caso") != null) {

                if (!request.getParameter("fecha_final").trim().isEmpty()) {

                    try {

                        st = conexion.prepareStatement("update caso set id_programador=?, id_empleado=?, fecha_final=? where id_caso=?");
                        st.setString(1, request.getParameter("programador"));
                        st.setString(2, request.getParameter("empleado"));
                        st.setString(3, request.getParameter("fecha_final"));
                        st.setString(4, request.getParameter("id_caso"));

                        st.executeUpdate();

        %>

        <div class="alert alert-success m-5 text-center">

            La información del caso ha sido actualizada con éxito.

        </div>

        <%                    } catch (Exception ex) {

                out.println(ex.toString());

                    }

                } else { %>
        <div class="alert alert-warning m-5 text-center">

            No ha seleccionado la fecha final del caso.

        </div>

        <%       }

         } else { %>

        <div class="alert alert-danger m-5 text-center">

            Error, no se han recibido los parámetros necesarios para llevar
            a cabo el proceso.

        </div>

        <%     } 
        %>


        <div class="d-flex justify-content-center mt-3 mb-3">

            <a class="btn btn-primary" href="tabla_modificar_casos.jsp">Regresar</a>

        </div>

    </body>
</html>
