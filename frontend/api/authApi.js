/** @format */

import axios from "axios";

const API_BASE = import.meta.env.VITE_API_URL || "http://127.0.0.1:8000";

export const registerUser = async (data) => {
  return axios.post(`${API_BASE}/users/register/`, data);
};

export const loginUser = async (data) => {
  return axios.post(`${API_BASE}/users/login/`, data);
};
