/** @format */

import { useEffect, useState } from "react";
import axios from "axios";
import "../../styles/AdminReview.css";
import Loader from "../../components/Loader";

const API_BASE = import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/";

export default function AdminComplaintReview() {
  const [complaintId, setComplaintId] = useState("");
  const [complaint, setComplaint] = useState(null);
  const [exciseData, setExciseData] = useState(null);
  const [loading, setLoading] = useState(false);

  // =========================
  // FETCH SINGLE COMPLAINT
  // =========================
  const fetchComplaint = async () => {
    if (!complaintId) return;

    setLoading(true);
    try {
      const res = await axios.get(`${API_BASE}complaints/${complaintId}/`);
      setComplaint(res.data);
      setExciseData(null);
    } catch (err) {
      console.error("Complaint not found", err);
      setComplaint(null);
    }
    setLoading(false);
  };

  // =========================
  // VERIFY WITH EXCISE API
  // =========================
  const verifyVehicle = async () => {
    if (!complaint) return;

    setLoading(true);
    try {
      const res = await axios.get(`${API_BASE}complaints/admin-verify/`, {
        params: {
          plate: complaint.plateNumber,
          chassis: complaint.chassisNumber,
          role: "admin",
        },
      });

      setExciseData(res.data.excise_data);
    } catch (err) {
      console.error("Verification failed", err);
    }
    setLoading(false);
  };

  // =========================
  // UPDATE STATUS
  // =========================
  const updateStatus = async (status) => {
    if (!complaint) return;

    setLoading(true);
    try {
      await axios.patch(
        `${API_BASE}complaints/update-status/${complaint.id}/`,
        {
          status,
          role: "admin",
          email: "admin@system.com",
        },
      );

      fetchComplaint();
    } catch (err) {
      console.error("Status update failed", err);
    }
    setLoading(false);
  };

  useEffect(() => {
    if (complaintId) fetchComplaint();
  }, []);

  if (loading) return <Loader />;

  return (
    <div className="admin-review-page">
      <h2>Complaint Review Panel</h2>

      {/* SEARCH BAR */}
      <div className="search-box">
        <input
          type="number"
          placeholder="Enter Complaint ID..."
          value={complaintId}
          onChange={(e) => setComplaintId(e.target.value)}
        />
        <button onClick={fetchComplaint}>Search</button>
      </div>

      {/* NO DATA */}
      {!complaint && complaintId && (
        <p className="no-data">No complaint found</p>
      )}

      {/* COMPLAINT DETAILS */}
      {complaint && (
        <div className="review-card">
          <h3>Complaint #{complaint.id}</h3>

          <div className="info-grid">
            <div>
              <p>
                <strong>Owner:</strong> {complaint.ownerName}
              </p>
              <p>
                <strong>Email:</strong> {complaint.ownerEmail}
              </p>
              <p>
                <strong>Phone:</strong> {complaint.ownerPhone}
              </p>
            </div>

            <div>
              <p>
                <strong>Vehicle:</strong> {complaint.vehicleModel}
              </p>
              <p>
                <strong>Plate:</strong> {complaint.plateNumber?.toUpperCase()}
              </p>
              <p>
                <strong>Chassis:</strong> {complaint.chassisNumber}
              </p>
            </div>
          </div>

          <div className="status-box">
            <p>
              <strong>Status:</strong> <span>{complaint.status}</span>
            </p>
          </div>

          {/* ACTIONS */}
          <div className="actions">
            <button onClick={verifyVehicle}>Verify with Excise</button>

            <button onClick={() => updateStatus("investigating")}>
              Investigate
            </button>

            <button
              className="approve"
              onClick={() => updateStatus("approved")}
            >
              Approve
            </button>

            <button className="reject" onClick={() => updateStatus("rejected")}>
              Reject
            </button>
          </div>

          {/* EXCISE DATA */}
          {exciseData && (
            <div className="excise-box">
              <h4>Excise Verification</h4>
              <pre>{JSON.stringify(exciseData, null, 2)}</pre>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
