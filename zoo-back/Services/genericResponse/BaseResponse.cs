using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.genericResponse
{
    public class BaseResponse<T>
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public T? Data { get; set; }

        //CONSTRUCTOR DE RESPUESTA 
        public BaseResponse(T data, bool success, string message)
        {
            Success = success;
            Message = message;
            Data = data;
        }

    
    }
}