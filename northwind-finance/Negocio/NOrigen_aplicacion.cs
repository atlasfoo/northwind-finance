using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using northwind_finance.datos;
using System.Data;

namespace northwind_finance.Negocio
{
    class NOrigen_aplicacion
    {
        public static DataTable OYA()
        {
            return new DOrigen_Aplicacion().OYA();
        }
    }
}
