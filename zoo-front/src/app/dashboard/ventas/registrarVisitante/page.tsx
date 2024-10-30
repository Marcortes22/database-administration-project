'use client';
import { useState } from 'react';
import { useRegistrarVisitante } from '@/Hooks/useRegistrarVisitante';
import { useCustomRouter } from '@/Hooks/Router/useRouter';

export default function FormularioCrearVisitante() {
  const { registrarVisitante, loading } = useRegistrarVisitante();
  const { navigateTo } = useCustomRouter();

  const [visitante, setVisitante] = useState({
    idVisitantes: '',
    nombreVist: '',
    apell1Vist: '',
    apell2Vist: '',
    correoElectronico: '',
    telefono: 0,
  });

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    const { name, value } = e.target;
    setVisitante({ ...visitante, [name]: value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    await registrarVisitante(visitante);
    navigateTo('/dashboard/ventas');
  };

  const handleCancel = () => {
    window.history.back();
  };

  return (
    <div className="max-w-4xl mx-auto my-10 p-8 bg-white shadow-2xl rounded-xl">
      <h2 className="text-3xl font-bold text-gray-800 text-center mb-6">
        Registrar Nuevo Visitante
      </h2>

      <form onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="block text-gray-700 font-medium">
              Cédula del Visitante
            </label>
            <input
              type="text"
              name="idVisitantes"
              value={visitante.idVisitantes}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">
              Nombre
            </label>
            <input
              type="text"
              name="nombreVist"
              value={visitante.nombreVist}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">
              Primer Apellido
            </label>
            <input
              type="text"
              name="apell1Vist"
              value={visitante.apell1Vist}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">
              Segundo Apellido
            </label>
            <input
              type="text"
              name="apell2Vist"
              value={visitante.apell2Vist}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">
              Correo Electrónico
            </label>
            <input
              type="email"
              name="correoElectronico"
              value={visitante.correoElectronico}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">
              Teléfono
            </label>
            <input
              type="number"
              name="telefono"
              value={visitante.telefono}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>
        </div>

        <div className="flex justify-between mt-6">
          <button
            type="button"
            onClick={handleCancel}
            className="bg-red-500 text-white px-5 py-3 rounded-lg hover:bg-red-600 transition duration-300"
          >
            Cancelar
          </button>
          <button
            type="submit"
            disabled={loading}
            className={`bg-green-500 text-white px-5 py-3 rounded-lg hover:bg-green-600 transition duration-300 ${
              loading ? 'opacity-50 cursor-not-allowed' : ''
            }`}
          >
            {loading ? 'Guardando...' : 'Registrar Visitante'}
          </button>
        </div>
      </form>
    </div>
  );
}
