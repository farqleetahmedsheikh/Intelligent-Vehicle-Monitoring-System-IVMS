/** @format */
import "../../styles/VehicleDetails.css";

export default function VehicleDetailsPage() {
  return (
    <div className="vehicle-details-container">
      <h2 className="page-title">Vehicle Details</h2>

      {/* Vehicle Information */}
      <div className="details-card">
        <h3>Vehicle Information</h3>
        <div className="details-grid">
          <div className="detail-item">
            <label>Make:</label>
            <p>Toyota</p>
          </div>
          <div className="detail-item">
            <label>Model:</label>
            <p>Corolla</p>
          </div>
          <div className="detail-item">
            <label>Variant:</label>
            <p>GLi</p>
          </div>
          <div className="detail-item">
            <label>Color:</label>
            <p>White</p>
          </div>

          <div className="detail-item">
            <label>Plate No:</label>
            <p>ABC-123</p>
          </div>
          <div className="detail-item">
            <label>Chassis No:</label>
            <p>YZT09876</p>
          </div>

          <div className="vehicle-image-box">
            <img
              src="https://via.placeholder.com/300x170"
              alt="Vehicle"
              className="vehicle-image"
            />
          </div>
        </div>
      </div>

      {/* Owner Information */}
      <div className="details-card">
        <h3>Owner Details</h3>
        <div className="details-grid">
          <div className="detail-item">
            <label>Name:</label>
            <p>Ahmad Ali</p>
          </div>
          <div className="detail-item">
            <label>Email:</label>
            <p>ahmad@example.com</p>
          </div>
          <div className="detail-item">
            <label>Phone:</label>
            <p>0321-1234567</p>
          </div>
          <div className="detail-item">
            <label>CNIC:</label>
            <p>35202-1234567-8</p>
          </div>
        </div>
      </div>

      {/* Last Detection */}
      <div className="details-card">
        <h3>Last Detection</h3>
        <div className="detection-row">
          <p>
            <strong>Location:</strong> Kashmir Highway, Islamabad
          </p>
          <p>
            <strong>Date:</strong> 22 Jan 2025
          </p>
          <p>
            <strong>Time:</strong> 10:42 AM
          </p>
        </div>

        <div className="vehicle-image-box">
          <img
            src="https://via.placeholder.com/400x220"
            className="vehicle-image"
            alt="Last detection snapshot"
          />
        </div>
      </div>

      {/* Predicted Routes */}
      <div className="details-card">
        <h3>Possible Predicted Routes</h3>

        <ul className="routes-list">
          <li>Route 1 → IJP Road → Faizabad → Murree Road</li>
          <li>Route 2 → Kashmir Highway → G-9 → G-10</li>
          <li>Route 3 → GT Road → Rawat → Lahore direction</li>
        </ul>
      </div>
    </div>
  );
}
