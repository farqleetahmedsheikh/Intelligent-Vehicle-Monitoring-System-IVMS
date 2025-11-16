/** @format */
import { useState } from "react";
import "../../styles/Complain.css";
import InputField from "../../components/InputField";
import Button from "../../components/Button";

export default function SearchComplaintPage() {
  const [searchQuery, setSearchQuery] = useState("");
  const [searchResults, setSearchResults] = useState([]);

  const handleSearch = () => {
    // Replace this with real API call
    const allComplaints = [
      {
        id: 1,
        carPlate: "ABC-123",
        ownerEmail: "test@example.com",
        status: "Pending",
      },
      {
        id: 2,
        carPlate: "XYZ-456",
        ownerEmail: "user@example.com",
        status: "Resolved",
      },
    ];

    const results = allComplaints.filter(
      (item) =>
        item.carPlate.includes(searchQuery) ||
        item.ownerEmail.includes(searchQuery)
    );

    setSearchResults(results);
  };

  return (
    <div className="complaint-container">
      <h2>Search Complaints</h2>
      <div className="search-bar">
        <InputField
          style={{
            width: "190%",
          }}
          type="text"
          placeholder="Search by Plate, Chassis Number"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        <Button
          style={{ width: "20%" }}
          label="Search"
          onClick={handleSearch}
        />
      </div>

      <div className="search-results">
        {searchResults.length === 0 ? (
          <p>No results found</p>
        ) : (
          searchResults.map((item) => (
            <div key={item.id} className="search-result-item">
              <p>
                <strong>Plate:</strong> {item.carPlate}
              </p>
              <p>
                <strong>Owner:</strong> {item.ownerEmail}
              </p>
              <p>
                <strong>Status:</strong> {item.status}
              </p>
            </div>
          ))
        )}
      </div>
    </div>
  );
}
