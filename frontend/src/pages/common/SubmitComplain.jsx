/** @format */
import { useState } from "react";
import "../../styles/Complain.css";
import InputField from "../../components/InputField";
import Button from "../../components/Button";
import { registerComplaint } from "../../../api/complaintApi";

export default function SubmitComplaintPage() {
  const user = localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user"))
    : null;

  const [formData, setFormData] = useState({
    ownerEmail: "",
    ownerPhone: "",
    ownerCnic: "",
    vehicleMake: "",
    vehicleModel: "",
    vehicleVariant: "",
    vehicleColor: "",
    plateNumber: "",
    chassisNumber: "",
    complaintDescription: "",
    vehiclePicture: null,
  });

  const handleChange = (e) => {
    const { name, value, files } = e.target;
    setFormData({
      ...formData,
      [name]: files ? files[0] : value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Auto fill user data if user is normal user
    let finalData = { ...formData };
    if (user && user.role === "user") {
      finalData.ownerEmail = user.email;
      finalData.ownerPhone = user.phoneNumber;
      finalData.ownerCnic = user.cnic;
    }

    const form = new FormData();
    for (let key in finalData) {
      form.append(key, finalData[key]);
    }

    try {
      console.log("Submitting complaint with data:", finalData);
      await registerComplaint(finalData);

      // Reset form
      setFormData({
        ownerEmail: "",
        ownerPhone: "",
        ownerCnic: "",
        vehicleMake: "",
        vehicleModel: "",
        vehicleVariant: "",
        vehicleColor: "",
        plateNumber: "",
        chassisNumber: "",
        complaintDescription: "",
        vehiclePicture: null,
      });
    } catch (error) {
      console.error("Error submitting complaint:", error);
    }
  };

  return (
    <div className="complaint-container">
      <h2>Submit a Complaint</h2>

      <form className="complaint-form" onSubmit={handleSubmit}>
        {user?.role === "admin" && (
          <>
            <h3>Owner Details</h3>
            <div className="form-row">
              <InputField
                label="Owner Email"
                name="ownerEmail"
                type="email"
                value={formData.ownerEmail}
                onChange={handleChange}
                style={{ width: "90%" }}
              />

              <InputField
                label="Owner Phone"
                name="ownerPhone"
                type="text"
                value={formData.ownerPhone}
                onChange={handleChange}
                style={{ width: "90%" }}
              />
            </div>

            <InputField
              label="Owner CNIC"
              name="ownerCnic"
              type="text"
              value={formData.ownerCnic}
              onChange={handleChange}
              style={{ width: "90%" }}
            />
          </>
        )}

        <h3>Vehicle Details</h3>

        <div className="form-row">
          <InputField
            label="Make"
            name="vehicleMake"
            value={formData.vehicleMake}
            onChange={handleChange}
            style={{ width: "90%" }}
          />

          <InputField
            label="Model"
            name="vehicleModel"
            value={formData.vehicleModel}
            onChange={handleChange}
            style={{ width: "90%" }}
          />
        </div>

        <div className="form-row">
          <InputField
            label="Variant"
            name="vehicleVariant"
            value={formData.vehicleVariant}
            onChange={handleChange}
            style={{ width: "90%" }}
          />

          <InputField
            label="Color"
            name="vehicleColor"
            value={formData.vehicleColor}
            onChange={handleChange}
            style={{ width: "90%" }}
          />
        </div>

        <div className="form-row">
          <InputField
            label="Plate Number"
            name="plateNumber"
            value={formData.plateNumber}
            onChange={handleChange}
            style={{ width: "90%" }}
          />

          <InputField
            label="Chassis Number"
            name="chassisNumber"
            value={formData.chassisNumber}
            onChange={handleChange}
            style={{ width: "90%" }}
          />
        </div>

        <label>Complaint Description</label>
        <textarea
          name="complaintDescription"
          rows="4"
          value={formData.complaintDescription}
          onChange={handleChange}
        />

        <InputField
          label="Upload Vehicle Image"
          type="file"
          name="vehiclePicture"
          onChange={handleChange}
          style={{ width: "90%" }}
        />

        <Button label="Submit Complaint" type="submit" />
      </form>
    </div>
  );
}
