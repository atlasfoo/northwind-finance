using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using northwind_finance.datos;
using System.Data;


namespace northwind_finance.Negocio
{
    class NEstado_Resultado
    {
        public static DataTable ER()
        {
            return new DEstado_Resultado().ER();
        }
    }
}
