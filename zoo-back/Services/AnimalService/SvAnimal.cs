using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.AnimalService.Dto;
using Services.EstadoHabitacionService.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.AnimalService
{
    public class SvAnimal : ISvAnimal
    {
        private readonly ZooMaContext myDbContext;

        public SvAnimal(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<Animale>> Create(AnimalCreateDto animalCreateDto, int cedulaCreador)
        {
            try
            {
                var NombreAni = new SqlParameter("@NombreAni", animalCreateDto.NombreAni);
                var EdadAni = new SqlParameter("@EdadAni", animalCreateDto.EdadAni);
                var IdDieta = new SqlParameter("@IdDieta", animalCreateDto.IdDieta);
                var IdHabitacion = new SqlParameter("@IdHabitacion", animalCreateDto.IdHabitacion);
                var IdEspecie = new SqlParameter("@IdEspecie", animalCreateDto.IdEspecie);
                var IdEstadoSalud = new SqlParameter("@IdEstadoSalud", animalCreateDto.IdEstadoSalud);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_ANIMAL @NombreAni,@EdadAni,@IdDieta,@IdHabitacion,@IdEspecie,@IdEstadoSalud ,@Cedula ",
                    NombreAni, EdadAni, IdDieta, IdHabitacion, IdEspecie, IdEstadoSalud, cedula
                );

                return new BaseResponse<Animale>(default, true, "Creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Animale>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Animale>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdAnimal = new SqlParameter("@IdAnimal", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_Animales @IdAnimal, @Cedula",
                    IdAnimal, cedula
                );

                return new BaseResponse<Animale>(default, true, "Eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<Animale>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwAnimale>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwAnimales.ToListAsync();

                return new BaseResponse<List<VwAnimale>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwAnimale>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwAnimale>> GetById(int id)
        {
            try
            {
                var data = myDbContext.VwAnimales.FirstOrDefault(x => x.IdAnimales == id);

                return new BaseResponse<VwAnimale>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwAnimale>(default, false, err.Message);
            }
        }


        public async Task<BaseResponse<Animale>> Update(int id, AnimalUpdateDto animalUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdAnimal = new SqlParameter("@IdAnimal", id);
                var NombreAni = new SqlParameter("@NombreAni", animalUpdateDto.NombreAni);
                var EdadAni = new SqlParameter("@EdadAni", animalUpdateDto.EdadAni);
                var IdDieta = new SqlParameter("@IdDieta", animalUpdateDto.IdDieta);
                var IdEspecie = new SqlParameter("@IdEspecie", animalUpdateDto.IdEspecie);
                var IdEstadoSalud = new SqlParameter("@IdEstadoSalud", animalUpdateDto.IdEstadoSalud);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_ANIMAL @IdAnimal,@NombreAni,@EdadAni,@IdDieta,@IdEspecie,@IdEstadoSalud ,@Cedula ",
                    IdAnimal,NombreAni, EdadAni, IdDieta, IdEspecie, IdEstadoSalud, cedula
                );

                return new BaseResponse<Animale>(default, true, "Actualizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Animale>(default, false, err.Message);
            }
        }
        public async Task<BaseResponse<Animale>> MoveAnimal(int id, MoveAnimalDto moveAnimalDto, int cedulaCreador)
        {
            try
            {
                var IdAnimal = new SqlParameter("@IdAnimal", id);
                var IdHabitacion = new SqlParameter("@IdHabitacion", moveAnimalDto.IdNuevaHabitacion);
                var Motivo = new SqlParameter("@Motivo", moveAnimalDto.motivo);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_MOVER_ANIMAL @IdAnimal,@IdHabitacion,@Motivo ,@Cedula ",
                    IdAnimal, IdHabitacion, Motivo, cedula
                );

                return new BaseResponse<Animale>(default, true, "Actualizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Animale>(default, false, err.Message);
            }
        }
    }
}
