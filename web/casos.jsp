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
        <title>Listado casos</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>

    </head>
    <body>




        <%//Incluimos el menú con las opciones para el jefe de sistemas.%>
        <%@ include file="include/menu_jefe_sistemas.jsp"%>

        <h1 class="text-center mt-3 mb-3" style="margin-left:70px;">Lista de casos ingresados al sistema</h1>


        <sql:query var="casos" dataSource="jdbc/mysql">
            select caso.id_caso,solicitud_caso.descripcion, caso.fecha_inicio,caso.fecha_final,estado_caso.Descripción,caso.porcentaje_avance
            from caso
            inner join estado_caso on caso.id_estado=estado_caso.id_estado
            inner join solicitud_caso on caso.id_solicitud=solicitud_caso.id_solicitud
            inner join departamento on solicitud_caso.id_departamento=departamento.id_departamento
            where departamento.descripcion=?
            <sql:param value='<%=sesion_usuario.getAttribute("departamento")%>' />
        </sql:query>

        <div class="d-flex justify-content-center w-100" >    

            <table id="tabla_solicitudes" class="w-100 table table-striped table-bordered" style="width:100%;">
                <thead>
                    <tr>
                        <th>Descripción de caso</th>
                        <th>Fecha de inicio</th>
                        <th>Fecha final</th>
                        <th>Estado del caso</th>
                        <th>% del caso</th>
                        <th>Informacion</th>
                        <th>Bitacora</th>


                    </tr>
                </thead>
                <tbody>

                    <c:forEach var="casos" items="${casos.rowsByIndex}">
                        <tr>

                            <td><c:out value="${casos[1]}"/></td>
                            <td><c:out value="${casos[2]}"/></td>
                            <td><c:out value="${casos[3]}"/></td>
                            <td><c:out value="${casos[4]}"/></td>
                            <td><c:out value="${casos[5]}"/></td>
                            <td>
                                <div class="d-flex justify-content-center flex-wrap">
                                    <a href="info_caso.jsp?id_caso=${casos[0]}" >Informacion</a>
                                </div>
                            </td>
                            <td>
                                <div class="d-flex justify-content-center flex-wrap">
                                    <a href="bitacora.jsp?id_caso=${casos[0]}" >Bitacora</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>

            </table>
        </div>

    </body>
</html>
