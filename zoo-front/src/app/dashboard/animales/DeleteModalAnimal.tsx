import React from 'react';

interface DeleteModalAnimalProps {
  animalId: number;
  onClose: () => void; // Función para cerrar el modal
  onDelete: () => void; // Función para confirmar y ejecutar la eliminación
  loading: boolean;     // Estado de carga para mostrar mientras se elimina
}

export const DeleteModalAnimal: React.FC<DeleteModalAnimalProps> = ({ animalId, onClose, onDelete, loading }) => {
  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
      <div className="bg-white p-6 rounded-lg shadow-lg w-96">
        <h3 className="text-xl font-bold mb-4">Eliminar Animal</h3>
        <p className="mb-4">¿Estás seguro que deseas eliminar el animal con ID {animalId}?</p>
        <div className="flex justify-end space-x-2">
          <button
            className="bg-gray-500 text-white px-4 py-2 rounded-full hover:bg-gray-600 transition duration-300"
            onClick={onClose}
          >
            Cancelar
          </button>
          <button
            className="bg-red-500 text-white px-4 py-2 rounded-full hover:bg-red-600 transition duration-300"
            onClick={onDelete}
            disabled={loading}
          >
            {loading ? 'Eliminando...' : 'Eliminar'}
          </button>
        </div>
      </div>
    </div>
  );
};
