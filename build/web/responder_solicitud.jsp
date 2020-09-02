
<%@page session="true" language="java" import="java.util.*" %>
<%//Incluimos el archivo de autenticación del usuario para verificar que esté
//haya iniciado sesión%>
<%@ include file="Autenticar_usuario.jsp"%>
<%@ include file="conexion.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <style>


            .textarea{
                resize: none;

            }

            .hover_date:hover{
                cursor:pointer;
            }

            /* Tamaño del scroll */
            body::-webkit-scrollbar {
                width: 8px;
                height: 8px;
            }

            /* Estilos barra (thumb) de scroll */
            body::-webkit-scrollbar-thumb {
                background: #ccc;
                border-radius: 4px;
            }

            body::-webkit-scrollbar-thumb:active {
                background-color: #999999;
            }

            body::-webkit-scrollbar-thumb:hover {
                background: #b3b3b3;
                box-shadow: 0 0 2px 1px rgba(0, 0, 0, 0.2);
            }

            /* Estilos track de scroll */
            body::-webkit-scrollbar-track {
                background: #e1e1e1;
                border-radius: 4px;
            }

            body::-webkit-scrollbar-track:hover, 
            body::-webkit-scrollbar-track:active {
                background: #d4d4d4;
            }




        </style>

        <script>

            $(document).ready(function () {
                //   $("#rechazar_solicitud").css("display", "none");
                $('#rechazar_solicitud').hide(); //Ocultar div.
                $('#aceptar_solicitud').hide(); //Ocultar div.

                $("#siguiente").click(function (e) {

                    //alert($('#respuesta').val());

                    if ($('#respuesta').val() == "rechazar") {

                        $('#aceptar_solicitud').hide(); //Ocultar div.
                        $('#rechazar_solicitud').show(); //Mostrar div.

                        $("#siguiente").attr("href", "#rechazar_solicitud");


                        e.preventDefault();		//evitar el eventos del enlace normal

                        var strAncla = $(this).attr('href'); //id del ancla
                        $('body,html').stop().animate({
                            scrollTop: $(strAncla).offset().top
                        }, 2000);

                        $("#text-box-rechazo").focus();



                    } else if ($('#respuesta').val() == "aceptar") {
                        $('#rechazar_solicitud').hide(); //Ocultar div.
                        $('#aceptar_solicitud').show(); //Mostrar div.

                        $("#siguiente").attr("href", "#aceptar_solicitud");


                        e.preventDefault();		//evitar el eventos del enlace normal

                        var strAncla = $(this).attr('href'); //id del ancla
                        $('body,html').stop().animate({
                            scrollTop: $(strAncla).offset().top
                        }, 2000);

                    }
                    $('#decision').hide(); //Ocultar div.
                    //   $('#siguiente').attr("disabled", true);
                });





                var today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
                $('#datepicker').datepicker({
                    uiLibrary: 'bootstrap4',
                    locale: 'es-es',
                    format: 'yyyy-mm-dd',
                    minDate: today


                });

                $('#datepicker2').datepicker({
                    uiLibrary: 'bootstrap4',
                    locale: 'es-es',
                    format: 'yyyy-mm-dd',
                    minDate: today
                });


            });











        </script>


        <%            //Verificamos que se envíe el parámetro por url.   
            if (request.getParameter("id_solicitud") != null) {

                //Guardamos la consulta en una variable.
                String consulta = "select concat(empleado.nombres,' ',empleado.apellidos) as 'empleado', departamento.descripcion,"
                        + " tipo_caso.descripcion,solicitud_caso.descripcion,solicitud_caso.fecha,solicitud_caso.archivo_info "
                        + " from solicitud_caso inner join empleado on solicitud_caso.id_empleado=empleado.id_empleado "
                        + "inner join departamento on solicitud_caso.id_departamento=departamento.id_departamento "
                        + "inner join tipo_caso on solicitud_caso.id_tipo=tipo_caso.id_tipo "
                        + " where solicitud_caso.id_solicitud=?";

                st = conexion.prepareStatement(consulta); //Preparamos el statement para hacer una consulta.
                st.setString(1, request.getParameter("id_solicitud")); //Asignamos el parámetro
                //del ID de la solicitud.

                //Ejecutamos la sentencia y guardamos los datos que devuelve.
                ResultSet info_solicitud = st.executeQuery();

                //Verificamos si la consulta nos devuelve un registro.
                if (info_solicitud.next()) {%>

        <h2 class="text-center mt-3 mb-3">Información de solicitud</h2>

        <div class="d-flex justify-content-center mt-3 mb-3">

            <form class="w-50">

                <div class="form-group">
                    <label>Empleado que realiza la solicitud</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_solicitud.getString(1)%>">
                </div>

                <div class="form-group">
                    <label>Departamento</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_solicitud.getString(2)%>">
                </div>

                <div class="form-group">
                    <label>Tipo de caso</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_solicitud.getString(3)%>">
                </div>

                <div class="form-group">
                    <div class="form-group">
                        <label for="descripcion">Descripción de la solicitud</label>
                        <textarea class="form-control textarea" readonly="on" rows="3" ><%=info_solicitud.getString(4)%></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label>Fecha en que se hizo la solicitud</label>
                    <input type="text" class="form-control" readonly="on" value="<%=info_solicitud.getString(5)%>">
                </div>    

                <% if (info_solicitud.getString(6) != null) {%>
                <div class="border ml-3 mr-3">    
                    <p class="text-center m-3">Esta solicitud contiene un archivo pdf</p>
                    <div class="d-flex justify-content-center m-3">    

                        <a target="_blank" href="mostrar_pdf_solicitud.jsp?id_solicitud=<%=request.getParameter("id_solicitud")%>" class="btn btn-info">
                            Ver archivo pdf adjunto</a>

                    </div>
                </div>
                <%}%>
            </form>



        </div>

        <div id="decision">           
            <div class="d-flex justify-content-center mb-5">
                <div>
                    <p class="text-center">¿Qué desea hacer con esta solicitud?</p>

                    <div class="form-group">
                        <label for="respuesta">Seleccione una opción</label>
                        <select class="custom-select mr-sm-2" name="respuesta" id="respuesta">
                            <option value="aceptar">Aceptar la solicitud</option>
                            <option value="rechazar">Rechazar la solicitud</option>    
                        </select>
                    </div>
                    <div class="d-flex justify-content-center">
                        <input type="button" class="btn btn-primary" id="siguiente" style="color:white;" value="Continuar" />
                    </div>
                </div>
            </div>        
        </div>                 

        <div id="rechazar_solicitud" name="rechazar_solicitud" class="mt-5">
            <h1 class="text-center">Formulario de rechazo de solicitud</h1>
            <div class="d-flex justify-content-center mt-5 mb-5" >
                <form class="w-50" method="post" action="proceso_responder_solicitud.jsp" style="border:1px solid orange;padding:20px;">

                    <div class="form-group">
                        <p>Ingrese el motivo de rechazo</p>
                        <input type="hidden" value="<%=request.getParameter("id_solicitud")%>" name="id_solicitud">
                        <textarea class="form-control textarea" id="text-box-rechazo" name="motivo_rechazo" rows="3"></textarea>
                    </div>

                    <div class="d-flex justify-content-center">
                        <input type="submit" value="Terminar proceso" name="btn_rechazar" class="btn btn-success">
                    </div>
            </div>   
        </form> 

    </div>


    <div id="aceptar_solicitud" name="aceptar_solicitud" class="mt-5">
        <h1 class="text-center">Formulario de aprobación de solicitud</h1>
        <div class="d-flex justify-content-center mt-5 mb-5" >
            <form class="w-50" method="post" action="proceso_responder_solicitud.jsp" style="border:1px solid orange;padding:20px;">

                <div class="form-group">
                    <label for="programador">Seleccione el programador a quien asignará el caso</label>
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
                        %>

                        <option value="<%=programadores_departamento.getString(1)%>"><%=programadores_departamento.getString(2)%></option>

                        <% }
                            } else {
                                out.println("<option>El departamento no posee programadores.</option>");
                            }
                        %>
                    </select>

                </div>

                <div class="form-group">
                    <label for="empleado">Seleccione el empleado que realizará las pruebas una vez el caso haya terminado</label>
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
                        %>

                        <option value="<%=empleados_departamento.getString(1)%>"><%=empleados_departamento.getString(2)%></option>

                        <% }
                            } else {
                                out.println("<option>El departamento no posee empleados de àrea.</option>");
                            }
                        %>
                    </select>

                </div>    

                <div class="form-group">
                    <label for="fecha_inicio">Seleccione la fecha de inicio (click sobre el siguiente campo)</label>
                    <input id="datepicker" class="form-control hover_date" name="fecha_inicio" autocomplete="off" readonly="on"/>

                </div>    

                <div class="form-group">
                    <label for="fecha_final">Seleccione la fecha de finalización (click sobre el siguiente campo)</label>
                    <input id="datepicker2" class="form-control hover_date" name="fecha_final" autocomplete="off" readonly="on"/>

                </div>   

                <input type="hidden" value="<%=request.getParameter("id_solicitud")%>" name="id_solicitud">
                <div class="d-flex justify-content-center">
                    <input type="submit" value="Terminar proceso" name="btn_aceptar" class="btn btn-success">
                </div>
        </div>   
    </form> 

</div>                           



<%
       } else { %>
<div class="alert alert-warning text-center m-5">
    No se ha encontrador información del id recibido.
</div>

<%    }

} else { %>
<div class="alert alert-danger text-center m-5">
    No se ha recibido los parámetros necesarios para realizar el proceso.
</div>


<%   }

%>


<div class="d-flex justify-content-center mt-3 mb-3">

    <a class="btn btn-secondary" href="solicitudes_en_espera.jsp">Regresar al listado de solicitudes</a>

</div>


</body>
</html>
