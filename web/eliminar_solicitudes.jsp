
<%@page import="java.io.File"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar solicitud</title>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">        
    </head>
    <body>




        <script>
            $(document).ready(function () {
                $('#confirmacion_eliminar').modal({backdrop: 'static', keyboard: false});
            });


        </script>

        <c:if test="${param.id_solicitud!=null}">
            <!-- Modal -->
            <div class="modal fade" id="confirmacion_eliminar" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title text-center w-100" id="exampleModalCenterTitle">Confirmar acción</h5>

                        </div>
                        <div class="modal-body text-center">
                            ¿Está seguro que desea borrar la solicitud seleccionada?
                            Si acepta, esta acción es irreversible.
                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <a class="btn btn-primary" href="solicitudes.jsp">Cancelar</a>
                            <a  class="btn btn-danger" href="eliminar_solicitudes.jsp?id_eliminar=<c:out value="${param.id_solicitud}"/>">Eliminar solicitud</a>
                        </div>
                    </div>
                </div>
            </div>

        </c:if>

        <c:if test="${param.id_eliminar!=null}">

            <sql:query var="archivo_solicitud" dataSource="jdbc/mysql">
                select archivo_info from solicitud_caso where id_solicitud=?

                <sql:param value="${param.id_eliminar}"/>

            </sql:query>


            <sql:update var="eliminar" dataSource="jdbc/mysql">

                delete from solicitud_caso where id_solicitud=?

                <sql:param value="${param.id_eliminar}"/>

            </sql:update>      

            <c:if test="${archivo_solicitud.rows[0].archivo_info!=null}">
                <c:set var="archivo" value="${archivo_solicitud.rows[0].archivo_info}"/>        
                <%
                    String path = getClass().getClassLoader().getResource(".").getPath() + "archivos/"; //Directorio de subida.
                    String nombre_archivo = pageContext.getAttribute("archivo").toString();
                    File file = new File(path + nombre_archivo);

                    file.delete(); //borro el archivo
                %>           
            </c:if>    

            <c:redirect url="solicitudes.jsp">

            </c:redirect>  

        </c:if>        

        <c:if test="${param.id_solicitud == null && param.id_eliminar==null}">

            <div class="alert alert-danger text-center m-5">
                Error, no se puede realizar la acción. Faltan parámetros.

            </div>

            <div class="d-flex justify-content-center">

                <a href="solicitudes.jsp" class="btn btn-primary">Volver a listado de solicitudes</a>

            </div>

        </c:if>                 

    </body>
</html>
