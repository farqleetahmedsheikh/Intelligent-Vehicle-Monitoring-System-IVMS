/** @format */

import { useNavigate } from "react-router-dom";
import DashboardCard from "../../components/DashboardCard";
import "../../styles/Dashboard.css";
import { FileText, Search, CheckCircle, FileCheck } from "lucide-react";
import { useEffect, useState } from "react";
import { fetchUserComplaints } from "../../../api/complaintApi";
import Loader from "../../components/Loader";
import VehicleTable from "../../components/VehicleTable";
import MapPreview from "../../components/MapPreview";

const Dashboard = () => {
  const navigate = useNavigate();
  const [complaints, setComplaints] = useState([]);
  const [loading, setLoading] = useState(true);

  const user = localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user"))
    : null;
  const accessToken = localStorage.getItem("access") || null;
  console.log("Access Token:", accessToken);

  // Redirects to login if not authenticated
  useEffect(() => {
    const fetchComplaints = async () => {
      console.log("Fetching complaints for user:", user.email);
      try {
        setLoading(true);
        const response = await fetchUserComplaints(user.email);

        if (response.status !== 200) throw new Error("Failed to fetch complaints");

        setComplaints(response.data.complaints);
      } catch (error) {
        console.error("Error Console", error);
      } finally {
        setLoading(false);
      }
    };

    fetchComplaints();

    // Only run when user.email changes (instead of full user object)
  }, [navigate, accessToken, user?.email]);


const detections = [
  {
    plate: "ABC-123",
    model: "Toyota Corolla",
    status: "Investigating",
    lastSeen: "2 min ago",
  },
  {
    plate: "XYZ-456",
    model: "Honda Civic",
    status: "Resolved",
    lastSeen: "10 min ago",
  },
  {
    plate: "DEF-789",
    model: "Suzuki Swift",
    status: "Closed",
    lastSeen: "30 min ago",
  },
  {
    plate: "GHI-012",
    model: "Tesla Model 3",
    status: "Resolved",
    lastSeen: "1 hr ago",
  },
  {
    plate: "JKL-345",
    model: "BMW X5",
    status: "Active",
    lastSeen: "2 hrs ago",
  },
];

  const totalReports = complaints.length;
  const pendingInvestigations = complaints.filter(c => c.status === "investigating").length;
  const resolvedCases = complaints.filter(c => c.status === "resolved").length;
  const closedCases = complaints.filter(c => c.status === "closed").length;

  if (loading) return <Loader />;

  return (
    <>
      <div className="dashboard-content">
        <h2>Dashboard Overview</h2>

        <div className="overview-cards">
          <DashboardCard
            title="Reports Submitted"
            value={totalReports}
            icon={<FileText />}
          />
          <DashboardCard
            title="Pending Investigations"
            value={pendingInvestigations}
            icon={<Search />}
          />
          <DashboardCard
            title="Resolved Cases"
            value={resolvedCases}
            icon={<CheckCircle />}
          />
          <DashboardCard
            title="Closed Cases"
            value={closedCases}
            icon={<FileCheck />}
          />
        </div>
        <div className="vehicle-map-container">
          {/* Latest Detections Table */}
          <div className="vehicle-card">
            <VehicleTable vehicles={detections} title="Latest Detections" />
          </div>

          {/* Map Preview */}
          <div className="map-card">
            <MapPreview height={300} />
          </div>
        </div>
      </div>
    </>
  );
};

export default Dashboard;
