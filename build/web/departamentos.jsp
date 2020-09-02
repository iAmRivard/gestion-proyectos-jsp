
<%@page session="true" language="java" import="java.util.*" %>
<%@ include file="conexion.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Departamentos</title>
    </head>
    <body>

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css" />
        <script type="text/javascript" charset="utf8" src="./js/jquery-3.4.0.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>

        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
        <link rel="stylesheet" href="./css/menu.css"/>

        <script>

            $(document).ready(function () {
                $('#tabla_empleados').DataTable({
                    "language": {
                        "url": "./js/plugin_spanish.json"
                    }
                });
            });

        </script>
        <%            HttpSession sesionOk = request.getSession(); //Creamos una sesión.    

            //Obtenemos información de todos los departamentos registrados.
            st = conexion.prepareStatement("SELECT d.descripcion,concat(e.nombres,' ',e.apellidos) as 'Jefe de área',concat(e2.nombres,' ',e2.apellidos) "
                    + " as 'Jefe de sistema', count(e3.id_empleado) as 'Cantidad empleados' ,d.id_departamento "
                    + " FROM departamento d "
                    + " left JOIN empleado e ON d.id_jefe=e.id_empleado "
                    + " left JOIN empleado e2 ON d.id_desarrollador=e2.id_empleado "
                    + " left join empleado e3 on d.id_departamento=e3.id_departamento "
                    + " group by d.id_departamento");

            ResultSet lista_departamentos = st.executeQuery();

        %>

        <%//Incluimos el menú con las opciones para el administrador.%>
        <%@ include file="include/menu.jsp"%>

        <h1 class="mt-3 mb-3 text-center"><fmt:message key="label.lista.departamento" /></h1>

        <%
            if (sesionOk.getAttribute("mensaje_eliminar_departamento") != null && !sesionOk.getAttribute("mensaje_eliminar_departamento").equals("")) { //Verificamos si la sesión tiene el atributo mensaje.
                //NOTA: El nombre del atributo no se puede repetir en ninguna otra página de la aplicación.
%>
        <div class="d-flex justify-content-center">
            <div class="alert alert-danger w-50">
                <strong>¡Error! </strong> <%=sesionOk.getAttribute("mensaje_eliminar_departamento") //Se muestra el error en el proceso.
                %>

                <br>
            </div>
        </div>    
        <%

            }
        %>



        <div class="d-flex justify-content-center" style="margin-left:70px;">
            <table id="tabla_empleados" class="w-100 table table-striped table-bordered" style="width:100%;">
                <thead>
                    <tr>
                        <th><fmt:message key="label.nombre"/></th>
                        <th><fmt:message key="label.jefe.area"/></th>
                        <th><fmt:message key="label.jefe.sistemas"/></th>
                        <th><fmt:message key="label.cantidad.empleados"/></th>
                        <th><fmt:message key="label.acciones"/></th>
                    </tr>
                </thead>
                <tbody>

                    <%
                        //Recorremos todos los registros devueltos en la consulta.
                        while (lista_departamentos.next()) {

                    %>
                    <tr>
                        <td><%=lista_departamentos.getString(1)%></td>

                        <% if (lista_departamentos.getString(2) != null) { //Este condicional hace que en lugar
                                //de poner NULL, devuelva "sin asignar" cuando un jefe de área no ha sido asignado al dpto.%>
                        <td><%=lista_departamentos.getString(2)%></td>
                        <%} else {%>
                        <td>Sin asignar</td>
                        <%}%>

                        <% if (lista_departamentos.getString(3) != null) { //Este condicional hace que en lugar
                                //de poner NULL, devuelva "sin asignar" cuando un jefe de desarrollo no ha sido asignado al dpto.%>
                        <td><%=lista_departamentos.getString(3)%></td>
                        <%} else {%>
                        <td>Sin asignar</td>
                        <%}%>

                        <td><%=lista_departamentos.getString(4)%></td>
                        <td><a href="formulario_actualizar_departamentos.jsp?id_departamento=<%=lista_departamentos.getString(5)%>" class="btn btn-info">Editar</a>
                            <a href="eliminar_departamentos.jsp?id_departamento=<%=lista_departamentos.getString(5)%>" class="btn btn-danger">Eliminar</a>
                        </td>
                    </tr>        

                    <%      }     %>
                </tbody>

            </table>
        </div>     


        <% //Removemos el atributo, para que el mensaje de error solo se muestre 1 vez.
            sesionOk.removeAttribute("mensaje_eliminar_departamento");
            conexion.close();%>      


    </body>
</html>
