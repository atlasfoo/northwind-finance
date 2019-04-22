using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using northwind_finance.datos;
using System.Data;

namespace northwind_finance.Negocio
{
    class NFlujo_Efectivo
    {
        public static DataTable FE()
        {
            return new DFlujo_Efectivo().FE();
        }
    }
}
