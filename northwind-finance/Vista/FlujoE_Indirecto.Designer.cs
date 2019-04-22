namespace northwind_finance.Vista
{
    partial class FlujoE_Indirecto
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
            this.dataFEI = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dataFEI)).BeginInit();
            this.SuspendLayout();
            // 
            // dataFEI
            // 
            this.dataFEI.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataFEI.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataFEI.Location = new System.Drawing.Point(0, 0);
            this.dataFEI.Name = "dataFEI";
            this.dataFEI.Size = new System.Drawing.Size(697, 493);
            this.dataFEI.TabIndex = 0;
            // 
            // FlujoE_Indirecto
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(697, 493);
            this.Controls.Add(this.dataFEI);
            this.Name = "FlujoE_Indirecto";
            this.Text = "Flujo de efectivo indirecto";
            ((System.ComponentModel.ISupportInitialize)(this.dataFEI)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataFEI;
    }
}