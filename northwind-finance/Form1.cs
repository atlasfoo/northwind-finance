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
            RFdlg dlg = new RFdlg();
            dlg.Rf = 1;
            dlg.ShowDialog();
        }

        private void rToolStripMenuItem_Click(object sender, EventArgs e)
        {
            RFdlg dlg = new RFdlg();
            dlg.Rf = 2;
            dlg.ShowDialog();
        }

        private void razónRápidaOPruebaDelÁcidoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            RFdlg dlg = new RFdlg();
            dlg.Rf = 3;
            dlg.ShowDialog();
        }
    }
}
