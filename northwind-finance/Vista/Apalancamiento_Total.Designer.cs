namespace Finanzas_Kate.Vista
{
    partial class Apalancamiento_Total
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
            this.dataApal = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.txtacciones = new System.Windows.Forms.TextBox();
            this.btnacciones = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataApal)).BeginInit();
            this.SuspendLayout();
            // 
            // dataApal
            // 
            this.dataApal.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataApal.Location = new System.Drawing.Point(189, 0);
            this.dataApal.Name = "dataApal";
            this.dataApal.Size = new System.Drawing.Size(508, 493);
            this.dataApal.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(50, 54);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(86, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "No de Acciones:";
            // 
            // txtacciones
            // 
            this.txtacciones.Location = new System.Drawing.Point(45, 82);
            this.txtacciones.Name = "txtacciones";
            this.txtacciones.Size = new System.Drawing.Size(100, 20);
            this.txtacciones.TabIndex = 2;
            // 
            // btnacciones
            // 
            this.btnacciones.Location = new System.Drawing.Point(58, 136);
            this.btnacciones.Name = "btnacciones";
            this.btnacciones.Size = new System.Drawing.Size(75, 23);
            this.btnacciones.TabIndex = 3;
            this.btnacciones.Text = "Visualizar";
            this.btnacciones.UseVisualStyleBackColor = true;
            this.btnacciones.Click += new System.EventHandler(this.btnacciones_Click);
            // 
            // Apalancamiento_Total
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(697, 493);
            this.Controls.Add(this.btnacciones);
            this.Controls.Add(this.txtacciones);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dataApal);
            this.Name = "Apalancamiento_Total";
            this.Text = "Apalancamiento total";
            ((System.ComponentModel.ISupportInitialize)(this.dataApal)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataApal;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtacciones;
        private System.Windows.Forms.Button btnacciones;
    }
}