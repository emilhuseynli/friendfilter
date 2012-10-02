<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<title>FriendFilter: Sign In</title>
	</head>
	<body>
	  
	  <h3>Welcome to FriendFilter App</h3>
	  <h4>Please, sign in with your Facebook account to continue</h4>
	  
		<form action="<c:url value="/signin/facebook" />" method="POST">
		    <button type="submit">Sign in with Facebook</button>
		    <input type="hidden" name="scope" value="user_interests,friends_interests,email,publish_stream,offline_access" />		    
		</form>
	</body>
</html>
