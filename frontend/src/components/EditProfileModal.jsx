/** @format */
import { useState } from "react";
import "./styles/EditProfileModal.css";

const EditProfileModal = ({ user = {}, onClose, onSave }) => {
  const [form, setForm] = useState({
    fullName: user.fullName || "",
    phoneNumber: user.phoneNumber || "",
    cnic: user.cnic || "",
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleChange = (e) =>
    setForm({ ...form, [e.target.name]: e.target.value });

  const handleSave = async () => {
    setLoading(true);
    setError("");
    try {
      // TODO: call API to update user profile (PATCH /users/<id>/)
      // e.g. await axios.patch(`/api/users/${user.id}/`, form, { headers: {...} })
      onSave({ ...user, ...form });
    } catch (err) {
      setError("Failed to update profile");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="modal-backdrop">
      <div className="modal">
        <header className="modal-header">
          <h3>Edit Profile</h3>
          <button onClick={onClose} className="close-btn">
            ✕
          </button>
        </header>

        <div className="modal-body">
          {error && <p className="error">{error}</p>}
          <label>Full Name</label>
          <input
            name="fullName"
            value={form.fullName}
            onChange={handleChange}
          />
          <label>Phone Number</label>
          <input
            name="phoneNumber"
            value={form.phoneNumber}
            onChange={handleChange}
          />
          <label>CNIC</label>
          <input name="cnic" value={form.cnic} onChange={handleChange} />
        </div>

        <footer className="modal-footer">
          <button className="btn btn-secondary" onClick={onClose}>
            Cancel
          </button>
          <button
            className="btn btn-primary"
            onClick={handleSave}
            disabled={loading}
          >
            {loading ? "Saving..." : "Save changes"}
          </button>
        </footer>
      </div>
    </div>
  );
};

export default EditProfileModal;
