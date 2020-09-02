

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="true" %>
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

        
        <c:if test="${param.id_solicitud==null}">
            
            <c:redirect url="solicitudes.jsp">
                
            </c:redirect>
            
        </c:if>
        

               <c:set target="${solicitud}" property="id_solicitud" value="${param.id_solicitud}" />
               <c:set target="${solicitud}" property="tipo_caso" value="${param.tipo}" />
               <c:set target="${solicitud}" property="descripcion" value="${param.descripcion}" />
              
               <c:set var="descripcion" value="${param.descripcion}" />
               
               <c:set var="errores" value="" />
               
               <c:choose>
                   
                   <c:when test="${descripcion.trim().isEmpty()}" >
                       
                       <c:set var="errores" value="No ha ingresado la descripción del caso." /> 
                       
                   </c:when>
                   
                    <c:when test="${descripcion.length()>500}" >
                       
                       <c:set var="errores" value="El dato ingresado en el campo descripción es muy extenso, debe ser más corto." /> 
                       
                   </c:when>
                   
               </c:choose>
               
              <% //Si no hay errores ingresa los datos.%> 
               
               <c:if test="${errores==''}" >
               
                           
                 
                
                 


                  <sql:update var="actualizar" dataSource="jdbc/mysql">
                     
                      update solicitud_caso set id_tipo=?,descripcion=? where id_solicitud=?
                     <sql:param value="${solicitud.tipo_caso}"/>
                     <sql:param value="${solicitud.descripcion}"/>
                     <sql:param value="${solicitud.id_solicitud}"/>

                 </sql:update>
                   
                   <div class="alert alert-success text-center m-5"><c:out value="La información de la solicitud ha sido actualizada." /></div>
                   
               </c:if>    
                   
               
              <% //Si hay errores, muestra el mensaje de error.%>
              
                <c:if test="${errores!=''}" >
                   
                    <div class="alert alert-danger text-center m-5"><c:out value="${errores}" /></div>
                   
               </c:if>
                
           
                    
                    <div class="d-flex justify-content-center">
                        
                        <a href="solicitudes.jsp" class="btn btn-primary mt-2 mb-2">Ver todas las solicitudes</a>
                        
                    </div>
         
        
    </body>
</html>
