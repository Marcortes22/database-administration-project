// Types/HistorialMovimientos.ts

export interface HistorialMovimientos {
    nombreAnimal: string;
    fecha: string;
    habitacionAnterior: string;
    habitacionActual: string;
    motivo: string;
}

export interface HistorialMovimientosAnimal {
    nombreAnimal: string;
    totalMovimientos: number;
}
