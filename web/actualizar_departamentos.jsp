
<%@page session="true" language="java" import="java.util.*" %>
<%@ include file="conexion.jsp"%>
<jsp:useBean id="departamento" class="Mantenimiento.Departamento"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<% // ==============Asignando las propiedades al Bean===========%>
<jsp:setProperty name="departamento" property="ID" param="id"/>
<jsp:setProperty name="departamento" property="descripcion" param="descripcion"/>

<%

HttpSession sesionOk = request.getSession(); //Creamos una sesión.
sesionOk.setAttribute("mensaje_actualizar_departamento", ""); //Inicializamos un atributo de la sesión.

Boolean peticion = false;

//Realizamos una consulta para saber si hay algún departamento existente con
//la misma descripción del nuevo departamento.
st=conexion.prepareStatement("select count(descripcion),id_departamento from departamento "
        + " where descripcion=? GROUP by id_departamento");
st.setString(1, departamento.getDescripcion());
ResultSet descripcion_existente = st.executeQuery();

int cantidad_descripcion; //Esta variable recibirá la cantidad de registros que 
//tienen una descripción igual a la nueva descripción que es recibida del formulario.

if(descripcion_existente.next()){
    cantidad_descripcion=descripcion_existente.getInt(1);
}else{
    cantidad_descripcion =0;
}

//Validaciones para los campos
// ID y descripción de departamento.
if(request.getParameter("id").trim().isEmpty()){ //===== Validaciones para el ID.
    
sesionOk.setAttribute("mensaje_actualizar_departamento", "No se ha enviado el ID del nuevo departamento."); 

}else if (request.getParameter("id").trim().length()>11){
 
sesionOk.setAttribute("mensaje_actualizar_departamento", "El ID del departamento es muy extenso. Debe ser más corto");     
    
}else if(request.getParameter("descripcion").trim().isEmpty()){ //===== Validaciones para la descripción.

sesionOk.setAttribute("mensaje_actualizar_departamento", "No ha ingresado la descripción del departamento.");  

}else if (request.getParameter("descripcion").trim().length()>100){
    
sesionOk.setAttribute("mensaje_actualizar_departamento", "La descripción del departamento es muy extensa. Debe ser más corta.");      
    
}else if (cantidad_descripcion>=1 && !descripcion_existente.getString(2).equals(departamento.getID()) ){
    
sesionOk.setAttribute("mensaje_actualizar_departamento", "Ya hay un departamento que tiene una descripción igual a la que quiere ingresar.");      
    
}

if(!sesionOk.getAttribute("mensaje_actualizar_departamento").equals("")){ //Se verifica si no hay algún error en los campos (verificar si los datos están validados).
   response.sendRedirect("formulario_actualizar_departamentos.jsp?id_departamento="+departamento.getID()); //Los datos no están validados y redirecciona al formulario.
}

if (sesionOk.getAttribute("mensaje_actualizar_departamento").equals("")){ //Validar que no se ejecute la consulta cuando hay algún error.
    try{
        //Preparamos la consulta.
        st=conexion.prepareStatement("update departamento set descripcion=? where id_departamento=?");
        st.setString(1, departamento.getDescripcion());
        st.setString(2, departamento.getID());
        st.executeUpdate();//Ejecutamos consulta.
        peticion = true;

    }catch(SQLException ex){
        out.println("Se ha encontrado un error al realizar la consulta: " + ex.toString());
    }
}

%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar departamento</title>
        <link rel="stylesheet" href="./css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </head>
    <body>
        <%       
        if(peticion){ //Este condicional nos indica que el proceso de ingreso
            //se llevó a cabo con éxito.
            //Mostrará un mensaje al usuario.

       %> 
        
        <script>
        $( document ).ready(function() {
      $('#mensaje_actualizar_departamento').modal({backdrop: 'static', keyboard: false});
});
 
 
    </script>
       
        <!-- Modal -->
<div class="modal fade" id="mensaje_actualizar_departamento" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-center w-100" id="exampleModalCenterTitle">Mensaje</h5>
      
      </div>
      <div class="modal-body text-center">
        La información del departamento, se ha actualizado.
      </div>
      <div class="modal-footer d-flex justify-content-center">
        <a  class="btn btn-success" href="departamentos.jsp">Ver todos los departamentos</a>
      </div>
    </div>
  </div>
</div>
        
           <% } %>
    </body>
</html>
