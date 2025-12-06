/** @format */
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import "../../styles/AlertDetails.css";
import Loader from "../../components/Loader";
import Button from "../../components/Button";
import { getAlertDetails, markAlertRead } from "../../../api/alertApi";

export default function AlertDetailsPage() {
  const { alertId } = useParams();
  const [alert, setAlert] = useState(null);
  const [loading, setLoading] = useState(true);
  const [isRead, setIsRead] = useState(false);

  useEffect(() => {
    fetchAlertDetails();
  }, []);

  const fetchAlertDetails = async () => {
    try {
      const res = await getAlertDetails(alertId);
      setAlert(res.data);
      setIsRead(res.data.isRead);
    } catch (err) {
      console.error("Error fetching alert details:", err);
    } finally {
      setLoading(false);
    }
  };

  const handleMarkAsRead = async () => {
    try {
      await markAlertRead(alertId);
      setIsRead(true);
      alert("Marked as read!");
    } catch (err) {
      console.error(err);
    }
  };

  if (loading) return <Loader />;

  if (!alert)
    return <p className="alert-error">Alert not found or has been deleted.</p>;

  return (
    <div className="alert-details-container">
      <h2>Alert Details</h2>

      <div className="alert-card">
        <div className="alert-info">
          <h3>Vehicle Information</h3>
          <p>
            <strong>Plate Number:</strong> {alert.plateNumber}
          </p>
          <p>
            <strong>Model:</strong> {alert.vehicleModel}
          </p>
          <p>
            <strong>Color:</strong> {alert.vehicleColor}
          </p>

          <h3>Detection Details</h3>
          <p>
            <strong>Detected At:</strong> {alert.detectedAt}
          </p>
          <p>
            <strong>Location:</strong> {alert.detectedLocation}
          </p>
          <p>
            <strong>Possible Route:</strong> {alert.predictedRoute || "N/A"}
          </p>

          <h3>Owner</h3>
          <p>
            <strong>Email:</strong> {alert.ownerEmail}
          </p>
          <p>
            <strong>CNIC:</strong> {alert.ownerCnic}
          </p>

          <div className="alert-status">
            <span className={isRead ? "status-read" : "status-unread"}>
              {isRead ? "Read" : "Unread"}
            </span>
          </div>

          {!isRead && (
            <Button label="Mark as Read" onClick={handleMarkAsRead} />
          )}
        </div>

        {alert.alertImage && (
          <div className="alert-image">
            <img src={alert.alertImage} alt="Alert" />
          </div>
        )}
      </div>
    </div>
  );
}
