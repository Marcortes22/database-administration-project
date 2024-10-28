using Entities;
using Services.AnimalService.Dto;
using Services.ControlAnimalService.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.ControlAnimalService
{
    public interface ISvControlAnimal
    {
        Task<BaseResponse<ControlAnimal>> newControlAnimalTask(CreateControlAnimalDto controlAnimalDto, int cedulaCreador);
    }
}
