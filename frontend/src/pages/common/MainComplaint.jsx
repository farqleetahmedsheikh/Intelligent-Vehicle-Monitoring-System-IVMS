/** @format */
import { useNavigate } from "react-router-dom";
import "../../styles/Complain.css";

export default function ComplaintMainPage() {
  const navigate = useNavigate();
  const role = localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user")).role
    : null;
  return (
    <div className="complaint-main-container">
      <h2>Vehicle Complaints</h2>
      <p>Select an option to proceed:</p>

      <div className="complaint-options">
        <div
          className="complaint-card"
          onClick={() => navigate(`/${role}/dashboard/complain/submit`)}
        >
          <h3>Submit Complaint</h3>
          <p>Report a new stolen or lost vehicle.</p>
        </div>

        <div
          className="complaint-card"
          onClick={() => navigate(`/${role}/dashboard/complain/search`)}
        >
          <h3>Search Complaint</h3>
          <p>Check status or details of existing complaints.</p>
        </div>
      </div>
    </div>
  );
}
