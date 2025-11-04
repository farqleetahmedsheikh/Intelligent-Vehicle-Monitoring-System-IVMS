/** @format */

export default function Button({ label, onClick, type = "button" }) {
  return (
    <button
      onClick={onClick}
      type={type}
      className="bg-blue-600 text-white w-full py-2 rounded-lg hover:bg-blue-700 transition"
    >
      {label}
    </button>
  );
}
