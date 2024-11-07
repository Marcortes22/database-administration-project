import { useEditarHabitacion } from '@/Hooks/useEditarHabitacion';
import { useEstadosHabitacion } from '@/Hooks/useEstadoHabitacion';
import { useTiposHabitacion } from '@/Hooks/useTipoHabitacion';
import { Habitacion } from '@/Types/next-auth-types/Habitacion';
import React, { useState, useEffect } from 'react';
import toast from 'react-hot-toast';

interface ModalEditHabitacionProps {
  habitacion: Habitacion | null;
  onClose: () => void;
  onSave: () => void;
}

export const ModalEditHabitacion: React.FC<ModalEditHabitacionProps> = ({ habitacion, onClose, onSave }) => {
  const { editarHabitacion, loading } = useEditarHabitacion();
  const { tiposHabitacion, loading: loadingTipos } = useTiposHabitacion();
  const { estados, loading: loadingEstados } = useEstadosHabitacion();
  const [formData, setFormData] = useState<Habitacion | null>(habitacion);

  useEffect(() => {
    setFormData(habitacion);
  }, [habitacion]);

  const handleSave = () => {
    if (formData) {
      editarHabitacion(formData.idHabitacion, formData)
        .then(() => {
          toast.success('Habitación editada correctamente');
          onSave();
          onClose();
        })
        .catch(() => {
          toast.error('Error al editar la habitación');
        });
    }
  };

  if (!formData) {
    return null;
  }

  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
      <div className="bg-white p-6 rounded-lg shadow-lg w-96">
        <h3 className="text-xl font-bold mb-4">Editar Habitación</h3>
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium">Nombre</label>
            <input
              type="text"
              className="w-full p-2 border rounded"
              value={formData.nombreHab}
              onChange={(e) => setFormData({ ...formData, nombreHab: e.target.value })}
            />
          </div>
          <div>
            <label className="block text-sm font-medium">Dirección</label>
            <input
              type="text"
              className="w-full p-2 border rounded"
              value={formData.direccion}
              onChange={(e) => setFormData({ ...formData, direccion: e.target.value })}
            />
          </div>
          <div>
            <label className="block text-sm font-medium">Capacidad</label>
            <input
              type="number"
              className="w-full p-2 border rounded"
              value={formData.capacidad}
              onChange={(e) => setFormData({ ...formData, capacidad: parseInt(e.target.value) })}
            />
          </div>
          <div>
            <label className="block text-sm font-medium">Tipo de Habitación</label>
            <select
              className="w-full p-2 border rounded"
              value={formData.idTipoHabitacion}
              onChange={(e) => setFormData({ ...formData, idTipoHabitacion: parseInt(e.target.value) })}
            >
              {loadingTipos ? (
                <option>Cargando tipos de habitación...</option>
              ) : (
                tiposHabitacion.map((tipo) => (
                  <option key={tipo.idTipoHabitacion} value={tipo.idTipoHabitacion}>
                    {tipo.nombreTh}
                  </option>
                ))
              )}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium">Estado de Habitación</label>
            <select
              className="w-full p-2 border rounded"
              value={formData.idEstadoHabitacion}
              onChange={(e) => setFormData({ ...formData, idEstadoHabitacion: parseInt(e.target.value) })}
            >
              {loadingEstados ? (
                <option>Cargando estados de habitación...</option>
              ) : (
                estados.map((estado) => (
                  <option key={estado.idEstadoHabitacion} value={estado.idEstadoHabitacion}>
                    {estado.estado}
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
