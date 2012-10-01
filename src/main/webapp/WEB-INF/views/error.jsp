<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>FriendFilter: Error</title>
  </head>
  <body>

  <h1>Ups... Something went wrong...</h2>
  
  <p>
   <a href="<c:url value="/" />">home</a> | <a href="<c:url value="/signin" />">sign in</a> | <a href="<c:url value="/signout" />">sign out</a> 
  </p>
 
  </body>
</html>
