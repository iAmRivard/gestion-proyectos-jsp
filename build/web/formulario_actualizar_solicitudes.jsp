
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
        <title>Formulario actualizar solicitud</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/menu.css"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    </head>
    <body>

        <%//Realizamos consulta%>
        <sql:query var="tipos_caso" dataSource="jdbc/mysql">
            SELECT * FROM tipo_caso
        </sql:query>


      
        <sql:query var="info_solicitud" dataSource="jdbc/mysql">

            select id_solicitud,id_tipo,descripcion,archivo_info
            from solicitud_caso
            where id_solicitud=?

            <sql:param value="${param.id_solicitud}"/>

        </sql:query>

        <%//Incluimos el menú con las opciones para el jefe de área.%>
        <%@ include file="include/menu_jefe_area.jsp"%>

        <% //Verificamos que la consulta de los datos a la BDD, devuelva registros (existe la solicitud)%>
        <c:if test="${info_solicitud.rows[0].id_solicitud!=null}">

            <h2 class="mt-3 mb-3 text-center">Formulario para actualizar información de una solicitud</h2>

            <p class="text-center mt-2 mb-2">En esta página, si desea modificar la información de una solicitud, edite el campo 
                que desee.</p>

            <div class="d-flex justify-content-center mt-3 mb-3">

                <form action="actualizar_solicitud.jsp" method="post" class="w-50">
                    <div class="form-group">
                        <label for="tipo">Tipo de caso para la solicitud</label>
                        <select class="custom-select mr-sm-2" name="tipo">

                            <%//Cargamos los tipos de caso en una etiqueta select-option%>
                            <c:forEach var="tipo" items="${tipos_caso.rows}">

                                <c:choose>
                                    <c:when test="${tipo.id_tipo==info_solicitud.rows[0].id_tipo}">

                                        <option value="<c:out value='${tipo.id_tipo}'/>" selected><c:out value="${tipo.descripcion}"/></option>

                                    </c:when>

                                    <c:when test="${tipo.id_tipo!=info_solicitud.rows[0].id_tipo}">

                                        <option value="<c:out value='${tipo.id_tipo}'/>"><c:out value="${tipo.descripcion}"/></option>

                                    </c:when>    


                                </c:choose>

                            </c:forEach>

                        </select>
                    </div>

                    <div class="form-group">
                        <label for="descripcion">Descripción de la solicitud</label>
                        <textarea class="form-control textarea" id="descripcion"  name="descripcion" rows="3" ><c:out value="${info_solicitud.rows[0].descripcion}" /></textarea>
                    </div>

                    <input type="hidden" value="<c:out value="${param.id_solicitud}"/>" name="id_solicitud">


                    <div class="d-flex justify-content-center mt-3 mb-3">
                        <input type="submit" class="btn btn-success" value="Actualizar información de solicitud">
                    </div>
                </form>



            </div>

            <c:if test="${info_solicitud.rows[0].archivo_info!=null}">
                <div class="border ml-3 mr-3">    
                    <p class="text-center m-3">Esta solicitud contiene un archivo pdf</p>
                    <div class="d-flex justify-content-center m-3">    

                        <a target="_blank" href="mostrar_pdf_solicitud.jsp?id_solicitud=<c:out value="${info_solicitud.rows[0].id_solicitud}" />" class="btn btn-info">Ver archivo pdf adjunto</a>

                    </div>
                </div>
            </c:if> 

        </c:if> 
        <%//Este condición se ejecuta si el programa no encuentra información por que el
           //ID de la solicitud no existe  o el parámetro del url no ha sido recibido.%> 
        <c:if test="${info_solicitud.rows[0].id_solicitud==null}">

            <div class="alert alert-danger text-center m-4">
                Error, no se ha encontrado información de la solicitud.

            </div>

        </c:if>

        <div class="d-flex justify-content-center mt-3 mb-3">
            <a href="solicitudes.jsp" class="btn btn-primary">Ver todas las solicitudes hechas</a>
        </div>


    </body>
</html>
