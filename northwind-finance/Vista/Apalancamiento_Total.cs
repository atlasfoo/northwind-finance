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

namespace Finanzas_Kate.Vista
{
    public partial class Apalancamiento_Total : Form
    {
        public Apalancamiento_Total()
        {
            InitializeComponent();
        }

        private void btnacciones_Click(object sender, EventArgs e)
        {
            this.dataApal.DataSource = NApalancamiento.Apal(Convert.ToInt32(this.txtacciones.Text));
        }
    }
}
