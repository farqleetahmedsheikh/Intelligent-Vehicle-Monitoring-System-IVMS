/** @format */

import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { loginUser } from "../../api/authApi";
import InputField from "../components/InputField";
import Button from "../components/Button";
import "../styles/Auth.css";
import AuthLinks from "../components/AuthLinks";

export default function Login() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({ email: "", password: "" });
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const handleChange = (e) =>
    setFormData({ ...formData, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage("");
    setError("");
    try {
      const res = await loginUser(formData);
      console.log("Login response:", res);
      localStorage.setItem("user", JSON.stringify(res.data.user));
      localStorage.setItem("access", res.data.access);
      localStorage.setItem("refresh", res.data.refresh);

      setMessage("Login successful!");
      if (res.data.user.role === "admin") {
        setTimeout(() => navigate("/admin/dashboard/home"), 1500);
        return;
      }
      setTimeout(() => navigate("/user/dashboard/home"), 1500);
    } catch (err) {
      console.error(err);
      setError("Invalid credentials, please try again.");
    }
  };

  return (
    <div className="auth-container">
      <form className="auth-form" onSubmit={handleSubmit}>
        <h2>Login</h2>
        {error && <p className="error">{error}</p>}
        {message && <p className="success">{message}</p>}
        <InputField
          label="Email"
          name="email"
          value={formData.email}
          onChange={handleChange}
        />
        <InputField
          label="Password"
          name="password"
          type="password"
          value={formData.password}
          onChange={handleChange}
        />
        <Button type="submit" label="Login" />
        <AuthLinks
          leftText="Forgot password?"
          leftTo="/forgot-password"
          rightText="Create an account"
          rightTo="/signup/user"
        />
      </form>
    </div>
  );
}
