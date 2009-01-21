<%
/*
  * CDDL HEADER START
  *
  * The contents of this file are subject to the terms of the
  * Common Development and Distribution License, Version 1.0 only
  * (the "License").  You may not use this file except in compliance
  * with the License.
  *
  * You can obtain a copy of the license at license/ESCIDOC.LICENSE
  * or http://www.escidoc.de/license.
  * See the License for the specific language governing permissions
  * and limitations under the License.
  *
  * When distributing Covered Code, include this CDDL HEADER in each
  * file and include the License file at license/ESCIDOC.LICENSE.
  * If applicable, add the following below this CDDL HEADER, with the
  * fields enclosed by brackets "[]" replaced with your own identifying
  * information: Portions Copyright [yyyy] [name of copyright owner]
  *
  * CDDL HEADER END
  */

/*
  * Copyright 2008 Fachinformationszentrum Karlsruhe Gesellschaft
  * fuer wissenschaftlich-technische Information mbH and Max-Planck-
  * Gesellschaft zur Foerderung der Wissenschaft e.V.
  * All rights reserved.  Use is subject to license terms.
  */
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Admin Tool</title>
  </head>

  <body bgcolor="LightGrey">
    <table>
      <tr>
        <td align="center" colspan="3"><h1>Admin Tool</h1></td>
      </tr>
      <tr>
        <td colspan="3">
          &nbsp;
        </td>
      </tr>
      <tr>
        <form action="result.jsp" name="deleteByItemId" target="result" method="post">
          <td width="55%">
            Delete a specific item:
          </td>
          <td width="35%">
            <input name="subject"   style="width: 100%" type="text"   value="<info:fedora/escidoc:1>"/>
            <input name="predicate"                     type="hidden" value="<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"/>
            <input name="object"                        type="hidden" value="<http://escidoc.de/core/01/resources/Item>"/>
          </td>
          <td width="10%">
            <input type="submit" value="Start"/>
          </td>
        </form>
      </tr>
        <form action="result.jsp" name="deleteByContentModelForm" target="result" method="post">
          <td>
            Delete all items of a specific content model:
          </td>
          <td>
            <input name="subject"                       type="hidden" value="*"/>
            <input name="predicate"                     type="hidden" value="<http://escidoc.de/core/01/structural-relations/content-model>"/>
            <input name="object"    style="width: 100%" type="text"   value="<info:fedora/escidoc:ex4>"/>
          </td>
          <td>
            <input type="submit" value="Start"/>
          </td>
        </form>
      </tr>
      <tr>
        <form action="result.jsp" name="deleteByContextForm" target="result" method="post">
          <td>
            Delete all items of a specific context:
          </td>
          <td>
            <input name="subject"                       type="hidden" value="*"/>
            <input name="predicate"                     type="hidden" value="<http://escidoc.de/core/01/structural-relations/context>"/>
            <input name="object"    style="width: 100%" type="text"   value="<info:fedora/escidoc:ex1>"/>
          </td>
          <td>
            <input type="submit" value="Start"/>
          </td>
      </tr>
    </table>
  </body>
</html>
