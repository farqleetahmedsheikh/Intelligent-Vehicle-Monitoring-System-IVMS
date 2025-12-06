/** @format */

import { useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import AlertsDropdown from "./AlertsDropdown";
import ProfileDropdown from "./ProfileDropdown";
import "./styles/Navbar.css";
import logoImage from "../assets/logo.png";

const Navbar = ({ user }) => {
  const navigate = useNavigate();
  const [alertsOpen, setAlertsOpen] = useState(false);
  const [profileOpen, setProfileOpen] = useState(false);
  const onLogout = () => {
    localStorage.clear();
    navigate("/login");
  };
  console.log("Navbar user:", user);
  // close dropdowns when clicking outside
  const wrapperRef = useRef(null);
  useEffect(() => {
    function handleClickOutside(e) {
      if (wrapperRef.current && !wrapperRef.current.contains(e.target)) {
        setAlertsOpen(false);
        setProfileOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  return (
    <>
      <header className="ivms-navbar" ref={wrapperRef}>
        <div className="nav-left">
          <img src={logoImage} alt="Logo Image" className="nav-logo" />
          <div className="nav-appname">
            <span className="app-name">Track Vision</span>
            <small className="app-sub">Intelligent Vehicle Monitoring</small>
          </div>
        </div>

        <div className="nav-center">{/* optional: search / breadcrumbs */}</div>

        <div className="nav-right">
          <div className="nav-item">
            <button
              className="icon-btn"
              aria-label="Alerts"
              onClick={() => {
                setAlertsOpen((v) => !v);
                setProfileOpen(false);
              }}
            >
              <span className="bell-dot" aria-hidden />
              {/* simple inline bell SVG or use lucide-react */}
              <svg
                width="20"
                height="20"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
              >
                <path
                  d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5"
                  strokeWidth="1.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M13.73 21a2 2 0 01-3.46 0"
                  strokeWidth="1.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
            </button>

            {alertsOpen && (
              <AlertsDropdown onClose={() => setAlertsOpen(false)} />
            )}
          </div>

          <div className="nav-item profile-area">
            <button
              className="profile-btn"
              onClick={() => {
                setProfileOpen((v) => !v);
                setAlertsOpen(false);
              }}
              aria-haspopup="true"
              aria-expanded={profileOpen}
            >
              <div className="avatar-placeholder">
                {(user?.fullName || "U").charAt(0)}
              </div>
              <div className="profile-name">
                <span className="small">Hi,</span>
                <strong>{user?.fullName?.split(" ")[0] || "User"}</strong>
              </div>
              <svg
                className="chev"
                width="14"
                height="14"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
              >
                <path
                  d="M6 9l6 6 6-6"
                  strokeWidth="1.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
            </button>

            {profileOpen && (
              <ProfileDropdown
                user={user}
                onEdit={() => {
                  navigate(`edit-profile`); 
                  setProfileOpen(false);
                }}
                onLogout={onLogout}
                onClose={() => setProfileOpen(false)}
              />
            )}
          </div>
        </div>
      </header>
    </>
  );
};

export default Navbar;
