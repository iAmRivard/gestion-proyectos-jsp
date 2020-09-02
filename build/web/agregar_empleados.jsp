
<%@page session="true" language="java" import="java.util.*" %>
<%@ page import="Validaciones.CheckPassword" %>
<%@ include file="conexion.jsp"%>
<jsp:useBean id="empleado" class="Mantenimiento.Empleado"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% // ==============Asignando las propiedades al Bean===========%>
<jsp:setProperty name="empleado" property="id" param="id"/>
<jsp:setProperty name="empleado" property="nombre" param="nombres"/>
<jsp:setProperty name="empleado" property="apellido" param="apellidos"/>
<jsp:setProperty name="empleado" property="usuario" param="usuario"/>
<jsp:setProperty name="empleado" property="contra" param="contra"/>
<jsp:setProperty name="empleado" property="correo" param="correo"/>
<jsp:setProperty name="empleado" property="rol" param="rol"/>
<jsp:setProperty name="empleado" property="departamento" param="departamento"/>


<%
    HttpSession sesionOk = request.getSession(); //Creamos una sesión.
    sesionOk.setAttribute("mensaje_agregar_empleado", "");

    String contrasenia = request.getParameter("contra"); //Se obtiene el parámetro de la contraseña.
    char[] contra = contrasenia.toCharArray(); //Se convierte el String a un arreglo de tipo char.
    CheckPassword validar = new CheckPassword(); //Instanciamos la clase para validar la contraseña.

    Boolean peticion = false;

    try {

        //===========
        //=====NOTA: el parámetro "rol" y "departamento" maneja los ID respectivos, no la descripción.
        //===========
        //Obteniendo el ID del jefe del departamento seleccionado en el formulario.
        st = conexion.prepareStatement("Select id_departamento,id_jefe from departamento where id_departamento =?");
        st.setString(1, empleado.getDepartamento());
        ResultSet id_jefeD = st.executeQuery();
        id_jefeD.next();
        //Obteniendo el ID del jefe del sistema del dep. seleccionado en el formulario.
        st = conexion.prepareStatement("select id_departamento,id_desarrollador from departamento where id_departamento=?");
        st.setString(1, empleado.getDepartamento());
        ResultSet id_jefeS = st.executeQuery();
        id_jefeS.next();

        //Verificando si el usuario que se quiere asignar al nuevo empleado
        // ya está en uso. (Realizamos consulta).
        st = conexion.prepareStatement("select count(usuario) from empleado where usuario=?");
        st.setString(1, empleado.getUsuario());
        ResultSet usuario = st.executeQuery();
        usuario.next();

        //Verificando si el correo que se quiere asignar al nuevo empleado
        // ya está en uso. (Realizamos consulta).
        st = conexion.prepareStatement("select count(correo) from empleado where correo=?");
        st.setString(1, empleado.getCorreo());
        ResultSet correo = st.executeQuery();
        correo.next();

        //Obtener la descripción del rol seleccionado.
        st = conexion.prepareStatement("select descripcion from roles where id_rol=?");
        st.setString(1, empleado.getRol());
        ResultSet rol_seleccionado = st.executeQuery();
        rol_seleccionado.next();

//Validando datos.
        if (request.getParameter("id").trim().isEmpty()) { // ===================Validaciones para el ID.

            sesionOk.setAttribute("mensaje_agregar_empleado", "No se ha enviado el ID del nuevo empleado."); //Creamos un atributo con el mensaje de error a notificar con el usuario.

        } else if (request.getParameter("id").trim().length() > 11) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "La longitud del ID es muy extensa.");

        } else if (request.getParameter("nombres").trim().isEmpty()) { // ===================Validaciones para el Nombre.

            sesionOk.setAttribute("mensaje_agregar_empleado", "No ha ingresado el nombre del nuevo empleado."); //Creamos un atributo con el mensaje de error a notificar con el usuario.

        } else if (request.getParameter("nombres").trim().length() > 100) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "La longitud del nombre del nuevo empleado es muy extensa.");

        } else if (request.getParameter("apellidos").trim().isEmpty()) { // ===================Validaciones para el Apellido.

            sesionOk.setAttribute("mensaje_agregar_empleado", "No ha ingresado el apellido del nuevo empleado."); //Creamos un atributo con el mensaje de error a notificar con el usuario.

        } else if (request.getParameter("apellidos").trim().length() > 100) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "La longitud del apellido del nuevo empleado es muy extensa.");

        } else if (request.getParameter("usuario").trim().isEmpty()) { // ===================Validaciones para el Usuario.

            sesionOk.setAttribute("mensaje_agregar_empleado", "No ha ingresado el usuario para el nuevo empleado."); //Creamos un atributo con el mensaje de error a notificar con el usuario.

        } else if (request.getParameter("usuario").trim().length() > 20) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "La longitud del usuario para el nuevo empleado es muy extensa.");

        } else if (usuario.getInt(1) == 1) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "El dato para el campo usuario, ya lo tiene otro empleado.");

        } else if (request.getParameter("contra").trim().isEmpty()) { // ===================Validaciones para la contraseña.

            sesionOk.setAttribute("mensaje_agregar_empleado", "No ha ingresado una contraseña para el nuevo empleado."); //Creamos un atributo con el mensaje de error a notificar con el usuario.

        } else if (request.getParameter("contra").trim().length() > 50) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "La longitud de la contraseña para el nuevo empleado es muy extensa.");

        } else if (!validar.verificarPassword(contra)) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "La contraseña solo puede tener letras y números.");

        } else if (request.getParameter("correo").trim().isEmpty()) { // ===================Validaciones para el Correo.

            sesionOk.setAttribute("mensaje_agregar_empleado", "No ha ingresado el correo para el nuevo usuario."); //Creamos un atributo con el mensaje de error a notificar con el usuario.

        } else if (request.getParameter("correo").trim().length() > 100) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "La longitud del correo para el nuevo empleado es muy extensa.");

        } else if (correo.getInt(1) == 1) {

            sesionOk.setAttribute("mensaje_agregar_empleado", "El dato para el campo correo, ya lo tiene otro empleado.");

        } else if (request.getParameter("rol").trim().isEmpty()) { // ===================Validaciones para el Rol.

            sesionOk.setAttribute("mensaje_agregar_empleado", "No se ha seleccionado un rol válido.");

        } else if (request.getParameter("departamento").trim().isEmpty()) { // ===================Validaciones para el Departamento.

            sesionOk.setAttribute("mensaje_agregar_empleado", "No se ha seleccionado un departamento válido.");

//=============Validaciones para ingreso de nuevo empleado.===============
        } else if (id_jefeD.getInt(2) == 0 && rol_seleccionado.getString(1).equals("Jefe de áreas funcionales")) {
            //Se llevará a cabo este código, cuando no hay jefe asignado
            //en el departamento donde se quiere agregar el nuevo empleado y
            // dicho rol del nuevo empleado es jefe de área.

            st = conexion.prepareStatement("insert into empleado VALUES (?,?,?,?,?,?,?,?)");
            st.setString(1, empleado.getId());
            st.setString(2, empleado.getNombre());
            st.setString(3, empleado.getApellido());
            st.setString(4, empleado.getUsuario());
            st.setString(5, empleado.getContra());
            st.setString(6, empleado.getCorreo());
            st.setString(7, empleado.getRol());
            st.setString(8, empleado.getDepartamento());

            st.executeUpdate();

            st = conexion.prepareStatement("update departamento set id_jefe=? where id_departamento=? ");
            st.setString(1, empleado.getId());
            st.setString(2, empleado.getDepartamento());
            st.executeUpdate();
            peticion = true;
            //    out.println("Se ha ingresado el empleado. (msg 1)");

        } else if (!rol_seleccionado.getString(1).equals("Jefe de áreas funcionales") && !rol_seleccionado.getString(1).equals("Jefe de desarrollo")) {
            //Este código se va a ejecutar cuando el rol del nuevo empleado
            //no es ni jefe de desarrollo ni jefe de área.

            st = conexion.prepareStatement("insert into empleado VALUES (?,?,?,?,?,?,?,?)");
            st.setString(1, empleado.getId());
            st.setString(2, empleado.getNombre());
            st.setString(3, empleado.getApellido());
            st.setString(4, empleado.getUsuario());
            st.setString(5, empleado.getContra());
            st.setString(6, empleado.getCorreo());
            st.setString(7, empleado.getRol());
            st.setString(8, empleado.getDepartamento());

            st.executeUpdate();
            peticion = true;
            //   out.println("Se ha ingresado el empleado. (msg 2)");

        } else if (id_jefeD.getInt(2) >= 1 && rol_seleccionado.getString(1).equals("Jefe de áreas funcionales")) {
            //Este código se va a ejecutar si se quiere agregar un empleado con rol
            // de jefe de área, a un departamento que ya tiene asignado un jefe.

            sesionOk.setAttribute("mensaje_agregar_empleado", "Ya hay un jefe de área asignado a ese departamento.");

        } else if (id_jefeS.getInt(2) == 0 && rol_seleccionado.getString(1).equals("Jefe de desarrollo")) {
            //Este código se ejecuta cuando se quiere ingresar un jefe de sistemas
            //a un departamento que aún no tiene asignado jefe de sistemas.

            st = conexion.prepareStatement("insert into empleado VALUES (?,?,?,?,?,?,?,?)");
            st.setString(1, empleado.getId());
            st.setString(2, empleado.getNombre());
            st.setString(3, empleado.getApellido());
            st.setString(4, empleado.getUsuario());
            st.setString(5, empleado.getContra());
            st.setString(6, empleado.getCorreo());
            st.setString(7, empleado.getRol());
            st.setString(8, empleado.getDepartamento());

            st.executeUpdate();

            st = conexion.prepareStatement("update departamento set id_desarrollador=? where id_departamento=? ");
            st.setString(1, empleado.getId());
            st.setString(2, empleado.getDepartamento());
            st.executeUpdate();
            peticion = true;
            //    out.println("Se ha ingresado el empleado. (msg 3)");

        } else if (id_jefeS.getInt(2) >= 1 && rol_seleccionado.getString(1).equals("Jefe de desarrollo")) {
            //Este código se ejecutará cuando se quiere ingresar un empleado (jefe de sistemas)
            /// y asignarlo a un departamento que ya tiene asignado jefe de sistemas.

            sesionOk.setAttribute("mensaje_agregar_empleado", "Ya hay un jefe de sistemas asignado a ese departamento.");
        }

        conexion.close();

        if (!sesionOk.getAttribute("mensaje_agregar_empleado").equals("")) { //Se verifica si no hay algún error en los campos (verificar si los datos están validados).
            response.sendRedirect("formulario_empleados.jsp"); //Los datos no están validados y redirecciona al formulario.
        }

    } catch (SQLException ex) {
        out.println("Se ha encontrado el siguiente error: " + ex.toString());
    }


%>





<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar nuevo empleado</title>

        <link rel="stylesheet" href="./css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </head>
    <body>
        <%           if (peticion) {

        %>
        <script>
            $(document).ready(function () {
                $('#mensaje_agregar_empleado').modal({backdrop: 'static', keyboard: false});
            });
        </script>
        <!-- Modal -->
        <div class="modal fade" id="mensaje_agregar_empleado" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-center w-100" id="exampleModalCenterTitle">Mensaje</h5>

                    </div>
                    <div class="modal-body text-center">
                        El empleado ha sido agregado a la base de datos del sistema.
                    </div>
                    <div class="modal-footer d-flex justify-content-center">
                        <a class="btn btn-primary" href="formulario_empleados.jsp">Agregar otro empleado</a>
                        <a  class="btn btn-success" href="empleados.jsp">Ver todos los empleados</a>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
    </body>
</html>
