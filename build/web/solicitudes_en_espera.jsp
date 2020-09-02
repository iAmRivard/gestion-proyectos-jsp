
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de solicitudes en espera</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>



        <%//Incluimos el menú con las opciones para el jefe de sistemas.%>
        <%@ include file="include/menu_jefe_sistemas.jsp"%>

        <h1 class="text-center mt-3 mb-3" style="margin-left:70px;">Listado de solicitudes en espera</h1>

        <p class="text-center mt-3 mb-3">Rechazar o aceptar</p>


        <sql:query var="solicitudes_en_espera" dataSource="jdbc/mysql">
            select solicitud_caso.descripcion as 'D1',tipo_caso.descripcion as 'D2',solicitud_caso.fecha,id_solicitud
            from solicitud_caso
            inner join tipo_caso on solicitud_caso.id_tipo=tipo_caso.id_tipo
            inner join departamento on solicitud_caso.id_departamento=departamento.id_departamento
            inner join estado_solicitud on solicitud_caso.id_estado=estado_solicitud.id_estado
            where departamento.descripcion=? and estado_solicitud.descripcion='En espera de respuesta'

            <sql:param value='<%=sesion_usuario.getAttribute("departamento")%>' />
        </sql:query>

        <div class="d-flex justify-content-center w-100" >    

            <div class="d-flex justify-content-center mb-3 mt-3 mr-3" >
                <table id="tabla_solicitudes" class="w-100 table table-striped table-bordered" style="width:100%;">
                    <thead>
                        <tr>
                            <th>Descripción de solicitud</th>
                            <th>Tipo de caso</th>
                            <th>Fecha de solicitud</th>
                            <th>Acciones</th>

                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="solicitud" items="${solicitudes_en_espera.rowsByIndex}">
                            <tr>

                                <td><c:out value="${solicitud[0]}"/></td>
                                <td><c:out value="${solicitud[1]}"/></td>
                                <td><c:out value="${solicitud[2]}"/></td>
                                <td><div class="d-flex justify-content-center flex-wrap">
                                        <a href="responder_solicitud.jsp?id_solicitud=${solicitud[3]}" >Responder Solicitud</a>
                                    </div>
                                </td>


                            </tr>

                        </c:forEach>


                    </tbody>

                </table>
            </div>



    </body>
</html>
