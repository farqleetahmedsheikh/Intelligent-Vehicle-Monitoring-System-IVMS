/** @format */

import axios from "axios";

const API_BASE = import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/";

export const registerComplaint = async (data) => {
  return axios.post(`${API_BASE}complaints/register/`, data);
};

export const searchComplaint = async (query) => {
  return axios.get(`${API_BASE}search/`, {
    params: { q: query },
  });
};
