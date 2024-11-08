'use client';
import { useEffect, useState } from 'react';
import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa';
import toast from 'react-hot-toast';
import { useAnimales } from '@/Hooks/useAnimales';
import { useDietas } from '@/Hooks/useDieta';
import { useEspecies } from '@/Hooks/useEspecie';
import { useEstadoSalud } from '@/Hooks/useEstadoSalud';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { Animal } from '@/Types/next-auth-types/Animal';
import { ModalEditAnimal } from './ModalEditAnimal';
import { DeleteModalAnimal } from './DeleteModalAnimal';

export default function TablaAnimales() {
  const { navigateTo } = useCustomRouter();
  const { animales, loading, error, fetchAnimales, deleteAnimal, setAnimales} = useAnimales();
  const { especies } = useEspecies();
  const { estados } = useEstadoSalud();
  const { dietas } = useDietas();
  const { habitaciones } = useHabitaciones();

  const [selectedAnimal, setSelectedAnimal] = useState<Animal | null>(null);
  const [animalIdToDelete, setAnimalIdToDelete] = useState<number | null>(null);

  const obtenerNombreEspecie = (id: number) =>
    especies.find((especie) => especie.idEspecie === id)?.nombreEsp || 'Desconocido';

  const obtenerEstadoSalud = (id: number) =>
    estados.find((estado) => estado.idEstadoSalud === id)?.estadoSalud || 'Desconocido';

  const obtenerDieta = (id: number) =>
    dietas.find((dieta) => dieta.idDieta === id)?.nombreDiet || 'Desconocido';

  const obtenerHabitacion = (id: number) =>
    habitaciones.find((habitacion) => habitacion.idHabitacion === id)?.nombreHab || 'Desconocido';

  const handleEdit = (animal: Animal) => {
    setSelectedAnimal(animal); 
  };

  const handleDelete = (id: number) => {
    setAnimalIdToDelete(id); // Abre el modal de confirmación de eliminación
  };

  const handleSave = (updatedAnimal: Partial<Animal>) => {
    setAnimales((prevAnimales) =>
      prevAnimales.map((animal) =>
        animal.idAnimales === updatedAnimal.idAnimales ? { ...animal, ...updatedAnimal } : animal
      )
    );
    toast.success('Animal editado correctamente');
    fetchAnimales();
  };
  
  
  const confirmDelete = () => {
    if (animalIdToDelete !== null) {
      deleteAnimal(animalIdToDelete)
        .then(() => {
          toast.success('Animal eliminado correctamente');
          setAnimalIdToDelete(null);
        })
        .catch(() => {
          toast.error('Error al eliminar el animal');
        });
    }
  };

  useEffect(() => {
    console.log('Lista de animales:', animales);
  }, [animales]);

  if (loading) return <p className="text-center">Cargando datos...</p>;
  if (error) return <p className="text-center text-red-500">Error: {error}</p>;

  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Registro de Animales</h2>
        <button
          onClick={() => navigateTo('/dashboard/animales/agregarAnimal')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo animal
        </button>
      </div>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Nombre</th>
            <th className="px-6 py-3 text-center">Edad</th>
            <th className="px-6 py-3 text-center">Habitación</th>
            <th className="px-6 py-3 text-center">Dieta</th>
            <th className="px-6 py-3 text-center">Especie</th>
            <th className="px-6 py-3 text-center">Estado de Salud</th>
            <th className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {animales.map((animal) => (
            animal ? (
              <tr key={animal.idAnimales} className="border-b hover:bg-gray-100">
                <td className="px-6 py-4 text-center">{animal.nombreAni || 'Sin nombre'}</td>
                <td className="px-6 py-4 text-center">{animal.edadAni ?? 'N/A'}</td>
                <td className="px-6 py-4 text-center">{obtenerHabitacion(animal.idHabitacion) || 'Sin habitación'}</td>
                <td className="px-6 py-4 text-center">{obtenerDieta(animal.idDieta) || 'Sin dieta'}</td>
                <td className="px-6 py-4 text-center">{obtenerNombreEspecie(animal.idEspecie) || 'Sin especie'}</td>
                <td className="px-6 py-4 text-center">{obtenerEstadoSalud(animal.idEstadoSalud) || 'Sin estado'}</td>
                <td className="px-6 py-4 flex justify-center space-x-2">
                  <button
                    className="bg-blue-500 text-white px-3 py-2 rounded-full hover:bg-blue-600 transition-all flex items-center"
                    onClick={() => handleEdit(animal)}
                  >
                    <FaEdit className="mr-1" /> Editar
                  </button>
                  <button
                    className="bg-red-500 text-white px-3 py-2 rounded-full hover:bg-red-600 transition-all flex items-center"
                    onClick={() => handleDelete(animal.idAnimales)}
                  >
                    <FaTrash className="mr-1" /> Eliminar
                  </button>
                </td>
              </tr>
            ) : null
          ))}
        </tbody>
      </table>

      {/* Modal de edición */}
      {selectedAnimal && (
        <ModalEditAnimal
          animal={selectedAnimal}
          onClose={() => setSelectedAnimal(null)}
          onSave={handleSave}
        />
      )}

      {/* Modal de confirmación de eliminación */}
      {animalIdToDelete !== null && (
        <DeleteModalAnimal
          animalId={animalIdToDelete}
          onClose={() => setAnimalIdToDelete(null)}
          onDelete={confirmDelete}
          loading={loading}
        />
      )}

    </div>
  );
} 
