<%@page session="true" language="java" import="java.util.*" %>
<%@ include file="conexion.jsp"%>


<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">


        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./css/menu.css"/>

    </head>
    <body>

     

        <%//Incluimos el menú con las opciones para el administrador.%>
        <%@ include file="include/menu.jsp"%>

        <%
            String ID = request.getParameter("id_departamento"); //Obtenemos el ID mediante url.

            st = conexion.prepareStatement("SELECT d.descripcion,concat(e.nombres,' ',e.apellidos) as 'Jefe de área',concat(e2.nombres,' ',e2.apellidos) "
                    + " as 'Jefe de sistema', d.id_departamento "
                    + " FROM departamento d "
                    + " left JOIN empleado e ON d.id_jefe=e.id_empleado "
                    + " left JOIN empleado e2 ON d.id_desarrollador=e2.id_empleado "
                    + " where d.id_departamento=? group by d.id_departamento "); //Realizamos la consulta.

            st.setString(1, ID);

            ResultSet informacion_departamento = st.executeQuery(); //Obtenemos el registro.

        %>

        <h1 class="text-center m-3">Formulario para actualizar información de departamento</h1>
        <p class="text-center">Si desea cambiar la información del departamento, modifique los campos que necesita actualizar.</p>   

        <%            HttpSession sesionOk = request.getSession(); //Iniciamos sesión.

            if (sesionOk.getAttribute("mensaje_actualizar_departamento") != null && !sesionOk.getAttribute("mensaje_actualizar_departamento").equals("")) { //Verificamos si la sesión tiene el atributo mensaje.
                //NOTA: El nombre del atributo no se puede repetir en ninguna otra página de la aplicación.
%>
        <div class="d-flex justify-content-center">
            <div class="alert alert-danger w-50">
                <strong>¡Error! </strong> <%=sesionOk.getAttribute("mensaje_actualizar_departamento") //Se muestra el error en el proceso.
                            %>

                <br>
            </div>
        </div>    
        <% } %>

        <div class="d-flex justify-content-center">

            <%
                if (informacion_departamento.next()) { //Verifica si la consulta devuelve un registro.
                    //Este código se ejecuta cuando la página recibe un parámetro válido y
                    //el id del departamento existe.

                    String JefeA, JefeD; //Declaramos variables que recibirán el nombre de los jefes.

                    //Asignamos los valores
                    JefeA = informacion_departamento.getString(2);
                    JefeD = informacion_departamento.getString(3);

                    //Los siguientes condicionales son para verificar que los campos
                    // de los jefes de un departamento, no sean NULL
                    //(no haya jefes asignados).
                    if (JefeA == null) {
                        JefeA = "Aún no se ha asignado jefe de área.";
                    }

                    if (JefeD == null) {
                        JefeD = "Aún no se ha asignado jefe de desarrollo.";
                    }


            %>
            <form action="actualizar_departamentos.jsp" method="post" class="w-50">

                <label for="id">ID del departamento:</label>
                <input type="text" class="form-control" autocomplete="off" value="<%=informacion_departamento.getString(4)%>"  name="id" readonly="on" >

                <label for="descripcion">Ingrese la descripción del departamento</label>
                <input type="text" class="form-control" name="descripcion" value="<%=informacion_departamento.getString(1)%>" autocomplete="off" id="descripcion">

                <label for="jefe_area">Jefe de área del departamento:</label>
                <input type="text" class="form-control" autocomplete="off" value="<%=JefeA%>"  name="jefe_area" readonly="on" >

                <label for="jefe_desarrollo">Jefe de desarrollo del departamento:</label>
                <input type="text" class="form-control" autocomplete="off" value="<%=JefeD%>"  name="jefe_desarrollo" readonly="on" >

                <div class="d-flex justify-content-center m-2">

                    <input type="submit" value="Actualizar departamento" class="w-50 btn btn-success">

                </div>

            </form>

            <%} else {%>
            <div class="alert alert-danger w-50">

                Error, no se ha enviado un ID válido. No se ha encontrado información.

            </div>

            <%}%>

        </div>

        <div class="d-flex justify-content-center">
            <a href="departamentos.jsp" class="btn btn-primary mt-3 mb-3">Regresar a la lista de departamentos</a>          
        </div>

        <% //Removemos el atributo, para que el mensaje de error solo se muestre 1 vez.
            sesionOk.removeAttribute("mensaje_actualizar_departamento");
            conexion.close();%>



    </body>
</html>
