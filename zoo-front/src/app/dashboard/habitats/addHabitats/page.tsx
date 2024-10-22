'use client';

import { useState } from 'react';
import { useTiposHabitacion } from '@/Hooks/useTipoHabitacion';
import { useRegistrarHabitacion } from '@/Hooks/useRegistrarHabitacion';

export default function AddHabitat() {
  const [nombre, setNombre] = useState('');
  const [direccion, setDireccion] = useState('');
  const [capacidad, setCapacidad] = useState('');
  const [tipoHabitat, setTipoHabitat] = useState('');

  const { tiposHabitacion, loading, error } = useTiposHabitacion();
  const { registrarHabitacion } = useRegistrarHabitacion(); // Usamos el hook

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    const nuevaHabitacion = {
      nombreHab: nombre,
      direccion,
      capacidad: parseInt(capacidad),
      idTipoHabitacion: parseInt(tipoHabitat),
    };

    registrarHabitacion(nuevaHabitacion); // Llamamos al hook
  };

  const handleCancel = () => {
    window.history.back(); // Retroceder a la página anterior
  };

  return (
    <div className="max-w-4xl mx-auto my-10 p-8 bg-white shadow-2xl rounded-xl">
      <h2 className="text-3xl font-bold text-gray-800 text-center mb-6">
        Agregar Nueva Habitación
      </h2>

      <form onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="block text-gray-700 font-medium">Nombre</label>
            <input
              type="text"
              value={nombre}
              onChange={(e) => setNombre(e.target.value)}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Dirección</label>
            <input
              type="text"
              value={direccion}
              onChange={(e) => setDireccion(e.target.value)}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Capacidad</label>
            <input
              type="number"
              value={capacidad}
              onChange={(e) => setCapacidad(e.target.value)}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Tipo de Habitación</label>
            {loading ? (
              <p>Cargando tipos de habitación...</p>
            ) : error ? (
              <p className="text-red-500">{error}</p>
            ) : (
              <select
                value={tipoHabitat}
                onChange={(e) => setTipoHabitat(e.target.value)}
                className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
                required
              >
                <option value="">Seleccione un tipo</option>
                {tiposHabitacion.map((tipo) => (
                  <option key={tipo.idTipoHabitacion} value={tipo.idTipoHabitacion}>
                    {tipo.nombreTh}
                  </option>
                ))}
              </select>
            )}
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
            className="bg-green-500 text-white px-5 py-3 rounded-lg hover:bg-green-600 transition duration-300"
          >
            Agregar
          </button>
        </div>
      </form>
    </div>
  );
}
