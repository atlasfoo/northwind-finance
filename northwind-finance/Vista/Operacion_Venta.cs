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
    public partial class Operacion_Venta : Form
    {
        public Operacion_Venta()
        {
            InitializeComponent();
        }

        private void numericUpDown2_ValueChanged(object sender, EventArgs e)
        {

        }
        public void msgerr(string msg)
        {
            MessageBox.Show(this, msg, "Sistema Financiero", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
        private void Operacion_Venta_Load(object sender, EventArgs e)
        {
            try
            {
                ordDGV.DataSource = NVentas.Ords();
                prodDGV.DataSource = NVentas.Prods();
            }catch(Exception ex)
            {
                msgerr(ex.Message);
            }
        }
    }
}
