
<%@page session="true" language="java" import="java.util.*" %>

<%

      HttpSession sesion_usuario = request.getSession(); //Creamos la sesión del usuario.
      
      //Configuramos que el navegador del cliente no guarde cache de la sesión 
      //del usuario.
      response.setHeader("Cache-Control","no-cache");
      response.setHeader("Cache-Control","no-store");
      response.setHeader("Pragma","no-cache");
      response.setDateHeader("Expires", 0);
      
      if(sesion_usuario.getAttribute("rol")!=null){
  
          
     }else{
          
          response.sendRedirect("Login.jsp");
      }

      

%>