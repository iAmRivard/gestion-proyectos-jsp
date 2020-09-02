<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import= "java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <sql:query var="info_solicitud" dataSource="jdbc/mysql">

            select id_solicitud,archivo_info
            from solicitud_caso
            where id_solicitud=?

            <sql:param value="${param.id_solicitud}"/>

        </sql:query>

        <c:if test="${info_solicitud.rows[0].archivo_info!=null}">

            <c:set var="archivo" value="${info_solicitud.rows[0].archivo_info}" />

            <%

                String path = getClass().getClassLoader().getResource(".").getPath() + "archivos/"; //Directorio de subida.
                String nombre_archivo = pageContext.getAttribute("archivo").toString();

                //CODIGO JSP 
                FileInputStream ficheroInput = new FileInputStream(path + nombre_archivo);
                int tamanoInput = ficheroInput.available();
                byte[] datosPDF = new byte[tamanoInput];
                ficheroInput.read(datosPDF, 0, tamanoInput);

                response.setHeader("Content-disposition", "inline; filename=" + nombre_archivo + "");
                response.setContentType("application/pdf");
                response.setContentLength(tamanoInput);
                response.getOutputStream().write(datosPDF);

                ficheroInput.close();

            %>   

        </c:if>

        <c:if test="${info_solicitud.rows[0].archivo_info==null}">

            <c:redirect url="solicitudes.jsp">

            </c:redirect>

        </c:if>

    </body>
</html>
