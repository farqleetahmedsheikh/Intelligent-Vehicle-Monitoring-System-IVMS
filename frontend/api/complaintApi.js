/** @format */

import axios from "axios";

const API_BASE = import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/";

export const registerComplaint = async (data) => {
  return axios.post(`${API_BASE}complaints/register/`, data, {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  });
};

export const searchComplaintForUser = async (query, role, email) => {
  return axios.get(`${API_BASE}complaints/search/`, {
    params: { q: query, role, email },
  });
};

export const searchComplaintForAdmin = async (query, role) => {
  return axios.get(`${API_BASE}complaints/search/`, {
    params: { q: query, role },
  });
};

export const fetchUserComplaints = (userEmail) => {
  console.log("Fetching complaints for:", userEmail);
  return axios.get(`${API_BASE}complaints`, {
    params: { email: userEmail },
  });

};

export const fetchAllComplaints = () => {
  return axios.get(`${API_BASE}complaints`);
};

export const fetchComplaintById = async (id) => {
  return axios.get(`${API_BASE}complaints/${id}/`);
};
