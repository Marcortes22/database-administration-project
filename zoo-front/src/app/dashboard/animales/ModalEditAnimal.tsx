import { useState, useEffect } from 'react';
import toast from 'react-hot-toast';
import { Animal, AnimalUpdateDTO } from '@/Types/next-auth-types/Animal';
import { useEspecies } from '@/Hooks/useEspecie';
import { useEstadoSalud } from '@/Hooks/useEstadoSalud';
import { useDietas } from '@/Hooks/useDieta';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { useAnimales } from '@/Hooks/useAnimales';

interface ModalEditAnimalProps {
  animal: Animal | null;
  onClose: () => void; // Función para cerrar el modal
  onSave: (updatedAnimal: Partial<Animal>) => void; // Función para guardar y refrescar la lista de animales
}

export const ModalEditAnimal: React.FC<ModalEditAnimalProps> = ({ animal, onClose, onSave }) => {
  const { updateAnimal, loading } = useAnimales();
  const { especies, loading: loadingEspecies } = useEspecies();
  const { estados, loading: loadingEstados } = useEstadoSalud();
  const { dietas, loading: loadingDietas } = useDietas();
  const { habitaciones, loading: loadingHabitaciones } = useHabitaciones();
  
  const [formData, setFormData] = useState<AnimalUpdateDTO>({});

  useEffect(() => {
    if (animal) {
      setFormData({
        nombreAni: animal.nombreAni,
        edadAni: animal.edadAni,
        idDieta: animal.idDieta,
        idHabitacion: animal.idHabitacion,
        idEspecie: animal.idEspecie,
        idEstadoSalud: animal.idEstadoSalud,
      });
    }
  }, [animal]);

  const handleSave = () => {
    if (animal) {
      updateAnimal(animal.idAnimales, formData)
        .then(() => {
          toast.success('Animal editado correctamente');
          onSave(formData);
          onClose();
        })
        .catch(() => {
          toast.error('Error al editar el animal');
        });
    }
  };

  if (!formData) {
    return null;
  }

  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
      <div className="bg-white p-6 rounded-lg shadow-lg w-96">
        <h3 className="text-xl font-bold mb-4">Editar Animal</h3>
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium">Nombre</label>
            <input
              type="text"
              className="w-full p-2 border rounded"
              value={formData.nombreAni || ''}
              onChange={(e) => setFormData({ ...formData, nombreAni: e.target.value })}
            />
          </div>
          <div>
            <label className="block text-sm font-medium">Edad</label>
            <input
              type="number"
              className="w-full p-2 border rounded"
              value={formData.edadAni ?? ''}
              onChange={(e) => setFormData({ ...formData, edadAni: parseInt(e.target.value) })}
            />
          </div>
          <div>
            <label className="block text-sm font-medium">Especie</label>
            <select
              className="w-full p-2 border rounded"
              value={formData.idEspecie ?? ''}
              onChange={(e) => setFormData({ ...formData, idEspecie: parseInt(e.target.value) })}
            >
              {loadingEspecies ? (
                <option>Cargando especies...</option>
              ) : (
                especies.map((especie) => (
                  <option key={especie.idEspecie} value={especie.idEspecie}>
                    {especie.nombreEsp}
                  </option>
                ))
              )}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium">Estado de Salud</label>
            <select
              className="w-full p-2 border rounded"
              value={formData.idEstadoSalud ?? ''}
              onChange={(e) => setFormData({ ...formData, idEstadoSalud: parseInt(e.target.value) })}
            >
              {loadingEstados ? (
                <option>Cargando estados de salud...</option>
              ) : (
                estados.map((estado) => (
                  <option key={estado.idEstadoSalud} value={estado.idEstadoSalud}>
                    {estado.estadoSalud}
                  </option>
                ))
              )}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium">Dieta</label>
            <select
              className="w-full p-2 border rounded"
              value={formData.idDieta ?? ''}
              onChange={(e) => setFormData({ ...formData, idDieta: parseInt(e.target.value) })}
            >
              {loadingDietas ? (
                <option>Cargando dietas...</option>
              ) : (
                dietas.map((dieta) => (
                  <option key={dieta.idDieta} value={dieta.idDieta}>
                    {dieta.nombreDiet}
                  </option>
                ))
              )}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium">Habitación</label>
            <select
              className="w-full p-2 border rounded"
              value={formData.idHabitacion ?? ''}
              onChange={(e) => setFormData({ ...formData, idHabitacion: parseInt(e.target.value) })}
            >
              {loadingHabitaciones ? (
                <option>Cargando habitaciones...</option>
              ) : (
                habitaciones.map((habitacion) => (
                  <option key={habitacion.idHabitacion} value={habitacion.idHabitacion}>
                    {habitacion.nombreHab}
                  </option>
                ))
              )}
            </select>
          </div>
          <div className="flex justify-end space-x-2">
            <button
              className="bg-gray-500 text-white px-4 py-2 rounded-full hover:bg-gray-600 transition duration-300"
              onClick={onClose}
            >
              Cancelar
            </button>
            <button
              className="bg-blue-500 text-white px-4 py-2 rounded-full hover:bg-blue-600 transition duration-300"
              onClick={handleSave}
              disabled={loading}
            >
              {loading ? 'Guardando...' : 'Guardar cambios'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};
