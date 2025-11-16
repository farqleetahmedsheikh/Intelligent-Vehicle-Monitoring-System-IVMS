/** @format */
import { useState } from "react";
import "../../styles/Complain.css";
import InputField from "../../components/InputField";
import Button from "../../components/Button";

export default function SubmitComplaintPage() {
  const role = localStorage.getItem("user")
    ? JSON.parse(localStorage.getItem("user"))?.role
    : null;
  console.log("User role from complain :", role);
  const [formData, setFormData] = useState({
    ownerEmail: "",
    ownerPhone: "",
    ownerCnic: "",
    carMake: "",
    carModel: "",
    carVariant: "",
    carColor: "",
    carPlate: "",
    carChasis: "",
    carPicture: null,
  });

  const handleChange = (e) => {
    const { name, value, files } = e.target;
    setFormData({
      ...formData,
      [name]: files ? files[0] : value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log("Complaint Submitted:", formData);
    alert("Complaint submitted successfully!");
    // reset form
    setFormData({
      ownerEmail: "",
      ownerPhone: "",
      ownerCnic: "",
      carMake: "",
      carModel: "",
      carVariant: "",
      carColor: "",
      carPlate: "",
      carChasis: "",
      carPicture: null,
    });
  };

  return (
    <div className="complaint-container">
      <h2>Submit a Complaint</h2>
      <form className="complaint-form" onSubmit={handleSubmit}>
        {role === "admin" && (
          <>
            <h3>Owner Details</h3>
            <div className="form-row">
              <div className="form-group">
                <InputField
                style={{width: "90%"}}
                  label="Owner Email"
                  type="email"
                  name="ownerEmail"
                  value={formData.ownerEmail}
                  onChange={handleChange}
                />
              </div>
              <div className="form-group">
                <InputField
                style={{width: "90%"}}
                  label="Owner Phone"
                  type="text"
                  name="ownerPhone"
                  value={formData.ownerPhone}
                  onChange={handleChange}
                />
              </div>
            </div>
            <div className="form-group">
              <InputField
              style={{width: "90%"}}
                label="Owner CNIC"
                type="text"
                name="ownerCnic"
                value={formData.ownerCnic}
                onChange={handleChange}
              />
            </div>
          </>
        )}
        <h3>Vehicle Details</h3>
        <div className="form-row">
          <div className="form-group">
            <InputField
            style={{width: "90%"}}
              label="Car Make"
              type="text"
              name="carMake"
              value={formData.carMake}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <InputField
            style={{width: "90%"}}
              label="Car Model"
              type="text"
              name="carModel"
              value={formData.carModel}
              onChange={handleChange}
            />
          </div>
        </div>
        <div className="form-row">
          <div className="form-group">
            <InputField
            style={{width: "90%"}}
              label="Car Variant"
              type="text"
              name="carVariant"
              value={formData.carVariant}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <InputField
            style={{width: "90%"}}
              label="Car Color"
              type="text"
              name="carColor"
              value={formData.carColor}
              onChange={handleChange}
            />
          </div>
        </div>
        <div className="form-row">
          <div className="form-group">
            <InputField
            style={{width: "90%"}}
              label="Car Plate Number"
              type="text"
              name="carPlate"
              value={formData.carPlate}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <InputField
            style={{width: "90%"}}
              label="Chassis Number"
              type="text"
              name="carChasis"
              value={formData.carChasis}
              onChange={handleChange}
            />
          </div>
        </div>
        <div className="form-group">
          <label> Complaint Description</label>
          <textarea cols="30" rows="10"></textarea>
        </div>
        <div className="form-group">
          <InputField
          style={{width: "90%"}}
            label="Upload Vehicle Image"
            type="file"
            name="carPicture"
            onChange={handleChange}
          />
        </div>

        <Button label="Submit Complaint" type="submit" />
      </form>
    </div>
  );
}
