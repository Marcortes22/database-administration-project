import React from 'react';

interface DeleteModalProps {
  habitacionId: number;
  onClose: () => void; 
  onDelete: () => void; 
  loading: boolean;     
}

export const DeleteModal: React.FC<DeleteModalProps> = ({ habitacionId, onClose, onDelete, loading }) => {
  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
      <div className="bg-white p-6 rounded-lg shadow-lg w-96">
        <h3 className="text-xl font-bold mb-4">Eliminar Habitación</h3>
        <p className="mb-4">¿Estás seguro que deseas eliminar la habitación con ID {habitacionId}?</p>
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
