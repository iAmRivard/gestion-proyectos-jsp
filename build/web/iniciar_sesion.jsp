
<%@page session="true" language="java" import="java.util.*" %>
<%@ include file="conexion.jsp"%>


<%    String url_redireccion = "";
    HttpSession mensaje_login = request.getSession(); //Creamos una sesión.
    mensaje_login.setAttribute("mensaje_error_login", ""); //Inicializamos el atributo 
    //que contendrá el error en el proceso del login.

    if (!request.getParameter("usuario").trim().isEmpty()) { //Verificamos que el campo
        //usuario no esté vacío.

        if (!request.getParameter("contra").trim().isEmpty()) { //Verificamos que el campo
            //contraseña no esté vacío.

            //Declaramos la variable que contiene la consulta.
            String consulta = "select nombres,apellidos,usuario,roles.descripcion,departamento.descripcion, "
                    + " empleado.id_empleado,departamento.id_departamento"
                    + " from empleado inner join roles on empleado.id_rol=roles.id_rol "
                    + " inner join departamento on empleado.id_departamento=departamento.id_departamento "
                    + " where usuario=? and contrasena=?";

            st = conexion.prepareStatement(consulta); //Preparamos el statement de la consulta.
            st.setString(1, request.getParameter("usuario")); //Asignamos el parámetro usuario.
            st.setString(2, request.getParameter("contra")); //Asignamos el parámetro contraseña.

            ResultSet info_usuario = st.executeQuery(); //Ejecutamos la consulta.

            if (info_usuario.next()) { //Verificamos si la consulta devuelve un registro.
                //Significa que el usuario existe.

                HttpSession sesion_usuario = request.getSession(); //Creamos la sesión del usuario.
                //Asignamos los atributos de la sesión (información del usuario).
                sesion_usuario.setAttribute("nombre", info_usuario.getString(1));
                sesion_usuario.setAttribute("apellido", info_usuario.getString(2));
                sesion_usuario.setAttribute("usuario", info_usuario.getString(3));
                sesion_usuario.setAttribute("rol", info_usuario.getString(4));
                sesion_usuario.setAttribute("departamento", info_usuario.getString(5));
                sesion_usuario.setAttribute("id_empleado", info_usuario.getString(6));
                sesion_usuario.setAttribute("id_departamento", info_usuario.getString(7));

                //Condicional para redireccionar al perfil correspondiente.
                //Verificamos cuál es el rol de usuario.
                if (sesion_usuario.getAttribute("rol").equals("Administrador")) {

                    url_redireccion = "empleados.jsp";

                } else if (sesion_usuario.getAttribute("rol").equals("Jefe de áreas funcionales")) {

                    url_redireccion = "solicitudes.jsp";

                } else if (sesion_usuario.getAttribute("rol").equals("Jefe de desarrollo")) {

                    url_redireccion = "casos.jsp";

                } else if (sesion_usuario.getAttribute("rol").equals("Empleado de área")) {

                    url_redireccion = "casos_asignados_empleado.jsp";

                } else if (sesion_usuario.getAttribute("rol").equals("Programador")) {

                    url_redireccion = "casos_asignados.jsp";

                }

            } else {
                //El usuario no existe.
                url_redireccion = "Login.jsp";
                mensaje_login.setAttribute("mensaje_error_login", "Error, el usuario no existe en el sistema.");
            }

        } else {
            //No se ha ingresado contraseña.
            url_redireccion = "Login.jsp";
            mensaje_login.setAttribute("mensaje_error_login", "Error, no ha ingresado el dato contraseña.");
        }
    } else {
        //No se ha ingresado el nombre de usuario.
        url_redireccion = "Login.jsp";
        mensaje_login.setAttribute("mensaje_error_login", "Error, no ha ingresado el nombre de usuario.");
    }

    response.sendRedirect(url_redireccion); //Redireccionamos al usuario a la página
    //del login (si en el proceso hay un error) o a la página del perfil.

%>