using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using northwind_finance.datos;
using System.Data;


namespace northwind_finance.Negocio
{
    class NApalancamiento
    {
        public static DataTable Apal(int noAcciones)
        {
            return new DApalancamiento().Apal(noAcciones);
        }
    }
}
