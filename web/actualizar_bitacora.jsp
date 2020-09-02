

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
        <title>Actualizar</title>
    </head>
    <body>

        <%            if (request.getParameter("id_bitacora") != null) {

                try {

                    st = conexion.prepareStatement("update bitacora_caso set observacion =? WHERE id_entrada=?");
                    st.setString(1, request.getParameter("mensaje"));
                    st.setString(2, request.getParameter("id_bitacora"));

                    st.executeUpdate();

                } catch (Exception ex) {

                    out.println(ex.toString());

                }
            }

            response.sendRedirect("casos_asignados.jsp");

        %>



    </body>
</html>
