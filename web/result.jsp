<%@ page import="de.escidoc.core.admin.business.PurgeTool" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Admin Tool web frontend</title>
  </head>

  <body>
    <%
      try {
          PurgeTool tool = new PurgeTool ("fedoraAdmin", "fedoraAdmin", "http://localhost:8082/fedora");

          tool.purgeItemsBySubject (request.getParameter ("subject"),
                                    request.getParameter("predicate"),
                                    request.getParameter("object"),
                                    out);
          out.println ("done.");
          out.flush ();
      }
      catch (Exception e) {
          out.println (e.getMessage ());
      }
    %>
  </body>
</html>
