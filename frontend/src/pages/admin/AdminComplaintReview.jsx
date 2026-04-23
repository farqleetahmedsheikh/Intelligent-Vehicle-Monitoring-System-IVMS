/** @format */

import { useEffect, useState } from "react";
import axios from "axios";
import "../../styles/AdminReview.css";
import Loader from "../../components/Loader";

const API_BASE =
  import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/";

export default function AdminComplaintReview() {
  const [complaints, setComplaints] = useState([]);
  const [loading, setLoading] = useState(false);

  const [statusFilter, setStatusFilter] = useState("pending");
  const [search, setSearch] = useState("");

  // =========================
  // FETCH ALL COMPLAINTS + EXCISE
  // =========================
  const fetchComplaints = async () => {
    setLoading(true);

    try {
      const res = await axios.get(
        `${API_BASE}complaints/?include_excise=true`
      );

      const list = res.data.complaints || [];
      setComplaints(list);

    } catch (err) {
      console.error("Failed to fetch complaints", err);
      setComplaints([]);
    }

    setLoading(false);
  };

  useEffect(() => {
    fetchComplaints();
  }, []);

  // =========================
  // UPDATE STATUS
  // =========================
  const updateStatus = async (id, status) => {
    try {
      await axios.patch(
        `${API_BASE}complaints/update-status/${id}/`,
        {
          status,
          role: "admin",
          email: "admin@system.com",
        }
      );

      fetchComplaints();
    } catch (err) {
      console.error("Status update failed", err);
    }
  };

  // =========================
  // FILTER LOGIC
  // =========================
  const filtered = complaints
    .filter((c) =>
      statusFilter ? c.status === statusFilter : true
    )
    .filter((c) =>
      c.chassisNumber?.toLowerCase().includes(search.toLowerCase()) ||
      c.plateNumber?.toLowerCase().includes(search.toLowerCase())
    );

  if (loading) return <Loader />;

  return (
    <div className="admin-review-page">
      <h2>Complaint Management Dashboard</h2>

      {/* SEARCH */}
      <div className="search-box">
        <input
          type="text"
          placeholder="Search by name or plate..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
      </div>
      <div className="complaints-grid">
        {/* LIST */}
        {filtered.length === 0 ? (
          <p className="no-data">No complaints found</p>
        ) : (
          filtered.map((c) => (
            <div key={c.id} className="review-card">

              <h3>Complaint #{c.id}</h3>

              {/* COMPLAINT INFO */}
              <div className="info-grid">
                <div>
                  <p><strong>Owner:</strong> {c.ownerName}</p>
                  <p><strong>Plate:</strong> {c.plateNumber}</p>
                  <p><strong>Chassis:</strong> {c.chassisNumber}</p>
                </div>

                <div>
                  <p><strong>Status:</strong> {c.status}</p>
                </div>
              </div>

              {/* EXCISE DATA (NOW FROM BACKEND) */}
              <div className="excise-box">
                <h4>Excise Record</h4>

                {c.excise ? (
                  <>
                    <p><strong>Make:</strong> {c.excise.make}</p>
                    <p><strong>Model:</strong> {c.excise.model}</p>
                    <p><strong>Engine:</strong> {c.excise.engine_number}</p>
                    <p><strong>Year:</strong> {c.excise.manufacture_year}</p>
                  </>
                ) : (
                  <p style={{ color: "red" }}>
                    No excise match found
                  </p>
                )}
              </div>

              {/* ACTIONS */}
              <div className="actions">
                <button onClick={() => updateStatus(c.id, "investigating")}>
                  Investigate
                </button>

                <button
                  className="reject"
                  onClick={() => updateStatus(c.id, "rejected")}
                >
                  Reject
                </button>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
}