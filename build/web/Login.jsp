
<%@page session="true" language="java" import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    HttpSession mensaje_login = request.getSession(); //Creamos una sesión.

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <title>Iniciar sesión</title>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/login.css" />
        <link rel="stylesheet" href="css/login2.css" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">        



    </head>
    <body>

        <script>



            $(document).ready(function () {

                $('#mensaje_error').modal({backdrop: 'static', keyboard: false})

                $("#activar").click(function () {

                    $('#sem-login').modal('show');

                });


            });





        </script>


        <div class="container">

            <div class="abs-center">
                <div class="cont">
                    <h2 class="w-100 text-center" style="color:black;">Sistema de control de proyectos</h2>
                    <div class="d-flex justify-content-center">
                        <button type="button" class="btn btn-primary btn_inicio" data-toggle="modal" data-target="#sem-login">
                            Iniciar sesión
                        </button>
                    </div>
                    <div class="d-flex justify-content-center mt-3 mb-3">
                        <a href="Acerca_de.jsp" class="btn btn-info btn_inicio">Acerca de...</a>
                    </div>


                </div>
            </div>


            <!-- Modal del formulario de inicio de sesión. -->
            <div class="modal fade seminor-login-modal" data-backdrop="static" id="sem-login">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">

                        <!-- Modal body -->
                        <div class="modal-body seminor-login-modal-body">
                            <h5 class="modal-title text-center">Iniciar sesión en el sistema</h5>
                            <button type="button" class="close" data-dismiss="modal">
                                <span><i class="fa fa-times-circle" aria-hidden="true"></i></span>
                            </button>
                            <p class="text-center mt-3">Ingrese su usuario y contraseña para ingresar a su perfil del sistema</p>


                            <form class="seminor-login-form" method="post" action="iniciar_sesion.jsp">
                                <div class="form-group">
                                    <input type="text" class="form-control" required autocomplete="off" name="usuario">
                                    <label class="form-control-placeholder" for="name">Usuario</label>
                                </div>
                                <div class="form-group">
                                    <input type="password" class="form-control" required autocomplete="off" name="contra">
                                    <label class="form-control-placeholder" for="password">Contraseña</label>
                                </div>

                                <div class="btn-check-log">
                                    <button type="submit" class="btn-check-login">Iniciar sesión</button>
                                </div>


                                <div class="forgot-pass-fau text-center pt-3">
                                    <a href="#" class="text-secondary"></a>

                                </div>

                            </form>

                        </div>
                    </div>
                </div>
            </div>

        </div>

        <%     if (mensaje_login.getAttribute("mensaje_error_login") != null && !(mensaje_login.getAttribute("mensaje_error_login").equals(""))) {

        %>       
        <!-- Modal que muestra error en el proceso. -->    

        <div class="modal fade" id="mensaje_error" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title w-100 text-center" style="color:lightskyblue;" id="exampleModalCenterTitle">Error al iniciar sesión</h5>

                    </div>
                    <div class="modal-body text-center" style="color:red;">
                        <%=mensaje_login.getAttribute("mensaje_error_login")%>
                    </div>
                    <div class="modal-footer d-flex justify-content-center">

                        <button type="button" class="btn btn-success" data-dismiss="modal" id="activar">Aceptar</button>

                    </div>
                </div>
            </div>
        </div>



        <% }
            mensaje_login.removeAttribute("mensaje_error_login");

        %>   


    </body>
</html>
