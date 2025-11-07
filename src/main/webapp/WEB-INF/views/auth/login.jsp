<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - LibMan Library Management System</title>
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.0/dist/tailwind.min.css"
      rel="stylesheet"
    />
    <script
      src="https://kit.fontawesome.com/a2e0f1f5c1.js"
      crossorigin="anonymous"
    ></script>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .login-container {
        background: white;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        overflow: hidden;
        max-width: 450px;
        width: 100%;
        margin: 20px;
      }

      .login-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 50px 30px;
        text-align: center;
        color: white;
      }

      .logo-icon {
        font-size: 80px;
        margin-bottom: 20px;
        display: inline-block;
        animation: float 3s ease-in-out infinite;
      }

      @keyframes float {
        0%, 100% {
          transform: translateY(0px);
        }
        50% {
          transform: translateY(-10px);
        }
      }

      .login-header h1 {
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 8px;
        letter-spacing: -0.5px;
      }

      .login-header p {
        font-size: 14px;
        opacity: 0.95;
        font-weight: 500;
      }

      .login-form {
        padding: 40px 30px;
      }

      .form-group {
        margin-bottom: 24px;
      }

      .form-group label {
        display: block;
        font-size: 14px;
        font-weight: 600;
        color: #333;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .form-group label i {
        color: #667eea;
        font-size: 16px;
      }

      .form-group input {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #e0e0e0;
        border-radius: 10px;
        font-size: 15px;
        transition: all 0.3s ease;
        background: #f9f9f9;
      }

      .form-group input:focus {
        outline: none;
        border-color: #667eea;
        background: white;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      }

      .form-group input::placeholder {
        color: #999;
      }

      .password-wrapper {
        position: relative;
      }

      .toggle-password {
        position: absolute;
        right: 16px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        color: #999;
        font-size: 18px;
        transition: color 0.3s ease;
      }

      .toggle-password:hover {
        color: #667eea;
      }

      .error-message {
        background: #fee;
        border: 2px solid #fcc;
        color: #c33;
        padding: 12px 16px;
        border-radius: 10px;
        margin-bottom: 24px;
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 14px;
        font-weight: 500;
      }

      .error-message i {
        font-size: 18px;
      }

      .login-btn {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
      }

      .login-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
      }

      .login-btn:active {
        transform: translateY(0);
      }

      .login-btn i {
        font-size: 18px;
      }

      .login-footer {
        padding: 20px 30px;
        text-align: center;
        border-top: 1px solid #f0f0f0;
        color: #666;
        font-size: 13px;
      }

      .login-footer i {
        color: #667eea;
        margin-right: 6px;
      }

      @media (max-width: 480px) {
        .login-header {
          padding: 40px 20px;
        }

        .logo-icon {
          font-size: 60px;
        }

        .login-header h1 {
          font-size: 26px;
        }

        .login-form {
          padding: 30px 20px;
        }
      }
    </style>
  </head>
  <body>
    <div class="login-container">
      <!-- Header with Logo -->
      <div class="login-header">
        <div class="logo-icon">
          <i class="fas fa-book-open"></i>
        </div>
        <h1>LibMan</h1>
        <p>Library Management System</p>
      </div>

      <!-- Login Form -->
      <div class="login-form">
        <% String error = (String) request.getAttribute("error"); %> <% if
        (error != null && !error.isEmpty()) { %>
        <div class="error-message">
          <i class="fas fa-exclamation-circle"></i>
          <span><%= error %></span>
        </div>
        <% } %>

        <form method="POST">
          <!-- Username Field -->
          <div class="form-group">
            <label for="username">
              <i class="fas fa-user-circle"></i>
              Username
            </label>
            <input
              id="username"
              name="username"
              type="text"
              required
              value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
              placeholder="Enter your username..."
            />
          </div>

          <!-- Password Field -->
          <div class="form-group">
            <label for="password">
              <i class="fas fa-lock"></i>
              Password
            </label>
            <div class="password-wrapper">
              <input
                id="password"
                name="password"
                type="password"
                required
                placeholder="Enter your password..."
              />
              <i
                class="fas fa-eye toggle-password"
                id="togglePassword"
              ></i>
            </div>
          </div>

          <!-- Login Button -->
          <button type="submit" class="login-btn">
            <i class="fas fa-sign-in-alt"></i>
            <span>Sign In</span>
          </button>
        </form>
      </div>

      <!-- Footer -->
      <div class="login-footer">
        <i class="fas fa-book"></i>
        <span>Smart Library Management — Organized Knowledge</span>
      </div>
    </div>

    <script>
      const togglePassword = document.getElementById("togglePassword");
      const passwordInput = document.getElementById("password");

      togglePassword.addEventListener("click", () => {
        const type =
          passwordInput.getAttribute("type") === "password"
            ? "text"
            : "password";
        passwordInput.setAttribute("type", type);
        togglePassword.classList.toggle("fa-eye");
        togglePassword.classList.toggle("fa-eye-slash");
      });
    </script>
  </body>
</html>
