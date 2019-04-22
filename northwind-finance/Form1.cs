using northwind_finance.Vista;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using Finanzas_Kate.Vista;

namespace northwind_finance
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void capitalDeTrabajoNetoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            openRF(1);
        }

        private void rToolStripMenuItem_Click(object sender, EventArgs e)
        {
            openRF(2);
        }

        private void razónRápidaOPruebaDelÁcidoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            openRF(3);
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            
        }

        private void totalToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Apalancamiento_Total dlg = new Apalancamiento_Total();
            dlg.ShowDialog();
        }

        private void mostrarEstadoDeOrigenYAplicaciónToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Estado_OYA dlg = new Estado_OYA();
            dlg.ShowDialog();
        }

        private void openRF(int r)
        {
            RFdlg dlg = new RFdlg();
            dlg.Rf = r;
            dlg.ShowDialog();
        }

        private void balanceGeneralToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Balance_General dlg = new Balance_General();
            dlg.ShowDialog();
        }

        private void estadoDeResultadosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Estado_Resultados dlg = new Estado_Resultados();
            dlg.ShowDialog();
        }

        private void mostraToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FlujoE_Directo dlg = new FlujoE_Directo();
            dlg.ShowDialog();
        }

        private void agregarVentaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Operacion_Venta dlg = new Operacion_Venta();
            dlg.ShowDialog();
        }
    }
}
