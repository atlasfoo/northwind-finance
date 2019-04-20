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
    public partial class RFdlg : Form
    {
        private int rf;

        public RFdlg()
        {
            InitializeComponent();
        }

        public int Rf { get => rf; set => rf = value; }

        private void RFdlg_Load(object sender, EventArgs e)
        {
            switch (rf)
            {
                case 1:
                    {
                        label1.Text = "Capital neto";
                        break;
                    }
                case 2:
                    {
                        label1.Text = "Razon circulante";
                        break;
                    }
                case 3:
                    {
                        label1.Text = "Prueba Acida";
                        break;
                    }

            }
        }
    }
}
