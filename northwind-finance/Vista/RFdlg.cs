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

        public void msgerr(string msg)
        {
            MessageBox.Show(this, msg, "Sistema Financiero", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void RFdlg_Load(object sender, EventArgs e)
        {
            switch (rf)
            {
                case 1:
                    {
                        this.Text = "Razón Capital Neto";
                        break;
                    }
                case 2:
                    {
                        this.Text = "Razón Circulante";
                        break;
                    }
                case 3:
                    {
                        this.Text = "Prueba Rápida";
                        break;
                    }
                case 4:
                    {
                        this.Text = "Rotación de inventario Anual";
                        break;
                    }
                case 5:
                    {

                        this.Text = "Rotación de Inventario Mensual";
                        break;
                    }
                case 6:
                    {
                        this.Text = "Rotación de inventario días";
                        break;
                    }
                case 7:
                    {
                        this.Text = "Rotación cuentas por cobrar";
                        break;
                    }
                case 8:
                    {
                        this.Text = "Período promedio de cobro";
                        break;
                    }
                case 9:
                    {
                        this.Text = "Rotación de activos fijos";
                        break;
                    }
                case 10:
                    {
                        this.Text = "Rotación de activos totales";
                        break;
                    }
                case 11:
                    {
                        this.Text = "Razón deuda total";
                        break;
                    }
                case 12:
                    {
                        this.Text = "Razón Pasivo a Capital";
                        break;
                    }
                case 13:
                    {
                        this.Text = "Razón Interés a Utilidad";
                        break;
                    }
                case 14:
                    {
                        this.Text = "Margen Utilidad Bruta";
                        break;
                    }
                case 15:
                    {
                        this.Text = "Margen Utilidad Operativa";
                        break;
                    }
                case 16:
                    {
                        this.Text = "Margen Utilidad Neta";
                        break;
                    }
                default:
                    {
                        msgerr("Error interno en la aplicacion");
                        this.Close();
                        break;
                    }
            }
        }
    }
}
