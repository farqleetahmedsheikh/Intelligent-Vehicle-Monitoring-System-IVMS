/** @format */
import "./styles/Sidebar.css";
import { NavLink } from "react-router-dom";
import { Home, Car, Camera, MessageSquareWarning } from "lucide-react";

const Sidebar = () => {
  const role = localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user"))?.role
    : null;
  console.log("User role from Sidebar :", role);
  let baseUrl = "/user/dashboard";
  if (role === "admin") {
    baseUrl = "/admin/dashboard";
  }
  return (
    <aside className="sidebar">
      <ul>
        <li>
          <NavLink
            to={`${baseUrl}/home`}
            className={({ isActive }) =>
              isActive ? "sidebar-link active" : "sidebar-link"
            }
          >
            <Home size={18} /> Home
          </NavLink>
        </li>

        <li>
          <NavLink
            to={`${baseUrl}/complain`}
            className={({ isActive }) =>
              isActive ? "sidebar-link active" : "sidebar-link"
            }
          >
            <MessageSquareWarning size={18} /> Complaints
          </NavLink>
        </li>

        {/* <li>
          <NavLink
            to={`${baseUrl}/vehicles`}
            className={({ isActive }) =>
              isActive ? "sidebar-link active" : "sidebar-link"
            }
          >
            <Car size={18} /> Vehicles
          </NavLink>
        </li> */}

        <li>
          <NavLink
            to={`${baseUrl}/camera`}
            className={({ isActive }) =>
              isActive ? "sidebar-link active" : "sidebar-link"
            }
          >
            <Camera size={18} /> Camera
          </NavLink>
        </li>
      </ul>
    </aside>
  );
};

export default Sidebar;
