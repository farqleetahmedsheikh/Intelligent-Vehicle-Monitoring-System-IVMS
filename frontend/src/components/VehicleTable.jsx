/** @format */

// src/components/VehicleTable.jsx
import React from "react";
import "../styles/components.css";

const VehicleTable = ({ vehicles }) => {
  return (
    <div className="vehicle-table">
      <h2>My Registered Vehicles</h2>
      <table>
        <thead>
          <tr>
            <th>Plate No</th>
            <th>Model</th>
            <th>Status</th>
            <th>Last Seen</th>
          </tr>
        </thead>
        <tbody>
          {vehicles.map((v, i) => (
            <tr key={i}>
              <td>{v.plate}</td>
              <td>{v.model}</td>
              <td className={`status ${v.status.toLowerCase()}`}>{v.status}</td>
              <td>{v.lastSeen}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default VehicleTable;
