namespace northwind_finance.Vista
{
    partial class Estado_Resultados
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.dataER = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dataER)).BeginInit();
            this.SuspendLayout();
            // 
            // dataER
            // 
            this.dataER.AllowUserToAddRows = false;
            this.dataER.AllowUserToDeleteRows = false;
            this.dataER.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dataER.DefaultCellStyle = dataGridViewCellStyle1;
            this.dataER.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataER.Location = new System.Drawing.Point(0, 0);
            this.dataER.Name = "dataER";
            this.dataER.ReadOnly = true;
            this.dataER.Size = new System.Drawing.Size(697, 493);
            this.dataER.TabIndex = 0;
            this.dataER.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataER_CellContentClick);
            // 
            // Estado_Resultados
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(697, 493);
            this.Controls.Add(this.dataER);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Name = "Estado_Resultados";
            this.Text = "Estado de resultados";
            this.Load += new System.EventHandler(this.Estado_Resultados_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataER)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataER;
    }
}