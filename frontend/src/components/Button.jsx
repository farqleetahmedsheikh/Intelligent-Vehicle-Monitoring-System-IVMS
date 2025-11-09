/** @format */
import "../styles/Auth.css";
export default function Button({ label, onClick, type = "button" }) {
  return (
    <button
      onClick={onClick}
      type={type}
    >
      {label}
    </button>
  );
}
