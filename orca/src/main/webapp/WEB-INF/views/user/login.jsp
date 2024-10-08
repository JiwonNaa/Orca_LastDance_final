<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>ORCA</title>
            <link rel="stylesheet" href="/css/user/login.css">
            <script defer src="/js/user/login.js"></script>
            <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        // 서버에서 전달된 메시지를 가져오기
                        var message = '<c:out value="${message}"/>';

                        // 메시지가 존재하면 알림 표시
                        if (message) {
                            alert(message);
                        }
                    });
                </script>
        </head>

        <body>
            <header>
                <div class="header-left" onclick="loadPage('home.jsp')">
                    <a href=""><img src="/img/header/logo.png" alt="Logo" class="logo"></a>
                    <h2>ORCA</h2>
                </div>
                <div class="header-right">
                    <div>로그인</div>
                </div>
            </header>
            <div class="login-body">
                <div class="login-text">
                    <div class="login-text-grid">
                        <div id="text1"></div>
                        <div id="text2"></div>
                        <div id="text3"></div>
                    </div>
                </div>
                <div class="login-sell">
                    <div class="login-container">
                        <h2>로그인</h2>
                        <form action="login" method="post">
                            <div class="form-group">
                                <input type="text" id="id" name="empNo" placeholder="아이디">
                            </div>
                            <div class="form-group">
                                <input type="password" id="password" name="password" placeholder="비밀번호">
                            </div>
                            <div class="form-check">
                                <a href="" class="form-link">비밀번호 찾기</a>
                            </div>
                            <button type="submit" class="login-btn">로그인</button>
                        </form>
                    </div>
                </div>
            </div>

        </body>

        </html>