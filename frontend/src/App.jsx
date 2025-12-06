/** @format */
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
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
import VehicleDetailsPage from "./pages/common/VehicleDetails";
import AlertDetailsPage from "./pages/common/AlertDetailsPage";
import EditProfile from "./pages/common/EditPage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Redirect / to /login */}
        <Route path="/" element={<Navigate to="/login" replace />} />
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
          <Route path="vehicle-details/:id" element={<VehicleDetailsPage />} />
          <Route path="alert-details" element={<AlertDetailsPage />} />
          <Route path="edit-profile" element={<EditProfile />} />
        </Route>

        {/* ADMIN Dashboard */}
        <Route path="/admin/dashboard" element={<DashboardLayout />}>
          <Route index element={<AdminDashboard />} /> {/* /admin/dashboard */}
          <Route path="home" element={<AdminDashboard />} />
          <Route path="complain" element={<ComplaintMainPage />} />
          <Route path="complain/search" element={<SearchComplaintPage />} />
          <Route path="complain/submit" element={<SubmitComplaintPage />} />
          <Route path="camera" element={<CameraMainPage />} />
          <Route path="camera/configure" element={<ConfigureCamera />} />
          <Route path="vehicle-details/:id" element={<VehicleDetailsPage />} />
          <Route path="alert-details" element={<AlertDetailsPage />} />
          <Route path="edit-profile" element={<EditProfile />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
