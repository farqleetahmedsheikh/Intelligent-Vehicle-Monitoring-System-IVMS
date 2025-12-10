/** @format */
import { useEffect, useState } from "react";
import axios from "axios";
import Loader from "../../components/Loader";
import ComplaintCard from "../../components/ComplaintCard";
import ComplaintDetailModal from "../../components/ComplaintDetailModal";
import "../../styles/ComplaintsPage.css";

const API = import.meta.env.VITE_API_URL || "http://localhost:8000/";

export default function ComplaintsPage() {
  const [complaints, setComplaints] = useState([]);
  const [selectedComplaint, setSelectedComplaint] = useState(null);
  const [loading, setLoading] = useState(true);

  const user = JSON.parse(localStorage.getItem("user"));
  const email = user?.email;
  const role = user?.role;

  useEffect(() => {
    const fetchComplaints = async () => {
      try {
        const res = await axios.get(`${API}complaints/`, {
          params: { email },
        });
        console.log("Fetched complaints:", res.data.complaints);
        setComplaints(res.data.complaints || []);
      } catch (err) {
        console.error("Error fetching complaints:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchComplaints();
  }, [email]);

  if (loading) return <Loader />;

  return (
    <div className="complaints-container">
      <h2>My Complaints</h2>
      {complaints.length === 0 ? (
        <p>No complaints posted yet.</p>
      ) : (
        complaints.map((c) => (
          <ComplaintCard
            key={c.id}
            complaint={c}
            onView={(complaint) => setSelectedComplaint(complaint)}
          />
        ))
      )}

      <ComplaintDetailModal
        complaint={selectedComplaint}
        onClose={() => setSelectedComplaint(null)}
      />
    </div>
  );
}
