using northwind_finance.datos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace northwind_finance.Negocio
{
    class NVentas
    {
        public static DataTable Prods()
        {
            return new DVentas().Prods();
        }
        public static DataTable Ords()
        {
            return new DVentas().Ords();
        }
    }
}
