/** @format */
import { useState } from "react";
import "../../styles/SearchComplaint.css";
import InputField from "../../components/InputField";
import Button from "../../components/Button";
import {
  searchComplaintForAdmin,
  searchComplaintForUser,
} from "../../../api/complaintApi";
import { Link, useNavigate } from "react-router-dom";
import { ArrowLeft } from "lucide-react";
export default function SearchComplaintPage() {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState("");
  const [results, setResults] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [successMessage, setSuccessMessage] = useState("");
  const role = localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user")).role
    : null;
  const email = localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user")).email
    : null;

  const handleSearch = async () => {
    console.log("Searching for:", searchQuery, "With role:", role);
    if (!searchQuery.trim()) {
      setError("Please enter Plate Number, CNIC or Chassis Number.");
      return;
    }

    setLoading(true);
    setError("");
    setSuccessMessage("");

    try {
      let res;
      if (role === "admin") {
        res = await searchComplaintForAdmin(searchQuery, role);
      } else if (role === "user") {
        res = await searchComplaintForUser(searchQuery, role, email);
      }
      console.log("Search response:", res);

      if (Array.isArray(res.data.data) && res.data.data.length > 0) {
        setResults(res.data.data);
        setSuccessMessage(`Found ${res.data.data.length} result(s).`);
      } else {
        setResults([]);
        setError("No matching vehicle found.");
      }
    } catch (err) {
      setResults([]);
      setError(err.response?.data?.error || "Something went wrong!");
    }

    setLoading(false);
  };

      const goBack = () => {
        if (window.history.length > 1) {
          navigate(-1);
        } else {
          navigate("/"); // fallback route if no history
        }
      };

  return (
    <div className="complaint-container">
      <button className="back-button" onClick={goBack}>
        <ArrowLeft size={18} /> Back
      </button>
      <h2>Search Complaint</h2>

      {/* ALERT MESSAGES */}
      {error && <p className="alert-error">{error}</p>}
      {successMessage && <p className="alert-success">{successMessage}</p>}

      {/* SEARCH BAR */}
      <div className="search-bar">
        <InputField
          style={{ width: "180%" }}
          type="text"
          placeholder="Enter Plate / CNIC / Chassis Number"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />

        <Button
          style={{ width: "20%" }}
          label={loading ? "Searching..." : "Search"}
          onClick={handleSearch}
          disabled={loading}
        />
      </div>

      {/* RESULTS SECTION */}
      <div className="search-results">
        {results === null ? (
          <p className="hint-text">Search to view results...</p>
        ) : results.length === 0 ? (
          <p>No results found.</p>
        ) : (
          results.map((item) => (
            <div key={item.id} className="search-result-item">
              <p>
                <strong>Owner:</strong> {item.ownerName}
              </p>
              <p>
                <strong>Email:</strong> {item.ownerEmail}
              </p>
              <p>
                <strong>Plate:</strong> {item.plateNumber}
              </p>
              <p>
                <strong>Status:</strong>{" "}
                <span
                  className={
                    item.status === "investigating"
                      ? "status investigating"
                      : item.status === "resolved"
                      ? "status resolved"
                      : "status closed"
                  }
                >
                  {item.status.toUpperCase()}
                </span>
              </p>
              <Link to={`/${role}/dashboard/vehicle-details/${item.id}`}>
                View More
              </Link>
            </div>
          ))
        )}
      </div>
    </div>
  );
}
