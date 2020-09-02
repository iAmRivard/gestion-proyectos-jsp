
<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<%@ include file="conexion.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%    st = conexion.prepareStatement("select concat(e1.nombres,' ',e1.apellidos), concat(e2.nombres,' ',e2.apellidos), "
            + "caso.fecha_inicio, caso.fecha_final from caso inner join empleado e1  on caso.id_programador = e1.id_empleado "
            + "inner join empleado e2  on caso.id_empleado = e2.id_empleado where caso.id_caso=?");

    st.setString(1, request.getParameter("id_caso"));
    ResultSet info_caso = st.executeQuery();
    info_caso.next();

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Solicitud en espera de respuesta</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/menu.css"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script type="text/javascript" charset="utf8" src="./js/jquery-3.4.0.js"></script>

        <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
        <script src="https://unpkg.com/gijgo@1.9.13/js/messages/messages.es-es.js" type="text/javascript"></script>
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />

    </head>
    <body>
        <%//Incluimos el menú con las opciones para el jefe de sistemas.%>
        <%@ include file="include/menu_jefe_sistemas.jsp"%>

        <script>

            $(document).ready(function () {

                var today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());

                $('#datepicker2').datepicker({
                    uiLibrary: 'bootstrap4',
                    locale: 'es-es',
                    format: 'yyyy-mm-dd',
                    minDate: today
                });

            });

        </script>


        <% if(request.getParameter("id_caso")!=null){ %>

        <div id="aceptar_solicitud" name="aceptar_solicitud" class="mt-5">
            <h1 class="text-center">Formulario para actualizar información de caso</h1>
            <div class="d-flex justify-content-center mt-5 mb-5" >
                <form class="w-50" method="post" action="actualizar_caso.jsp">

                    <div class="form-group">
                        <label for="programador">Seleccione el nuevo programador a quien asignará el caso</label>
                        <select class="custom-select mr-sm-2" name="programador">
                            <%
                                st = conexion.prepareStatement("select empleado.id_empleado,concat(empleado.nombres,' ',empleado.apellidos) as 'Empleado' "
                                        + " from empleado inner join departamento on empleado.id_departamento=departamento.id_departamento "
                                        + " inner join  roles on empleado.id_rol=roles.id_rol "
                                        + "where departamento.descripcion='Departamento de desarrollo web' and roles.descripcion='Programador'");

                                ResultSet programadores_departamento = st.executeQuery();

                                if (programadores_departamento.next()) {

                                    programadores_departamento.beforeFirst();
                                    while (programadores_departamento.next()) {

                                        if (info_caso.getString(1).equals(programadores_departamento.getString(2))) {
                            %>

                            <option value="<%=programadores_departamento.getString(1)%>" selected><%=programadores_departamento.getString(2)%></option>

                            <%} else {%>

                            <option value="<%=programadores_departamento.getString(1)%>"><%=programadores_departamento.getString(2)%></option>   

                            <%
                                        }
                                    }

                                } else {
                                    out.println("<option>El departamento no posee programadores.</option>");
                                }
                            %>
                        </select>

                    </div>

                    <div class="form-group">
                        <label for="empleado">Seleccione el nuevo empleado que realizará las pruebas una vez el caso haya terminado</label>
                        <select class="custom-select mr-sm-2" name="empleado">
                            <%
                                st = conexion.prepareStatement("select empleado.id_empleado,concat(empleado.nombres,' ',empleado.apellidos) as 'Empleado' "
                                        + " from empleado inner join departamento on empleado.id_departamento=departamento.id_departamento "
                                        + " inner join  roles on empleado.id_rol=roles.id_rol "
                                        + "where departamento.descripcion='Departamento de desarrollo web' and roles.descripcion='Empleado de área'");

                                ResultSet empleados_departamento = st.executeQuery();

                                if (empleados_departamento.next()) {

                                    empleados_departamento.beforeFirst();
                                    while (empleados_departamento.next()) {
                                        if (empleados_departamento.getString(2).equals(info_caso.getString(2))) {


                            %>

                            <option value="<%=empleados_departamento.getString(1)%>" selected><%=empleados_departamento.getString(2)%></option>

                            <%} else {%>
                            <option value="<%=empleados_departamento.getString(1)%>"><%=empleados_departamento.getString(2)%></option>

                            <%
                                        }
                                    }
                                } else {
                                    out.println("<option>El departamento no posee empleados de àrea.</option>");
                                }
                            %>
                        </select>

                    </div>    

                    <div class="form-group">
                        <label for="fecha_inicio">Fecha de inicio del caso.</label>
                        <input id="datepicker" class="form-control hover_date" name="fecha_inicio" value="<%=info_caso.getString(3)%>" 
                               autocomplete="off" readonly="on"/>

                    </div>    

                    <div class="form-group">
                        <label for="fecha_final">Seleccione la nueva fecha de finalización (click sobre el siguiente campo)</label>
                        <input id="datepicker2" class="form-control hover_date" name="fecha_final" value="<%=info_caso.getString(4)%>"
                               autocomplete="off" readonly="on"/>

                    </div>   

                    <input type="hidden" value="<%=request.getParameter("id_caso")%>" name="id_caso">
                    <div class="d-flex justify-content-center">
                        <input type="submit" value="Actualizar caso" name="btn_aceptar" class="btn btn-success">
                    </div>
            </div>   
        </form> 

    </div>                           


    <% }%>

    <div class="d-flex justify-content-center mt-3 mb-3">

        <a class="btn btn-secondary" href="tabla_modificar_casos.jsp">Regresar</a>

    </div>


</body>
</html>
