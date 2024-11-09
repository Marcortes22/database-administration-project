// Components/HistorialMovimientosAnimalTable.tsx
'use client';
import { HistorialMovimientosAnimal } from '@/Types/next-auth-types/HistorialMovimientos';
import React from 'react';

interface HistorialMovimientosAnimalProps {
    data: HistorialMovimientosAnimal[];
}

export default function HistorialMovimientosAnimalTable({ data }: HistorialMovimientosAnimalProps) {
    return (
        <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
            <h2 className="text-2xl font-bold text-gray-700 mb-6">Historial de Movimientos por Animal</h2>
            <table className="w-full text-left text-gray-500">
                <thead className="bg-gray-50">
                    <tr className="text-gray-700 uppercase text-sm">
                        <th className="px-6 py-3 text-center">Nombre del Animal</th>
                        <th className="px-6 py-3 text-center">Total de Movimientos</th>
                    </tr>
                </thead>
                <tbody>
                    {data.map((item, index) => (
                        <tr key={index} className="border-b hover:bg-gray-100">
                            <td className="px-6 py-4 text-center">{item.nombreAnimal}</td>
                            <td className="px-6 py-4 text-center">{item.totalMovimientos}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}
