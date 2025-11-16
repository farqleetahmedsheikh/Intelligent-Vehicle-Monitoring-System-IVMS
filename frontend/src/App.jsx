/** @format */
import { BrowserRouter, Routes, Route } from "react-router-dom";
import "./App.css";
import DashboardLayout from "./layouts/MainLayout";
import Signup from "./pages/auth/Signup";
import Login from "./pages/auth/Login";
import SubmitComplaintPage from "./pages/common/SubmitComplain";
import Dashboard from "./pages/user/Dashboard";
import AdminDashboard from "./pages/admin/AdminDashboard";
import ForgotPassword from "./pages/auth/ForgotPassword";
import ResetPassword from "./pages/auth/ResetPassword";
import VerifyOTP from "./pages/auth/VerifyOtp";
import SearchComplaintPage from "./pages/common/SearchComplain";
import ComplaintMainPage from "./pages/common/MainComplaint";
import CameraMainPage from "./pages/common/Camera";
import ConfigureCamera from "./pages/admin/ConfigureCamera";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Authentication */}
        <Route path="/signup" element={<Signup />} />
        <Route path="/login" element={<Login />} />
        <Route path="/forgot-password" element={<ForgotPassword />} />
        <Route path="/verify-otp" element={<VerifyOTP />} />
        <Route path="/reset-password" element={<ResetPassword />} />

        {/* USER Dashboard */}
        <Route path="/user/dashboard" element={<DashboardLayout />}>
          <Route index element={<Dashboard />} /> {/* /user/dashboard */}
          <Route path="home" element={<Dashboard />} />
          <Route path="complain" element={<ComplaintMainPage />} />
          <Route path="complain/search" element={<SearchComplaintPage />} />
          <Route path="complain/submit" element={<SubmitComplaintPage />} />
          <Route path="camera" element={<CameraMainPage />} />
        </Route>

        {/* ADMIN Dashboard */}
        <Route path="/admin/dashboard" element={<DashboardLayout />}>
          <Route index element={<AdminDashboard />} /> {/* /admin/dashboard */}
          <Route path="home" element={<AdminDashboard />} />
          <Route path="complain" element={<ComplaintMainPage />} />
          <Route path="complain/search" element={<SubmitComplaintPage />} />
          <Route path="complain/submit" element={<SubmitComplaintPage />} />
          <Route path="camera" element={<CameraMainPage />} />
          <Route path="camera/configure" element={<ConfigureCamera />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
