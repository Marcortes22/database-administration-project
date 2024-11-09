// Components/HistorialMovimientosTable.tsx
'use client';
import { HistorialMovimientos } from '@/Types/next-auth-types/HistorialMovimientos';
import React from 'react';

interface HistorialMovimientosProps {
    data: HistorialMovimientos[];
}

export default function HistorialMovimientosTable({ data }: HistorialMovimientosProps) {
    return (
        <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
            <h2 className="text-2xl font-bold text-gray-700 mb-6">Historial de Movimientos</h2>
            <table className="w-full text-left text-gray-500">
                <thead className="bg-gray-50">
                    <tr className="text-gray-700 uppercase text-sm">
                        <th className="px-6 py-3 text-center">Nombre del Animal</th>
                        <th className="px-6 py-3 text-center">Fecha</th>
                        <th className="px-6 py-3 text-center">Habitación Anterior</th>
                        <th className="px-6 py-3 text-center">Habitación Actual</th>
                        <th className="px-6 py-3 text-center">Motivo</th>
                    </tr>
                </thead>
                <tbody>
                    {data.map((item, index) => (
                        <tr key={index} className="border-b hover:bg-gray-100">
                            <td className="px-6 py-4 text-center">{item.nombreAnimal}</td>
                            <td className="px-6 py-4 text-center">{item.fecha}</td>
                            <td className="px-6 py-4 text-center">{item.habitacionAnterior}</td>
                            <td className="px-6 py-4 text-center">{item.habitacionActual}</td>
                            <td className="px-6 py-4 text-center">{item.motivo}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}
