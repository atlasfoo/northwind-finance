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
    public partial class Balance_General : Form
    {
        public Balance_General()
        {
            InitializeComponent();
        }

        private void Mostrar()
        {
            this.dataBD.DataSource = NBalance_General.BG();
            dataBD.Columns[0].Visible = false;
        }

        private void Balance_General_Load(object sender, EventArgs e)
        {
            Mostrar();
        }
    }
}
