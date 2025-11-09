/** @format */

// src/components/AlertsDropdown.jsx
import { useEffect, useState } from "react";
import "./styles/AlertsDropdown.css";

const mockAlerts = [
  {
    id: 1,
    title: "Stolen vehicle detected",
    desc: "Plate ABC-123 near I-90",
    time: "2m",
  },
  {
    id: 2,
    title: "Vehicle matched watchlist",
    desc: "Plate XYZ-456 at Mall St",
    time: "20m",
  },
  {
    id: 3,
    title: "Camera offline",
    desc: "Camera #4 lost connection",
    time: "1h",
  },
];

const AlertsDropdown = () => {
  const [alerts, setAlerts] = useState([]);

  useEffect(() => {
    // TODO: replace mock with API call to /api/alerts?limit=5
    setAlerts(mockAlerts);
  }, []);

  return (
    <div className="alerts-dropdown" role="list" aria-label="Recent alerts">
      <div className="alerts-header">
        <strong>Alerts</strong>
        <button
          className="mark-read"
          onClick={() => {
            /* API mark all read */
          }}
        >
          Mark all read
        </button>
      </div>

      <div className="alerts-list">
        {alerts.length === 0 ? (
          <div className="empty">No alerts</div>
        ) : (
          alerts.map((a) => (
            <div key={a.id} className="alert-item">
              <div className="ai">
                <div className="alert-dot" />
              </div>
              <div className="ad">
                <div className="title">{a.title}</div>
                <div className="desc">{a.desc}</div>
              </div>
              <div className="atime">{a.time}</div>
            </div>
          ))
        )}
      </div>

      <div className="alerts-footer">
        <a href="/alerts">View all alerts</a>
      </div>
    </div>
  );
};

export default AlertsDropdown;
