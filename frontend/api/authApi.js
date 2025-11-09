/** @format */

import axios from "axios";

const API_BASE = import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/";

export const registerUser = async (data) => {
  return axios.post(`${API_BASE}signup/`, data);
};

export const loginUser = async (data) => {
  return axios.post(`${API_BASE}login/`, data);
};

export const requestPasswordReset = async (data) => {
  return axios.post(`${API_BASE}forgot-password/`, data);
};

export const verifyOTP = async (data) => {
  return axios.post(`${API_BASE}verify-otp/`, data);
};

export const resetPassword = async (data) => {
  return axios.post(`${API_BASE}reset-password/`, data);
};
