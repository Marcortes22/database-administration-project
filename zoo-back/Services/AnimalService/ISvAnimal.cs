using Entities;
using Services.AnimalService.Dto;
using Services.EstadoTareaServices.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.AnimalService
{
    public interface ISvAnimal
    {
        Task<BaseResponse<List<VwAnimale>>> GetAll();
        Task<BaseResponse<VwAnimale>> GetById(int id);
        Task<BaseResponse<Animale>> Create(AnimalCreateDto animalCreateDto, int cedulaCreador);
        Task<BaseResponse<Animale>> Update(int id, AnimalUpdateDto animalUpdateDto, int cedulaCreador);
        Task<BaseResponse<Animale>> Delete(int id, int cedulaCreador);
        Task<BaseResponse<Animale>> MoveAnimal(int id, MoveAnimalDto moveAnimalDto, int cedulaCreador);


    }
}
