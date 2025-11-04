/** @format */

import { useState } from "react";
import { registerUser } from "../api/authApi";
import InputField from "../components/InputField";
import Button from "../components/Button";

export default function Signup() {
  const [formData, setFormData] = useState({
    fullName: "",
    email: "",
    cnic: "",
    phoneNumber: "",
    password: "",
  });
  const [message, setMessage] = useState("");

  const handleChange = (e) =>
    setFormData({ ...formData, [e.target.name]: e.target.value });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await registerUser(formData);
      setMessage("Account created successfully! Please login.");
    } catch (err) {
      setMessage(
        "Error: " + (err.response?.data?.detail || "Unable to register.")
      );
    }
  };

  return (
    <div className="max-w-md mx-auto mt-20 p-6 shadow-lg rounded-xl bg-white">
      <h2 className="text-2xl font-bold mb-4 text-center">Create Account</h2>
      <form onSubmit={handleSubmit}>
        <InputField
          label="Full Name"
          name="fullName"
          value={formData.fullName}
          onChange={handleChange}
        />
        <InputField
          label="Email"
          name="email"
          type="email"
          value={formData.email}
          onChange={handleChange}
        />
        <InputField
          label="Phone Number"
          name="phoneNumber"
          type="number"
          value={formData.phoneNumber}
          onChange={handleChange}
        />
        <InputField
          label="CNIC"
          name="email"
          type="cnic"
          value={formData.cnic}
          onChange={handleChange}
        />
        <InputField
          label="Password"
          name="password"
          type="password"
          value={formData.password}
          onChange={handleChange}
        />
        <Button type="submit" label="Sign Up" />
      </form>
      {message && <p className="text-center text-sm mt-3">{message}</p>}
    </div>
  );
}
