/** @format */

export default function InputField({ label, type, value, onChange, name }) {
  return (
    <div className="mb-4">
      <label className="block text-sm font-semibold mb-1">{label}</label>
      <input
        type={type}
        name={name}
        value={value}
        onChange={onChange}
        className="w-full border border-gray-300 rounded-lg p-2 focus:ring focus:ring-blue-300"
      />
    </div>
  );
}
