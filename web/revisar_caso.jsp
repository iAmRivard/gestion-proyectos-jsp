
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Revisar caso seleccionado</title>
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




            });



        </script>

        <%//Incluimos el menú con las opciones para el empleado.%>
        <%@ include file="include/menu_empleado.jsp"%>

        <%
            if (request.getParameter("id_caso") != null) {%>

        <div id="decision">           
            <div class="d-flex justify-content-center mt-5 mb-5">
                <div>
                    <p class="text-center">¿Qué desea hacer con el caso seleccionado?</p>

                    <div class="form-group">
                        <label for="respuesta">Seleccione una opción</label>
                        <select class="custom-select mr-sm-2" name="respuesta" id="respuesta">
                            <option value="aceptar">Aceptar el caso</option>
                            <option value="rechazar">Rechazar el caso</option>    
                        </select>
                    </div>
                    <div class="d-flex justify-content-center">
                        <input type="button" class="btn btn-primary" id="siguiente" style="color:white;" value="Continuar" />
                    </div>
                </div>
            </div>        
        </div>  


        <div id="rechazar_solicitud" name="rechazar_solicitud" class="mt-5">
            <h1 class="text-center">Formulario de rechazo de caso seleccionado</h1>
            <div class="d-flex justify-content-center mt-5 mb-5" >
                <form class="w-50" method="post" action="proceso_responder_caso.jsp" style="border:1px solid orange;padding:20px;">

                    <div class="form-group">
                        <p>Ingrese las observaciones por las que rechaza el caso</p>
                        <input type="hidden" value="<%=request.getParameter("id_caso")%>" name="id_caso">
                        <textarea class="form-control textarea" id="text-box-rechazo" name="motivo_rechazo" rows="3"></textarea>
                    </div>

                    <div class="d-flex justify-content-center">
                        <input type="submit" value="Terminar proceso" name="btn_rechazar" class="btn btn-success">
                    </div>
            </div>   
        </form> 

    </div>    

    <div id="aceptar_solicitud" name="aceptar_solicitud" class="mt-5">

        <p class="text-center">Presione el botón para terminar el proceso</p>
        <div class="d-flex justify-content-center mt-5 mb-5" >
            <form class="w-50" method="post" action="proceso_responder_caso.jsp" style="border:1px solid orange;padding:20px;">      
                <input type="hidden" value="<%=request.getParameter("id_caso")%>" name="id_caso">
                <div class="d-flex justify-content-center">
                    <input type="submit" value="Terminar proceso" name="btn_aceptar" class="btn btn-success">
                </div>   

            </form>        
        </div>        
    </div>           



    <%  }


    %>

    <div class="d-flex justify-content-center mt-3 mb-3">
        <a class="btn btn-info" href="casos_revisar_empleado.jsp">Regresar al listado de casos por revisar</a>
    </div> 

</body>
</html>
