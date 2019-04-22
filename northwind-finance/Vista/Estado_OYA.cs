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
    public partial class Estado_OYA : Form
    {
        public Estado_OYA()
        {
            InitializeComponent();
        }

        private void Mostrar()
        {
            this.dataOYA.DataSource = NOrigen_aplicacion.OYA();
        }

        private void Estado_OYA_Load(object sender, EventArgs e)
        {

        }
    }
}
