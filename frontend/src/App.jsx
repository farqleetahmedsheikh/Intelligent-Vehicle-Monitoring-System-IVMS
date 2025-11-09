/** @format */
import { BrowserRouter, Routes, Route } from "react-router-dom";
import "./App.css";
import Signup from "./pages/Signup";
import AdminSignup from "./pages/AdminSignup";
import Login from "./pages/Login";
import Dashboard from "./pages/Dashboard";
import AdminDashboard from "./pages/AdminDashboard";
import ForgotPassword from "./pages/ForgotPassword";
import ResetPassword from "./pages/ResetPassword";
import VerifyOTP from "./pages/VerifyOtp";

function App() {
  return (
    <>
      <BrowserRouter>
        <Routes>
          {/* Authentication Routes */}
          <Route path="/signup">
            <Route path="user" element={<Signup />} />
            <Route path="admin" element={<AdminSignup />} />
          </Route>
          <Route path="/login" element={<Login />} />
          <Route path="/forgot-password" element={<ForgotPassword />} />
          <Route path="/verify-otp" element={<VerifyOTP />} />
          <Route path="/reset-password" element={<ResetPassword />} />

          {/* Nested Dashboards */}
          <Route path="/user/dashboard">
            <Route path="home" element={<Dashboard />} />
          </Route>

          <Route path="/admin/dashboard">
            <Route path="home" element={<AdminDashboard />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;
