

<%@page session="true" language="java" import="java.util.*" %>
<%@ include file="conexion.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!Importamos los necesario para la internalización
    // En está pagina se podra visualizar en portugués y español>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>
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

            //Obtenemos información de todlos los empleados registrados.
            st = conexion.prepareStatement("select e.nombres,e.apellidos,e.usuario,e.correo,r.descripcion,d.descripcion, e.id_empleado "
                    + " from empleado e "
                    + " inner join roles r on e.id_rol=r.id_rol"
                    + " inner join departamento d on e.id_departamento=d.id_departamento");

            ResultSet lista_empleados = st.executeQuery();

        %>


        <%//Incluimos el menú con las opciones para el administrador.%>
        <%@ include file="include/menu.jsp"%>


        <h1 class="mt-3 mb-3 text-center"><fmt:message key="label.lista.empleados" /></h1>

        <%
            if (sesionOk.getAttribute("mensaje_eliminar_empleado") != null && !sesionOk.getAttribute("mensaje_eliminar_empleado").equals("")) { //Verificamos si la sesión tiene el atributo mensaje.
                //NOTA: El nombre del atributo no se puede repetir en ninguna otra página de la aplicación.
        %>
        <div class="d-flex justify-content-center">
            <div class="alert alert-danger w-50">
                <strong>¡Error! </strong> <%=sesionOk.getAttribute("mensaje_eliminar_empleado") //Se muestra el error en el proceso.
                        %>

                <br>
            </div>
        </div>    
        <% } %>

        <div class="d-flex justify-content-center" >
            <table id="tabla_empleados" class="w-100 table table-striped table-bordered" style="width:100%;">
                <thead>
                    <tr>
                        <th><fmt:message key="label.nombre"/></th>
                        <th><fmt:message key="label.apellido"/></th>
                        <th><fmt:message key="label.usuario"/>rio</th>
                        <th><fmt:message key="label.correo"/></th>
                        <th><fmt:message key="label.rol"/></th>
                        <th><fmt:message key="label.departamento"/></th>
                        <th><fmt:message key="label.acciones"/></th>
                    </tr>
                </thead>
                <tbody>

                    <%
                        //Recorremos todos los registros devueltos en la consulta.
                        while (lista_empleados.next()) {%>
                    <tr>
                        <td><%=lista_empleados.getString(1)%></td>
                        <td><%=lista_empleados.getString(2)%></td>
                        <td><%=lista_empleados.getString(3)%></td>
                        <td><%=lista_empleados.getString(4)%></td>
                        <td><%=lista_empleados.getString(5)%></td>
                        <td><%=lista_empleados.getString(6)%></td>
                        <td><a href="formulario_actualizar_empleados.jsp?id_empleado=<%=lista_empleados.getString(7)%>" class="btn btn-info">Editar</a>
                            <a href="eliminar_empleados.jsp?id_empleado=<%=lista_empleados.getString(7)%>" class="btn btn-danger">Eliminar</a>
                        </td>
                    </tr>        

                    <%      }

                    %>




                </tbody>

            </table>
        </div>     


        <% //Removemos el atributo, para que el mensaje de error solo se muestre 1 vez.
            sesionOk.removeAttribute("mensaje_eliminar_empleado");
            conexion.close();%>      


    </body>
</html>
