<%

    session.invalidate(); //Destruimos la sesi�n del usuario.
    
    
    
    response.sendRedirect("Login.jsp");

%>