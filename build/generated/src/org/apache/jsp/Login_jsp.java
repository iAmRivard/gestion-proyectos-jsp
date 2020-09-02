package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class Login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");


    HttpSession mensaje_login = request.getSession(); //Creamos una sesión.


      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <META HTTP-EQUIV=\"Expires\" CONTENT=\"-1\">\n");
      out.write("        <META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">\n");
      out.write("        <META HTTP-EQUIV=\"Cache-Control\" CONTENT=\"no-cache\">\n");
      out.write("        <title>Iniciar sesión</title>\n");
      out.write("\n");
      out.write("        <script src=\"https://code.jquery.com/jquery-3.3.1.slim.min.js\" integrity=\"sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo\" crossorigin=\"anonymous\"></script>\n");
      out.write("        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js\" integrity=\"sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1\" crossorigin=\"anonymous\"></script>\n");
      out.write("        <script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\" integrity=\"sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM\" crossorigin=\"anonymous\"></script>\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\" integrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\" crossorigin=\"anonymous\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/login.css\" />\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/login2.css\" />\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css\">\n");
      out.write("        <link href=\"https://fonts.googleapis.com/css?family=Montserrat\" rel=\"stylesheet\">        \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            $(document).ready(function () {\n");
      out.write("\n");
      out.write("                $('#mensaje_error').modal({backdrop: 'static', keyboard: false})\n");
      out.write("\n");
      out.write("                $(\"#activar\").click(function () {\n");
      out.write("\n");
      out.write("                    $('#sem-login').modal('show');\n");
      out.write("\n");
      out.write("                });\n");
      out.write("\n");
      out.write("\n");
      out.write("            });\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <div class=\"container\">\n");
      out.write("\n");
      out.write("            <div class=\"abs-center\">\n");
      out.write("                <div class=\"cont\">\n");
      out.write("                    <h2 class=\"w-100 text-center\" style=\"color:black;\">Sistema de control de proyectos</h2>\n");
      out.write("                    <div class=\"d-flex justify-content-center\">\n");
      out.write("                        <button type=\"button\" class=\"btn btn-primary btn_inicio\" data-toggle=\"modal\" data-target=\"#sem-login\">\n");
      out.write("                            Iniciar sesión\n");
      out.write("                        </button>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"d-flex justify-content-center mt-3 mb-3\">\n");
      out.write("                        <a href=\"Acerca_de.jsp\" class=\"btn btn-info btn_inicio\">Acerca de...</a>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("            <!-- Modal del formulario de inicio de sesión. -->\n");
      out.write("            <div class=\"modal fade seminor-login-modal\" data-backdrop=\"static\" id=\"sem-login\">\n");
      out.write("                <div class=\"modal-dialog modal-dialog-centered\">\n");
      out.write("                    <div class=\"modal-content\">\n");
      out.write("\n");
      out.write("                        <!-- Modal body -->\n");
      out.write("                        <div class=\"modal-body seminor-login-modal-body\">\n");
      out.write("                            <h5 class=\"modal-title text-center\">Iniciar sesión en el sistema</h5>\n");
      out.write("                            <button type=\"button\" class=\"close\" data-dismiss=\"modal\">\n");
      out.write("                                <span><i class=\"fa fa-times-circle\" aria-hidden=\"true\"></i></span>\n");
      out.write("                            </button>\n");
      out.write("                            <p class=\"text-center mt-3\">Ingrese su usuario y contraseña para ingresar a su perfil del sistema</p>\n");
      out.write("\n");
      out.write("\n");
      out.write("                            <form class=\"seminor-login-form\" method=\"post\" action=\"iniciar_sesion.jsp\">\n");
      out.write("                                <div class=\"form-group\">\n");
      out.write("                                    <input type=\"text\" class=\"form-control\" required autocomplete=\"off\" name=\"usuario\">\n");
      out.write("                                    <label class=\"form-control-placeholder\" for=\"name\">Usuario</label>\n");
      out.write("                                </div>\n");
      out.write("                                <div class=\"form-group\">\n");
      out.write("                                    <input type=\"password\" class=\"form-control\" required autocomplete=\"off\" name=\"contra\">\n");
      out.write("                                    <label class=\"form-control-placeholder\" for=\"password\">Contraseña</label>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                                <div class=\"btn-check-log\">\n");
      out.write("                                    <button type=\"submit\" class=\"btn-check-login\">Iniciar sesión</button>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("                                <div class=\"forgot-pass-fau text-center pt-3\">\n");
      out.write("                                    <a href=\"#\" class=\"text-secondary\"></a>\n");
      out.write("\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                            </form>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        ");
     if (mensaje_login.getAttribute("mensaje_error_login") != null && !(mensaje_login.getAttribute("mensaje_error_login").equals(""))) {

        
      out.write("       \n");
      out.write("        <!-- Modal que muestra error en el proceso. -->    \n");
      out.write("\n");
      out.write("        <div class=\"modal fade\" id=\"mensaje_error\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalCenterTitle\" aria-hidden=\"true\">\n");
      out.write("            <div class=\"modal-dialog modal-dialog-centered\" role=\"document\">\n");
      out.write("                <div class=\"modal-content\">\n");
      out.write("                    <div class=\"modal-header\">\n");
      out.write("                        <h5 class=\"modal-title w-100 text-center\" style=\"color:lightskyblue;\" id=\"exampleModalCenterTitle\">Error al iniciar sesión</h5>\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"modal-body text-center\" style=\"color:red;\">\n");
      out.write("                        ");
      out.print(mensaje_login.getAttribute("mensaje_error_login"));
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"modal-footer d-flex justify-content-center\">\n");
      out.write("\n");
      out.write("                        <button type=\"button\" class=\"btn btn-success\" data-dismiss=\"modal\" id=\"activar\">Aceptar</button>\n");
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        ");
 }
            mensaje_login.removeAttribute("mensaje_error_login");

        
      out.write("   \n");
      out.write("\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
