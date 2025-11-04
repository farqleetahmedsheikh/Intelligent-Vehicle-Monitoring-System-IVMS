/** @format */

import { useState } from "react";
import { loginUser } from "../api/authApi";
import InputField from "../components/InputField";
import Button from "../components/Button";

export default function Login() {
  const [formData, setFormData] = useState({ username: "", password: "" });
  const [message, setMessage] = useState("");

  const handleChange = (e) =>
    setFormData({ ...formData, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await loginUser(formData);
      localStorage.setItem("token", res.data.access);
      setMessage("Login successful!");
    } catch (err) {
        console.error(err);
      setMessage("Invalid credentials, please try again.");
    }
  };

  return (
    <div className="max-w-md mx-auto mt-20 p-6 shadow-lg rounded-xl bg-white">
      <h2 className="text-2xl font-bold mb-4 text-center">Login</h2>
      <form onSubmit={handleSubmit}>
        <InputField
          label="Username"
          name="username"
          value={formData.username}
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
      </form>
      {message && <p className="text-center text-sm mt-3">{message}</p>}
    </div>
  );
}
