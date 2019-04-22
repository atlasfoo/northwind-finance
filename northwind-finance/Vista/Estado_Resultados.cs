using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using northwind_finance.Negocio;

namespace northwind_finance.Vista
{
    public partial class Estado_Resultados : Form
    {
        public Estado_Resultados()
        {
            InitializeComponent();
        }

        private void Mostrar()
        {
            this.dataER.DataSource = NEstado_Resultado.ER();
        }
    }
}
