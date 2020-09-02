
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
        <link rel="stylesheet" href="./css/menu.css"/>
        <title>Formulario para realizar solicitud</title>
    </head>
    <body>
        <%//Realizamos consulta%>
        <sql:query var="tipos_caso" dataSource="jdbc/mysql">
            SELECT * FROM tipo_caso
        </sql:query>



        <%
            // HttpSession sesionOk=request.getSession(); //Iniciamos sesión.
            //sesionOk.setAttribute("bandera_formulario", "1");
        %>

        <c:set var="formulario" scope="session">
            1
        </c:set>

        <%//Incluimos el menú con las opciones para el jefe de área.%>
        <%@ include file="include/menu_jefe_area.jsp"%>

        <h2 class="mt-3 mb-3 text-center">Formulario para agregar nueva solicitud de caso</h2>

        <div class="d-flex justify-content-center mt-3 mb-3">

            <form action="agregar_solicitud.jsp" method="post" class="w-50" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="tipo">Seleccione el tipo de caso para la solicitud</label>
                    <select class="custom-select mr-sm-2" name="tipo">

                        <%//Cargamos los tipos de caso en una etiqueta select-option%>
                        <c:forEach var="tipo" items="${tipos_caso.rows}">
                            <option value="<c:out value='${tipo.id_tipo}'/>"><c:out value="${tipo.descripcion}"/></option>
                        </c:forEach>

                    </select>
                </div>


                <div class="form-group">
                    <label for="descripcion">Ingrese la descripción de la solicitud</label>
                    <textarea class="form-control textarea" id="descripcion" name="descripcion" rows="3" ></textarea>
                </div>

                <p>Agregue (si lo desea) un archivo pdf para detallar más sobre el caso</p>
                <div class="custom-file">

                    <input type="file" class="custom-file-input" id="customFileLangHTML" name="archivo" accept=".pdf">
                    <label class="custom-file-label" for="customFileLangHTML" data-browse="Explorar en mi equipo">Seleccionar archivo</label>
                </div>




                <div class="d-flex justify-content-center mt-3 mb-3">
                    <input type="submit" class="btn btn-success" value="Ingresar solicitud">
                </div>
            </form>


        </div>

        <div class="d-flex justify-content-center mt-3 mb-3">
            <a href="solicitudes.jsp" class="btn btn-primary">Ver las solicitudes hechas</a>
        </div>


    </body>
</html>
