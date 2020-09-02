
<%@ include file="conexion.jsp"%> 
<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar información de empleado</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
        <link rel="stylesheet" href="./css/menu.css"/>
    </head>
    <body>



        <%//Incluimos el menú con las opciones para el administrador.%>
        <%@ include file="include/menu.jsp"%>


        <%
            st = conexion.prepareStatement("select * from roles"); //Preparamos la consulta para obtener los roles.
            rs = st.executeQuery(); //Ejecutamos la consulta y obtenemos el resultado en un result set.     

            String ID = request.getParameter("id_empleado"); //Obtenemos el parámetro del id del empleado.

            st = conexion.prepareStatement("select e.id_empleado, e.nombres,e.apellidos,e.usuario,e.contrasena,e.correo,r.id_rol,d.id_departamento"
                    + " from empleado e "
                    + " inner join roles r on e.id_rol=r.id_rol"
                    + " inner join departamento d on e.id_departamento=d.id_departamento"
                    + " where e.id_empleado=?"); //Consulta para obtener información.

            st.setString(1, ID);

            ResultSet empleado_informacion = st.executeQuery(); //Obtenemos el registro.

            HttpSession sesionOk = request.getSession(); //Iniciamos sesión.

        %>

        <h1 class="mt-3 mb-3 text-center">Formulario para actualizar información de empleado</h1>
        <% if (empleado_informacion.next()) { %>

        <p class="mt-2 mb-3 text-center">En esta página se obtiene la información del empleado seleccionado, si desea actualizar
            algún dato, edite los campos que desea actualizar.</p>

        <%

            if (sesionOk.getAttribute("mensaje_actualizar_empleado") != null && !sesionOk.getAttribute("mensaje_actualizar_empleado").equals("")) { //Verificamos si la sesión tiene el atributo mensaje.
                //NOTA: El nombre del atributo no se puede repetir en ninguna otra página de la aplicación.
        %>
        <div class="d-flex justify-content-center">
            <div class="alert alert-danger w-50">
                <strong>¡Error! </strong> <%=sesionOk.getAttribute("mensaje_actualizar_empleado") //Se muestra el error en el proceso.
                        %>

                <br>
            </div>
        </div>    
        <%

            }
        %>

        <div class="d-flex justify-content-center">
            <form action="actualizar_empleados.jsp" method="post" class="w-50">

                <label for="id">ID del empleado:</label>
                <input type="text" class="form-control" autocomplete="off" value="<%=empleado_informacion.getString(1)%>"  name="id" readonly="on" >

                <label for="nombres">Ingrese los nombres del empleado</label>
                <input type="text" class="form-control" name="nombres" value="<%=empleado_informacion.getString(2)%>" autocomplete="off" id="nombre" >

                <label for="apellidos">Ingrese los apellidos del empleado</label>
                <input type="text" class="form-control" name="apellidos" value="<%=empleado_informacion.getString(3)%>" autocomplete="off" >

                <label for="usuario">Ingrese el usuario del empleado</label>
                <input type="text" class="form-control" name="usuario" value="<%=empleado_informacion.getString(4)%>" autocomplete="off">

                <label for="contra">Ingrese la contraseña del empleado</label>
                <input type="password" class="form-control" name="contra" value="<%=empleado_informacion.getString(5)%>" autocomplete="off">

                <label for="correo">Ingrese el correo del empleado</label>
                <input type="text" class="form-control" name="correo" value="<%=empleado_informacion.getString(6)%>" autocomplete="off">

                <div class="form-group">
                    <label for="rol">Seleccione el rol del empleado</label>
                    <select class="form-control" name="rol">

                        <%

                            while (rs.next()) { //Recorremos todos los valores del result set.
                                //En la etiqueta option value, se asigna el id del rol,
                                // mientras que el texto a mostrar es la descripción del rol.

                                //Realizamos una comparación, para que la opción seleccionada
                                //(predeterminadamente) sea el rol que tiene asignado el empleado.
                                if (rs.getString(1).equals(empleado_informacion.getString(7))) {%>
                        <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>
                        <%   } else {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%      }
                            }
                        %>
                    </select>
                </div>


                <div class="form-group">
                    <label for="departamento">Seleccione el departamento del  empleado</label>
                    <select class="form-control" name="departamento">

                        <%
                            st = conexion.prepareStatement("select * from departamento"); //Preparamos la consulta para obtener los departamentos.
                            rs = st.executeQuery(); //Ejecutamos la consulta y obtenemos el resultado en un result set.   

                            while (rs.next()) { //Recorremos todos los valores del result set.
                                //En la etiqueta option value, se asigna el id del departamento,
                                // mientras que el texto a mostrar es la descripción del departamento.

                                //Realizamos una comparación, para que la opción seleccionada
                                //(predeterminadamente) sea el departamento que tiene asignado el empleado.
                                if (rs.getString(1).equals(empleado_informacion.getString(8))) {%>
                        <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>
                        <%   } else {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%      }
                            }
                        %>

                    </select>
                </div>

                <div class="d-flex justify-content-center m-2">

                    <input type="submit" value="Actualizar información" class="w-50 btn btn-success">


                </div>

            </form>

            <% } else { %>

            <div class="alert alert-danger text-center ml-4 mr-4">
                Error, no se puede cargar la información porque no se ha enviado 
                un ID válido.

            </div>



            <% } %>




        </div>

        <div class="d-flex justify-content-center">
            <a href="empleados.jsp" class="btn btn-primary mt-3 mb-3">Regresar a la lista de empleados</a>          
        </div>

        <% //Removemos el atributo, para que el mensaje de error solo se muestre 1 vez.
            sesionOk.removeAttribute("mensaje_actualizar_empleado");
            conexion.close();%>
    </body>
</html>
