/** @format */

import { useEffect, useState } from "react";
import axios from "axios";
import Button from "../../components/Button";

const API = import.meta.env.VITE_API_URL;

export default function AlertsPage() {
  const [alerts, setAlerts] = useState([]);

  const user = JSON.parse(localStorage.getItem("user"));
  const isAdmin = user?.role === "admin";
  const userId = user?.id;

useEffect(() => {
  const fetchAlerts = async () => {
    try {
      const res = await axios.get(
        isAdmin ? `${API}alerts/all/` : `${API}alerts/user/?email=${userId}`
      );
      setAlerts(Array.isArray(res.data) ? res.data : []);
    } catch (error) {
      console.error("Failed to fetch alerts:", error);
    }
  };
  fetchAlerts();

const wsUrl = isAdmin
  ? `ws://localhost:8000/ws/alerts/admin/`
  : `ws://localhost:8000/ws/alerts/${userId}/`;
  const ws = new WebSocket(wsUrl);

  ws.onopen = () => console.log("WebSocket connected:", wsUrl);
  ws.onmessage = (event) => {
    const newAlert = JSON.parse(event.data);
    setAlerts((prev) => [newAlert, ...prev]);
  };

  ws.onclose = () => console.log("WebSocket disconnected");

  return () => ws.close();
}, []);

  return (
    <div className="alerts-container">
      <h2>Alerts</h2>

      {alerts.length === 0 ? (
        <p>No alerts available.</p>
      ) : (
        alerts.map((alert) => (
          <div key={alert.id} className="alert-card">
            <p>{alert.alertMessage}</p>
            {alert.alertImage && (
              <img
                src={`http://localhost:8000${alert.alertImage}`}
                alt="Alert"
                className="alert-image"
              />
            )}
            <small>{new Date(alert.sentAt).toLocaleString()}</small>
            <Button label={"View Detail"} />
          </div>
        ))
      )}
    </div>
  );
}
