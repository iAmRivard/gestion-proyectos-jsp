

<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<%@ include file="conexion.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%    st = conexion.prepareStatement("select observacion from bitacora_caso where id_entrada=?");

    st.setString(1, request.getParameter("id_bitacora"));
    ResultSet info_bitacora = st.executeQuery();
    info_bitacora.next();

%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario para actualizar bitácora</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
        <link rel="stylesheet" href="./css/menu.css"/>
    </head>
    <body>

        <%@ include file="include/menu_programador.jsp"%>
        <%            if (request.getParameter("id_bitacora") != null) {%>

        <div class="mt-5 mb-5">
            <h3 class="text-center">Formulario para actualizar bitácora.</h3>
            <div class="d-flex justify-content-center mt-3 mb-3">

                <form action="actualizar_bitacora.jsp" method="post" class="w-50"> 

                    <div class="form-group">
                        <label for="observacion">Ingrese la observación de la nueva bitácora</label>
                        <textarea class="form-control textarea" id="descripcion" 
                                  name="mensaje" rows="3" ><%=info_bitacora.getString(1)%></textarea>
                    </div>
                    <input type="hidden" value="<%=request.getParameter("id_bitacora")%>" name="id_bitacora" />
                    <div class="d-flex justify-content-center mt-3 mb-3">
                        <input type="submit" class="btn btn-success" value="Actualizar bitácora">
                    </div>

                </form>

            </div>
        </div>   



        <%     }


        %>

        <div class="d-flex justify-content-center mt-3 mb-3">
            <a href="casos_asignados.jsp" class="btn btn-primary">Volver</a>
        </div>


    </body>
</html>
