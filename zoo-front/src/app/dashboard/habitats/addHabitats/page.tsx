'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import toast from 'react-hot-toast';

export default function AddHabitat() {
  const [nombre, setNombre] = useState('');
  const [direccion, setDireccion] = useState('');
  const [capacidad, setCapacidad] = useState('');
  const [tipoHabitat, setTipoHabitat] = useState('');
  const [estado, setEstado] = useState('');
  const [descripcionEstado, setDescripcionEstado] = useState('');
  const router = useRouter();

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    toast.success('Hábitat registrado correctamente', {
      style: {
        borderRadius: '10px',
        background: '#333',
        color: '#fff',
      },
    });

    console.log('Nuevo hábitat agregado:', { 
      nombre, direccion, capacidad, tipoHabitat, estado, descripcionEstado 
    });

    router.push('/dashboard/habitats');
  };

  const handleCancel = () => {
    router.push('/dashboard/habitats');
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
            <label className="block text-gray-700 font-medium">Tipo de Hábitat</label>
            <select
              value={tipoHabitat}
              onChange={(e) => setTipoHabitat(e.target.value)}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            >
              <option value="">Seleccione un tipo</option>
              <option value="Acuático">Acuático</option>
              <option value="Terrestre">Terrestre</option>
              <option value="Aéreo">Aéreo</option>
              <option value="Subterráneo">Subterráneo</option>
            </select>
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Estado de la Habitación</label>
            <select
              value={estado}
              onChange={(e) => setEstado(e.target.value)}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            >
              <option value="">Seleccione un estado</option>
              <option value="Bueno">Bueno</option>
              <option value="Regular">Regular</option>
              <option value="Malo">Malo</option>
            </select>
          </div>

          <div className="md:col-span-2">
            <label className="block text-gray-700 font-medium">Descripción del Estado</label>
            <textarea
              value={descripcionEstado}
              onChange={(e) => setDescripcionEstado(e.target.value)}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              rows={3}
              required
            ></textarea>
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
