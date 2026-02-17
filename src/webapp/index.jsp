<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Java App</title>

    <script>
        function callApi() {
            fetch('api/hello')
                .then(response => response.json())
                .then(data => {
                    document.getElementById("result").innerText = data.message;
                })
                .catch(error => {
                    document.getElementById("result").innerText = "API call failed";
                });
        }
    </script>
</head>
<body>

<h2>Java App with Servlet API</h2>

<button onclick="callApi()">Call API</button>

<p id="result"></p>

</body>
</html>
