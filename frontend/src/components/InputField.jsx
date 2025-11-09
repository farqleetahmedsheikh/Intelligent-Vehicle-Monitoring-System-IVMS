/** @format */
import "../styles/Auth.css";
export default function InputField({ label, type, value, onChange, name }) {
  return (
    <div className="mb-4">
      <label className="block text-sm font-semibold mb-1">{label}</label>
      <input
        type={type}
        name={name}
        value={value}
        onChange={onChange}
      />
    </div>
  );
}
