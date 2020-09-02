
<%//Agregamos archivos a utilizar.%>
<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>

<%@ include file="conexion.jsp"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%    st = conexion.prepareStatement("select MAX(id_departamento) from departamento"); //Preparamos la consulta para
    //obtener el ID del último departamento ingresado.
    rs = st.executeQuery(); //Ejecutamos la consulta y obtenemos el resultado en un result set.
    ResultSet ultimo_ID = rs;
    int ID;
    if (ultimo_ID.next()) { //Verificar si la consulta devuelve un valor. (ya hay departamentos).
        ID = (ultimo_ID.getInt(1)) + 1;
    } else { //No se ha ingresado ningún departamento.
        ID = 1;
    }


%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario para agregar departamento.</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
        <link rel="stylesheet" href="./css/menu.css"/>
    </head>
    <body>


        <%//Incluimos el menú con las opciones para el administrador.%>
        <%@ include file="include/menu.jsp"%>

        <h1 class="text-center m-3">Formulario de ingreso de departamento</h1>


        <%
            HttpSession sesionOk = request.getSession(); //Iniciamos sesión.

            if (sesionOk.getAttribute("mensaje_agregar_departamento") != null && !sesionOk.getAttribute("mensaje_agregar_departamento").equals("")) { //Verificamos si la sesión tiene el atributo mensaje.
                //NOTA: El nombre del atributo no se puede repetir en ninguna otra página de la aplicación.
        %>
        <div class="d-flex justify-content-center">
            <div class="alert alert-danger w-50">
                <strong>¡Error! </strong> <%=sesionOk.getAttribute("mensaje_agregar_departamento") //Se muestra el error en el proceso.
                        %>

                <br>
            </div>
        </div>    
        <%

            }
        %>


        <div class="d-flex justify-content-center">
            <form action="agregar_departamentos.jsp" method="post" class="w-50">

                <label for="id">ID nuevo departamento:</label>
                <input type="text" class="form-control" autocomplete="off" value="<%=ID%>"  name="id" readonly="on" >

                <label for="descripcion">Ingrese la descripción del nuevo departamento</label>
                <input type="text" class="form-control" name="descripcion" autocomplete="off" id="descripcion">



                <div class="d-flex justify-content-center m-2">

                    <input type="submit" value="Agregar departamento" class="w-50 btn btn-success">

                </div>

            </form>



        </div>

        <% //Removemos el atributo, para que el mensaje de error solo se muestre 1 vez.
            sesionOk.removeAttribute("mensaje_agregar_departamento");
            conexion.close();%>



    </body>
</html>
