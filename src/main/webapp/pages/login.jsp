<%@ page language="java" contentType="text/html; charset=utf8"
		 pageEncoding="utf8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>

	<head>
	    <title>Авторизация</title>
	    <link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/semantic.min.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/container.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/grid.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/header.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/image.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/menu.css">

		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/divider.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/segment.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/form.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/input.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/button.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/list.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/message.css">
		<link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/icon.css">
	    <script src="https://code.jquery.com/jquery-3.1.1.min.js"
	  			integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	  			crossorigin="anonymous"></script>
	<script src="/resources/Semantic-UI/semantic.min.js"></script>
		<style>
			body{
				background-color: #f4e7d7;
			}
		</style>

	</head>

	<body>
		<div class="ui three column middle aligned grid">
			<div class="column"></div>
			<div class="column" style="margin-top: 15rem;">
				<form class="ui form" action="/login" method="post" name="userDto">
					<div class="ui teal segment" style="border-top: 2px solid #C63D0F !important;">
						<h2 class="ui center aligned header">Авторизация</h2>
						<div class="field">
							<div class="ui left icon input">
								<i class="Database icon"></i>
								<input name="DBLink" placeholder="Путь к БД (Например: jdbc:oracle:thin:@localhost:1521:XE)" type="text" value="jdbc:oracle:thin:@localhost:1521:XE">
							</div>
						</div>
						<div class="field">
							<div class="ui left icon input">
								<i class="user icon"></i>
								<input name="username" placeholder="Имя пользователя" type="text" value="kiselev">
							</div>
						</div>
						<div class="field">
							<div class="ui left icon input">
								<i class="lock icon"></i>
								<input name="password" placeholder="Пароль" type="password" value="kiselev">
							</div>
						</div>
						<button class="ui fluid large teal submit button" type="submit" style="background-color: #C63D0F;">Вход</button>
					</div>
				</form>
			</div>
			<div class="column"></div>
		</div>
	</body>
</html>
