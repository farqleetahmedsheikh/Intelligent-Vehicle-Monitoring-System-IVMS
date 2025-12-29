/** @format */

import "../styles/VehicleTable.css";

const VehicleTable = ({ vehicles = [], title = "My Registered Vehicles", columns }) => {
  // Default columns if not provided
  const defaultColumns = [
    { key: "plate", label: "Plate No" },
    { key: "model", label: "Model" },
    { key: "status", label: "Status" },
    { key: "lastSeen", label: "Last Seen" },
  ];

  const tableColumns = columns || defaultColumns;

  return (
    <div className="vehicle-table">
      <h2>{title}</h2>
      <table>
        <thead>
          <tr>
            {tableColumns.map((col) => (
              <th key={col.key}>{col.label}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {vehicles.map((v, i) => (
            <>
            <tr key={i}>
              {tableColumns.map((col) => (
                <td
                  key={col.key}
                  className={col.key === "status" ? `status ${v.status?.toLowerCase()}` : ""}
                >
                  {v[col.key]}
                </td>
              ))}
            </tr>
            </>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default VehicleTable;
