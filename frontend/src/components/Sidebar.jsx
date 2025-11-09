/** @format */

import "./styles/Sidebar.css";
import { Home, Car, Bell, MessageSquareWarning } from "lucide-react";

const Sidebar = ({ onSelect }) => {
  return (
    <aside className="sidebar">
      <ul>
        <li onClick={() => onSelect("home")}>
          <Home size={18} /> Home
        </li>
        <li onClick={() => onSelect("home")}>
          <MessageSquareWarning size={18} /> Complaints
        </li>
        <li onClick={() => onSelect("vehicles")}>
          <Car size={18} /> Vehicles
        </li>
        <li onClick={() => onSelect("alerts")}>
          <Bell size={18} /> Alerts
        </li>
      </ul>
    </aside>
  );
};

export default Sidebar;
