
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>  
<%@ page import="org.apache.commons.fileupload.disk.*" %>  
<%@ page import="org.apache.commons.fileupload.servlet.*" %>  
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="java.io.*" %>
<%@page import="com.oreilly.servlet.*"   %> 
<%@ page session="true" %>
<%@ include file="Autenticar_usuario.jsp"%>
<jsp:useBean id="solicitud"   scope="page" class="Mantenimiento.Solicitud_Caso"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregando solicitud</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    </head>
    <body>

  

        <c:if test="${formulario==null}">

            <c:redirect url="formulario_solicitudes.jsp">

            </c:redirect>

        </c:if>

        <c:remove var="formulario" scope="session" />


        <sql:query var="codigo" dataSource="jdbc/mysql">
            select max(id_solicitud) as codigo from solicitud_caso
        </sql:query>

        <c:forEach var="id_solicitud" items="${codigo.rows}">
            <c:set target="${solicitud}" property="id_solicitud" value="${(id_solicitud.codigo)+1}" />
        </c:forEach>  

        <%            //Este código es para la subida de archivos.
            String path = getClass().getClassLoader().getResource(".").getPath() + "archivos"; //Directorio de subida.

            File directorio = new File(path);
            directorio.mkdir();

            MultipartRequest mr = new MultipartRequest(request, path, "utf-8"); //Se sube el archivo al servidor y se obtienen parámetros.

            String nuevo_nombre = null; //Inicialmente, el nuevo nombre del fichero es un null.
            String error_tipo_archivo = null;

            if (mr.getFile("archivo") != null) { //Si se ha subido un archivo.

                String tipo_archivo = FilenameUtils.getExtension(mr.getFile("archivo").getName());

                if (tipo_archivo.equals("pdf")) {
                    //out.println("El archivo cumple");

                    nuevo_nombre = "Detalle_" + solicitud.getId_solicitud() + ".pdf"; //Aquí se asigna el nuevo nombre. (hay que generarlo)
                    File archivo_renombrado = new File(path + "/" + nuevo_nombre);

                    boolean correcto = mr.getFile("archivo").renameTo(archivo_renombrado); //Renombramos archivo.

                } else {
                    //out.println("El archivo no cumple");
                    //Borramos el archivo que se ha subido al servidor y no cumple 
                    //con el formato .pdf
                    File file = new File(path + "/" + mr.getFile("archivo").getName());

                    file.delete(); //Código para borrar el archivo.
                    error_tipo_archivo = "Error, el tipo de archivo que quiere subir, no cumple"
                            + " con el formato (.pdf) La solicitud no se ha llevado a cabo.";
                }

            }
            String desc = mr.getParameter("descripcion");
            String tip_solicitud = mr.getParameter("tipo");
        %>

        <c:set var="descripcion" value="<%=desc%>" />
        <c:set var="tipo_soli" value="<%=tip_solicitud%>" />
        <c:set var="nombre_fichero" value="<%=nuevo_nombre%>" />

        <c:set var="errores" value="" />

        <c:choose>

            <c:when test="${descripcion.trim().isEmpty()}" >

                <c:set var="errores" value="No ha ingresado la descripción del caso." /> 

            </c:when>

            <c:when test="${descripcion.length()>500}" >

                <c:set var="errores" value="El dato ingresado en el campo descripción es muy extenso, debe ser más corto." /> 

            </c:when>

            <c:when test="<%=error_tipo_archivo != null%>" >

                <c:set var="errores" value="Error, el tipo de archivo que quiere subir, no cumple
                       con el formato (.pdf) La solicitud no se ha llevado a cabo." /> 

            </c:when>

        </c:choose>

        <% //Si no hay errores ingresa los datos.%> 

        <c:if test="${errores==''}" >

            <c:set target="${solicitud}" property="empleado" value='<%=sesion_usuario.getAttribute("id_empleado")%>' />
            <c:set target="${solicitud}" property="departamento" value='<%=sesion_usuario.getAttribute("id_departamento")%>' />
            <c:set target="${solicitud}" property="tipo_caso" value="${tipo_soli}" />
            <c:set target="${solicitud}" property="descripcion" value="${descripcion}" />
            <c:set target="${solicitud}" property="archivo_info" value="${nombre_fichero}" />
            <c:set target="${solicitud}" property="id_estado" value="1" />


            <sql:update var="insertar" dataSource="jdbc/mysql">
                insert into solicitud_caso (id_solicitud,id_empleado,id_departamento,id_tipo,descripcion,archivo_info,id_estado)
                values (?,?,?,?,?,?,?)

                <sql:param value="${solicitud.id_solicitud}"/>
                <sql:param value="${solicitud.empleado}"/>
                <sql:param value="${solicitud.departamento}"/>
                <sql:param value="${solicitud.tipo_caso}"/>
                <sql:param value="${solicitud.descripcion}"/>
                <sql:param value="${solicitud.archivo_info}" />
                <sql:param value="${solicitud.id_estado}"/>

            </sql:update>

            <div class="alert alert-success text-center m-5"><c:out value="La solicitud ha sido ingresada en el sistema." /></div>

        </c:if>    


        <% //Si hay errores, muestra el mensaje de error.%>

        <c:if test="${errores!=''}" >

            <div class="alert alert-danger text-center m-5"><c:out value="${errores}" /></div>

        </c:if>

        <div class="d-flex justify-content-center">

            <a href="formulario_solicitudes.jsp" class="btn btn-primary mt-2 mb-2">Regresar al formulario</a>

        </div>



    </body>
</html>
