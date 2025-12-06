/** @format */
import axios from "axios";

const API_BASE = import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/";

// Fetch all alerts for the logged-in user
export const fetchAlerts = async () => {
  return axios.get(`${API_BASE}alerts/`);
};

// Fetch single alert by ID
export const getAlertDetails = async (id) => {
  return axios.get(`${API_BASE}alerts/${id}/`);
};

// Mark alert as read
export const markAlertRead = async (id) => {
  return axios.patch(`${API_BASE}alerts/${id}/`, { isRead: true });
};
