<%

    session.invalidate(); //Destruimos la sesión del usuario.
    
    
    
    response.sendRedirect("Login.jsp");

%>