
<%@page session="true" language="java" import="java.util.*" %>
<%@ include file="conexion.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar empleado</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>
    <body>


        <script>
            $(document).ready(function () {
                $('#confirmacion_eliminar_departamento').modal({backdrop: 'static', keyboard: false});
            });
        </script>

        <%      HttpSession sesionOk = request.getSession(); //Creamos una sesión.
            Boolean redireccion = false; //Variable para controlar cuando el programa
            //redireccionará a otra página cuando encuentre un error en la validación.

            if (request.getParameter("id_departamento") != null) {  //Validamos que el parámetro del
                //url no sea nulo.

                String ID = request.getParameter("id_departamento");
                redireccion = false;
        %>  
        <!-- Modal -->
        <div class="modal fade" id="confirmacion_eliminar_departamento" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-center w-100" id="exampleModalCenterTitle">Confirmar acción</h5>

                    </div>
                    <div class="modal-body text-center">
                        ¿Está seguro que desea borrar el registro seleccionado?
                        Si acepta, esta acción es irreversible.
                    </div>
                    <div class="modal-footer d-flex justify-content-center">
                        <a class="btn btn-primary" href="departamentos.jsp">Cancelar</a>
                        <a  class="btn btn-danger" href="eliminar_departamentos.jsp?id_eliminar=<%=ID%>">Eliminar departamento</a>
                    </div>
                </div>
            </div>
        </div>


        <% } else if (request.getParameter("id_eliminar") != null) { //Validamos que el id
                //que recibe (luego de confirmar la eliminación) no sea nulo.

                try {
                    redireccion = true;
                    //Preparamos consulta.
                    st = conexion.prepareStatement("delete from departamento where id_departamento=?");
                    st.setString(1, request.getParameter("id_eliminar"));

                    //Ejecutamos consulta.
                    st.executeUpdate();

                } catch (SQLException ex) {

                    out.println("Ha ocurrido un error: " + ex.toString());

                }

            } else { //No se ha enviado parámetros válidos para realizar las acciones.
                redireccion = true;
                sesionOk.setAttribute("mensaje_eliminar_departamento", "No se puede llevar a cabo la eliminación, falta"
                        + " parámetros.");
            }
            conexion.close();

            if (redireccion) {
                response.sendRedirect("departamentos.jsp");
            }

        %> 
    </body>
</html>
