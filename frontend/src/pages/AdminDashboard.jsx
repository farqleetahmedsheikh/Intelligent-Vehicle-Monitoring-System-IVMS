/** @format */

import Navbar from "../components/Navbar";
import { useNavigate } from "react-router-dom";
import Sidebar from "../components/Sidebar";
import DashboardCard from "../components/DashboardCard";
import "../styles/Dashboard.css";
import { Car, FileText, Search, CheckCircle, User } from "lucide-react";
import { useEffect } from "react";

const AdminDashboard = () => {
  const navigate = useNavigate();
  const user = localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user"))
    : null;
  const accessToken = localStorage.getItem("access") || null;
  useEffect(() => {
    if (!accessToken || !user || user.role !== "admin") {
      navigate("/login");
    }
  }, [navigate, accessToken, user]);

  const detections = [
    {
      id: 1,
      plate: "ABC-123",
      time: "2 min ago",
      image: "",
    },
    {
      id: 2,
      plate: "XYZ-456",
      time: "10 min ago",
      image: "",
    },
  ];

  return (
    <div className="dashboard-container">
      <Navbar user={user} />
      <div className="dashboard-body">
        <Sidebar />
        <div className="dashboard-content">
          <h2>Dashboard Overview</h2>

          <div className="overview-cards">
            <DashboardCard
              title="My Registered Vehicles"
              value="3"
              icon={<Car />}
            />
            <DashboardCard
              title="Reports Submitted"
              value="5"
              icon={<FileText />}
            />
            <DashboardCard
              title="Pending Investigations"
              value="2"
              icon={<Search />}
            />
            <DashboardCard
              title="Resolved Cases"
              value="1"
              icon={<CheckCircle />}
            />
          </div>

          <div className="feed-map">
            <div className="detection-feed">
              <h3>Latest Detections</h3>
              {detections.map((item) => (
                <div className="feed-item" key={item.id}>
                  <img src={item.image} alt="Vehicle" />
                  <div>
                    <p>
                      <strong>Plate:</strong> {item.plate}
                    </p>
                    <p>
                      <small>{item.time}</small>
                    </p>
                  </div>
                </div>
              ))}
            </div>

            <div className="map-preview">
              <h3>Map Preview</h3>
              <iframe
                title="Map"
                src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d14713.637467728397!2d90.38426155!3d23.81033145!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sbd!4v1663339558619!5m2!1sen!2sbd"
                width="100%"
                height="250"
                style={{ border: 0, borderRadius: "10px" }}
                allowFullScreen
                loading="lazy"
              ></iframe>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AdminDashboard;
