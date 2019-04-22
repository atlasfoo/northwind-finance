using northwind_finance.Negocio;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace northwind_finance.Vista
{
    public partial class FlujoE_Directo : Form
    {
        public FlujoE_Directo()
        {
            InitializeComponent();
        }

        private void FlujoE_Directo_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = NFlujo_Efectivo.FE();
            dataGridView1.Columns[0].Visible = false;
        }
    }
}
