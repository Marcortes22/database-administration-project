export interface Dieta {
    idDieta: number;
    nombreDiet: string;
}

export interface Alimento {
    idAlimento: number;
    cantidad: number;
  }
  
  export interface CrearDieta {
    nombreDiet: string;
    alimentos: Alimento[];
  }
  