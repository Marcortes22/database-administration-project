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
    // Aquí iría la lógica para agregar el nuevo registro, ya sea por API o local
    console.log('Nuevo habitat agregado:', { 
      nombre, 
      direccion, 
      capacidad, 
      tipoHabitat, 
      estado, 
      descripcionEstado 
    });

    router.push('/dashboard/habitats');
  };

  const handleCancel = () => {
    router.push('/dashboard/habitats'); // Redirigir de vuelta a la página de habitats
  };

  return (
    <div className="max-w-md mx-auto my-6 p-6 bg-gray-800 shadow-md rounded-lg">
      <h2 className="text-xl font-bold text-white text-center mb-6">Agregar Nuevo Habitat</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label className="block text-white">Nombre</label>
          <input
            type="text"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
            className="w-full px-3 py-2 border rounded-md bg-gray-700 text-white"
            required
          />
        </div>
        <div className="mb-4">
          <label className="block text-white">Dirección</label>
          <input
            type="text"
            value={direccion}
            onChange={(e) => setDireccion(e.target.value)}
            className="w-full px-3 py-2 border rounded-md bg-gray-700 text-white"
            required
          />
        </div>
        <div className="mb-4">
          <label className="block text-white">Capacidad</label>
          <input
            type="number"
            value={capacidad}
            onChange={(e) => setCapacidad(e.target.value)}
            className="w-full px-3 py-2 border rounded-md bg-gray-700 text-white"
            required
          />
        </div>
        {/* Dropdown para Tipo de Habitat */}
        <div className="mb-4">
          <label className="block text-white">Tipo de Hábitat</label>
          <select
            value={tipoHabitat}
            onChange={(e) => setTipoHabitat(e.target.value)}
            className="w-full px-3 py-2 border rounded-md bg-gray-700 text-white"
            required
          >
            <option value="">Seleccione un tipo</option>
            <option value="Acuático">Acuático</option>
            <option value="Terrestre">Terrestre</option>
            <option value="Aéreo">Aéreo</option>
            <option value="Subterráneo">Subterráneo</option>
          </select>
        </div>
        {/* Dropdown para Estado del Habitat */}
        <div className="mb-4">
          <label className="block text-white">Estado del Hábitat</label>
          <select
            value={estado}
            onChange={(e) => setEstado(e.target.value)}
            className="w-full px-3 py-2 border rounded-md bg-gray-700 text-white"
            required
          >
            <option value="">Seleccione un estado</option>
            <option value="Bueno">Bueno</option>
            <option value="Regular">Regular</option>
            <option value="Malo">Malo</option>
          </select>
        </div>
        {/* Descripción del Estado */}
        <div className="mb-6">
          <label className="block text-white">Descripción del Estado</label>
          <textarea
            value={descripcionEstado}
            onChange={(e) => setDescripcionEstado(e.target.value)}
            className="w-full px-3 py-2 border rounded-md bg-gray-700 text-white"
            rows={3}
            required
          ></textarea>
        </div>
        <div className="flex justify-between">
          <button 
            type="submit" 
            className="bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600 transition duration-300">
            Agregar
          </button>
          <button 
            type="button" 
            onClick={handleCancel} 
            className="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600 transition duration-300">
            Cancelar
          </button>
        </div>
      </form>
    </div>
  );
}
