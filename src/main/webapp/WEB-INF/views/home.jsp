<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>FriendFilter: Home</title>
  </head>
  <body>

  <h3>You've signed in as <c:out value= "${username}"/> </h3> 
  <h4>Select interest to filter out your friends by it </h4>
  
  <div style="height:25px;width:100%;">
			<select id="interests_dropdown" style="float:left;margin-right:10px;">
		      <option>Please select interest</option>
			    <c:forEach items="${interests}" var="interest">
			        <option value="${interest.name}">${interest.name}</option>
			    </c:forEach>
			</select>
			
			<select id="friends_dropdown" style="float:left;margin-right:15px;">
			    <option>No friends with given interest</option>
			</select>

	    <div id="loading" style="display:none; float:left; margin-top:-12px">
	      <p><img src="resources/ajax-loader.gif" /> Please Wait</p>
	    </div>
		
    <div style="clear:both; font-size:1px;"></div>
  
  </div>
  
  <br>
  
	<form action="<c:url value="/signout" />" method="GET">
	    <button type="submit">Sign out</button>
	</form>
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript">
	</script>	
	
	<script type="text/javascript">
		$(document).ready(function() {
		    $('#interests_dropdown').change(function() {
		        var selectedValue = $(this).val();
		        var servletUrl = 'friends_by_interest?interest=' + selectedValue;
		        if (selectedValue != "Please select interest") {
                $("#loading").show();
                $.getJSON(servletUrl, function(options) {
                    $("#loading").hide();
                    var friends_dropdown = $('#friends_dropdown');
                    $('>option', friends_dropdown).remove(); // Clean old options first.
                    if (options && options.length > 0) {
                        $.each(options, function(key, value) {
                          friends_dropdown.append($('<option/>').val(key).text(value));
                        });
                    } else {
                      friends_dropdown.append($('<option/>').text("No friends with given interest"));
                    }
                });
		        }
		    });
		});
	</script>
	
  </body>
</html>
