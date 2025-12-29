/** @format */

import { useEffect, useState } from "react";
import axios from "axios";
import "../../styles/AdminComplaints.css";
import Loader from "../../components/Loader";

const API_BASE = import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/";

export default function AdminComplaints() {
  const [complaints, setComplaints] = useState([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(false);

  // Fetch complaints
  const fetchComplaints = async () => {
    setLoading(true);
    const res = await axios.get(`${API_BASE}complaints/all/`);
    setComplaints(res.data);
    setLoading(false);
  };

  // Update Status
  const updateStatus = async (id, status) => {
    setLoading(true);
    await axios.patch(`${API_BASE}complaints/update-status/${id}/`, {
      status,
    });
    fetchComplaints(); // refresh list
    setLoading(false);
  };

  // Filter by search (id / vehicle / name)
  const filteredComplaints = complaints.filter(
    (c) =>
      c.id.toString().includes(search) ||
      c.plateNumber?.toLowerCase().includes(search.toLowerCase()) ||
      c.ownerName?.toLowerCase().includes(search.toLowerCase())
  );

  useEffect(() => {
    fetchComplaints();
  }, []);

  if (loading) return <Loader />;
  return (
    <div className="admin-page">
      <h2>Complaints Management</h2>

      <input
        type="text"
        className="search-input"
        placeholder="Search by complaint ID, vehicle number or name..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />

      <div className="complaints-list">
        {filteredComplaints.length === 0 ? (
          <p className="no-results">No complaints found</p>
        ) : (
          filteredComplaints.map((c) => (
            <div key={c.id} className="complaint-card">
              <h3>Complaint #{c.id}</h3>
              <p>
                <strong>Owner:</strong> {c.ownerName}
              </p>
              <p>
                <strong>Vehicle No:</strong> {c.plateNumber?.toUpperCase()}
              </p>
              <p>
                <strong>Status:</strong> {c.status?.toUpperCase()}
              </p>

              <div className="status-update">
                <select
                  value={c.status}
                  onChange={(e) => updateStatus(c.id, e.target.value)}
                >
                  <option value="investigating">Investigating</option>
                  <option value="resolved">Resolved</option>
                  <option value="closed">Closed</option>
                </select>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
}
