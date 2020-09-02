
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de solicitudes de caso</title>

        <script type="text/javascript" charset="utf8" src="./js/jquery-3.4.0.js"></script>


        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">

        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
        <link rel="stylesheet" href="./css/menu.css"/>
        <link rel="stylesheet" href="./css/header.css"/>
    </head>
    <body>

        <%//Incluimos el menú con las opciones para el jefe de área.%>
        <%@ include file="include/menu_jefe_area.jsp"%>

        <%//Realizamos consulta para obtener las solicitudes%>
        <sql:query var="solicitudes" dataSource="jdbc/mysql">
            select  concat(empleado.nombres,' ' , empleado.apellidos) as 'Empleados',departamento.descripcion as 'Departamento',solicitud_caso.descripcion as 'Descripción caso',
            estado_solicitud.descripcion as 'Estado de la solicitud',solicitud_caso.fecha as 'Fecha solicitud',solicitud_caso.id_solicitud
            from solicitud_caso
            inner join empleado on solicitud_caso.id_empleado=empleado.id_empleado
            inner join departamento on solicitud_caso.id_departamento=departamento.id_departamento
            inner join tipo_caso on solicitud_caso.id_tipo=tipo_caso.id_tipo
            inner join estado_solicitud on solicitud_caso.id_estado=estado_solicitud.id_estado
            where departamento.id_departamento=?
            <sql:param value='<%=sesion_usuario.getAttribute("id_departamento")%>' />
        </sql:query>




        <script>

            $(document).ready(function () {
                $('#tabla_solicitudes').DataTable({
                    "language": {
                        "url": "./js/plugin_spanish.json"
                    }
                });
            });

        </script>

        <%//Incluimos el header%>
        <%@ include file="include/header_usuario.jsp"%>
        <div class="container m-5">
            <h1 class="text-center m-3">Listado de solicitudes para apertura de casos</h1>

            <div class="d-flex justify-content-center mb-3 mt-3 mr-3" >
                <table id="tabla_solicitudes" class="w-100 table table-striped table-bordered" style="width:100%;">
                    <thead>
                        <tr>
                            <th>Empleado que realiza la solicitud</th>
                            <th>Departamento de la solicitud</th>
                            <th>Descripción de caso</th>
                            <th>Estado de la solicitud</th>
                            <th>Fecha de la solicitud</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="solicitud" items="${solicitudes.rowsByIndex}">
                            <tr>

                                <td><c:out value="${solicitud[0]}"/></td>
                                <td><c:out value="${solicitud[1]}"/></td>
                                <td><c:out value="${solicitud[2]}"/></td>
                                <td><c:out value="${solicitud[3]}"/></td>
                                <td><c:out value="${solicitud[4]}"/></td>
                                <td><div class="d-flex justify-content-center flex-wrap">

                                        <c:if test="${solicitud[3]=='En espera de respuesta'}" >
                                            <a href="formulario_actualizar_solicitudes.jsp?id_solicitud=<c:out value="${solicitud[5]}"/>" class="btn btn-info m-1">Editar</a>
                                            <a href="eliminar_solicitudes.jsp?id_solicitud=<c:out value="${solicitud[5]}"/>" class="btn btn-danger m-1">Eliminar</a> 
                                        </c:if>

                                        <c:if test="${solicitud[3]!='En espera de respuesta'}" >

                                            <a href="informacion_solicitud.jsp?id_solicitud=<c:out value="${solicitud[5]}"/>" class="btn btn-success m-1">Información</a>

                                        </c:if>

                                    </div>
                                </td>


                            </tr>

                        </c:forEach>


                    </tbody>

                </table>
            </div>     

            <div class="d-flex justify-content-center mt-3 mb-3">
                <a href="formulario_solicitudes.jsp" class="btn btn-primary">Realizar una solicitud</a>
            </div>
        </div>
    </body>
</html>
