<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    <form action="RegisterServlet" method="post">
        <input type="text" name="name" placeholder="Name" required><br>
        <input type="email" name="email" placeholder="Email" required><br>
        <input type="password" name="password" placeholder="Password" required><br>
        <select name="role">
            <option value="seeker">Job Seeker</option>
            <option value="company">Company</option>
        </select><br>
        <button type="submit">Register</button>
    </form>
</body>
</html>
