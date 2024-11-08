'use client';
import { useState } from 'react';
import { useEstadoSalud } from '@/Hooks/useEstadoSalud';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { useRegistrarAnimal } from '@/Hooks/useRegistrarAnimal';
import { useDietas } from '@/Hooks/useDieta';
import { useEspecies } from '@/Hooks/useEspecie';
import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { FaPlus } from 'react-icons/fa';
import ModalRegistrarDieta from '@/Components/ModalRegistrarDieta';
import { useAlimentos } from '@/Hooks/useAlimentos';

export default function FormularioCrearAnimal() {
  const { especies } = useEspecies();
  const { dietas } = useDietas();
  const { estados } = useEstadoSalud();
  const { habitaciones } = useHabitaciones();
  const { crearAnimal, loading } = useRegistrarAnimal();
  const { navigateTo } = useCustomRouter();

  const [isModalOpen, setIsModalOpen] = useState(false); // Estado para controlar el modal

  const [animal, setAnimal] = useState({
    idAnimales: 0,
    idZoo: 0,
    nombreAni: '',
    edadAni: 0,
    idDieta: 0,
    idHabitacion: 0,
    idEspecie: 0,
    idEstadoSalud: 0,
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setAnimal({ ...animal, [name]: value });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    crearAnimal(animal);
    //navigateTo('/dashboard/animales');
  };

  const handleCancel = () => {
    navigateTo('/dashboard/animales');
  };

  return (
    <div className="max-w-4xl mx-auto my-10 p-8 bg-white shadow-2xl rounded-xl">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-3xl font-bold text-gray-800">Registrar Nuevo Animal</h2>
        <div className="flex gap-4">
          <button
            onClick={() => navigateTo('/dashboard/habitats/addHabitats')}
            className="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition duration-300 flex items-center"
          >
            <FaPlus className="mr-2" /> Habitación
          </button>
          <button
            onClick={() => setIsModalOpen(true)} // Abrir el modal al hacer clic
            className="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition duration-300 flex items-center"
          >
            <FaPlus className="mr-2" /> Dieta
          </button>
        </div>
      </div>

      {/* Modal para registrar dieta */}
      <ModalRegistrarDieta
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)} // Cerrar el modal
      />

      <form onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="block text-gray-700 font-medium">Nombre del Animal</label>
            <input
              type="text"
              name="nombreAni"
              value={animal.nombreAni}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Edad</label>
            <input
              type="number"
              name="edadAni"
              value={animal.edadAni}
              onChange={handleChange}
              min={0}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Especie</label>
            <select
              name="idEspecie"
              value={animal.idEspecie}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            >
              <option value="">Selecciona una especie</option>
              {especies.map((especie) => (
                <option key={especie.idEspecie} value={especie.idEspecie}>
                  {especie.nombreEsp}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Dieta</label>
            <select
              name="idDieta"
              value={animal.idDieta}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            >
              <option value="">Selecciona una dieta</option>
              {dietas.map((dieta) => (
                <option key={dieta.idDieta} value={dieta.idDieta}>
                  {dieta.nombreDiet}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Habitación</label>
            <select
              name="idHabitacion"
              value={animal.idHabitacion}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            >
              <option value="">Selecciona una habitación</option>
              {habitaciones.map((habitacion) => (
                <option key={habitacion.idHabitacion} value={habitacion.idHabitacion}>
                  {habitacion.nombreHab}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Estado de Salud</label>
            <select
              name="idEstadoSalud"
              value={animal.idEstadoSalud}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            >
              <option value="">Selecciona un estado de salud</option>
              {estados.map((estado) => (
                <option key={estado.idEstadoSalud} value={estado.idEstadoSalud}>
                  {estado.estadoSalud}
                </option>
              ))}
            </select>
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
            {loading ? 'Guardando...' : 'Registrar Animal'}
          </button>
        </div>
      </form>
    </div>
  );
}
