<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<sql:setDataSource dataSource="jdbc/SampleDB" />

<c:set var="name" value="${param.name}" />
<c:set var="comments" value="${param.comments}" />

<c:if test="${param.action == 'Submit'}">
	<c:choose>
		<c:when test="${not empty comments}">
			<sql:update>
		    INSERT INTO app.posts(postname, comments) VALUES(?, ?)
	            <sql:param value="${name}" />
				<sql:param value="${comments}" />
			</sql:update>
			<c:set var="msg" value="Thank you for your feedback." />
			<c:set var="name" value="" />
			<c:set var="comments" value="" />
		</c:when>
		<c:otherwise>
			<c:set var="msg" value="Please supply some comments." />
		</c:otherwise>
	</c:choose>
</c:if>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Speak To Me, Please</title>
</head>
<body>

<h1>Speak To Me, Please</h1>

Welcome to the Acme Corp. feedback site.

<h2>Here's what your fellow workers have said:</h2>
<table border='1'>
	<tr>
		<th>Worker</th>
		<th>Comment</th>
	</tr>

	<sql:query var="qryPosts">
                  SELECT postname, comments FROM app.posts
          </sql:query>

	<c:forEach var="row" items="${qryPosts.rows}">
		<tr>
			<td><c:out value="${row.postname}" /></td>
			<td><c:out value="${row.comments}" /></td>
		</tr>
	</c:forEach>
</table>

<form method="post">
<table>
	<tr>
		<td>Your name: (optional)</td>
		<td><input type='text' name='name' value="${name}"></td>
	</tr>
	<tr>
		<td>Your comments:</td>
		<td><textarea name='comments' rows="6" cols="40">${comments}</textarea></td>
	</tr>
	<tr>
		<td></td>
		<td><input type='submit' name='action' value='Submit'>
	</tr>
</table>
<h3>${msg}</h3>
</form>

</body>
</html>
