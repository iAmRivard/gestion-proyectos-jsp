
<%//Agregamos archivos a utilizar.%>
<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<%@ include file="conexion.jsp"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%    st = conexion.prepareStatement("select MAX(id_empleado) from empleado"); //Preparamos la consulta para
    //obtener el ID del último empleado ingresado.
    rs = st.executeQuery(); //Ejecutamos la consulta y obtenemos el resultado en un result set.
    ResultSet ultimo_ID = rs;
    int ID;
    if (ultimo_ID.next()) { //Verificar si la consulta devuelve un valor. (ya hay empleados).
        ID = (ultimo_ID.getInt(1)) + 1;
    } else { //No se ha ingresado empleado.
        ID = 1;
    }

    st = conexion.prepareStatement("select * from roles"); //Preparamos la consulta para obtener los roles.
    rs = st.executeQuery(); //Ejecutamos la consulta y obtenemos el resultado en un result set.

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario para nuevo empleado</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./css/menu.css"/>
    </head>




    <script>

        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });

    </script>

    <body>
        <%//Incluimos el menú con las opciones para el administrador.%>
        <%@ include file="include/menu.jsp"%>
        <h1 class="text-center m-3">Formulario de ingreso de empleados</h1>

        <%            HttpSession sesionOk = request.getSession(); //Iniciamos sesión.

            if (sesionOk.getAttribute("mensaje_agregar_empleado") != null && !sesionOk.getAttribute("mensaje_agregar_empleado").equals("")) { //Verificamos si la sesión tiene el atributo mensaje.
                //NOTA: El nombre del atributo no se puede repetir en ninguna otra página de la aplicación.
%>
        <div class="d-flex justify-content-center">
            <div class="alert alert-danger w-50">
                <strong>¡Error! </strong> <%=sesionOk.getAttribute("mensaje_agregar_empleado") //Se muestra el error en el proceso.
                            %>

                <br>
            </div>
        </div>    
        <%

            }
        %>



        


        <div class="d-flex justify-content-center">
            <form action="agregar_empleados.jsp" method="post" class="w-50">

                <label for="id">ID nuevo empleado:</label>
                <input type="text" class="form-control" autocomplete="off" value="<%=ID%>"  name="id" readonly="on" >

                <label for="nombres">Ingrese los nombres del nuevo empleado</label>
                <input type="text" class="form-control" name="nombres" autocomplete="off" id="nombre" data-toggle="tooltip" data-placement="right" title="Debe completar este campo">

                <label for="apellidos">Ingrese los apellidos del nuevo empleado</label>
                <input type="text" class="form-control" name="apellidos" autocomplete="off" data-toggle="tooltip" data-placement="right" title="Debe completar este campo">

                <label for="usuario">Ingrese el usuario del nuevo empleado</label>
                <input type="text" class="form-control" name="usuario" autocomplete="off" data-toggle="tooltip" data-placement="right" title="Debe completar este campo">

                <label for="contra">Ingrese la contraseña del nuevo empleado</label>
                <input type="password" class="form-control" name="contra" autocomplete="off" data-toggle="tooltip" data-placement="right" title="Debe completar este campo">

                <label for="correo">Ingrese el correo del nuevo empleado</label>
                <input type="text" class="form-control" name="correo" autocomplete="off" data-toggle="tooltip" data-placement="right" title="Debe completar este campo">

                <div class="form-group">
                    <label for="rol">Seleccione el rol del nuevo empleado</label>
                    <select class="form-control" name="rol">

                        <%

                            while (rs.next()) { //Recorremos todos los valores del result set.
                                //En la etiqueta option value, se asigna el id del rol,
                                // mientras que el texto a mostrar es la descripción del rol.
%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%  } %>
                    </select>
                </div>


                <div class="form-group">
                    <label for="departamento">Seleccione el departamento del nuevo empleado</label>
                    <select class="form-control" name="departamento">

                        <%
                            st = conexion.prepareStatement("select * from departamento"); //Preparamos la consulta para obtener los departamentos.
                            rs = st.executeQuery(); //Ejecutamos la consulta y obtenemos el resultado en un result set.   

                            while (rs.next()) { //Recorremos todos los valores del result set.
                                //En la etiqueta option value, se asigna el id del departamento,
                                // mientras que el texto a mostrar es la descripción del departamento.
%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%  } %>
                    </select>
                </div>
                <div class="d-flex justify-content-center m-2">
                    <input type="submit" value="Agregar empleado" class="w-50 btn btn-success">
                </div>
            </form>
        </div>

        <% //Removemos el atributo, para que el mensaje de error solo se muestre 1 vez.
            sesionOk.removeAttribute("mensaje_agregar_empleado");
            conexion.close();%>

    </body>
</html>
