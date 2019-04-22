namespace northwind_finance.Vista
{
    partial class Estado_OYA
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
            this.dataOYA = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dataOYA)).BeginInit();
            this.SuspendLayout();
            // 
            // dataOYA
            // 
            this.dataOYA.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataOYA.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataOYA.Location = new System.Drawing.Point(0, 0);
            this.dataOYA.Name = "dataOYA";
            this.dataOYA.Size = new System.Drawing.Size(697, 493);
            this.dataOYA.TabIndex = 0;
            // 
            // Estado_OYA
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(697, 493);
            this.Controls.Add(this.dataOYA);
            this.Name = "Estado_OYA";
            this.Text = "Estado de origen y aplicación de fondos";
            this.Load += new System.EventHandler(this.Estado_OYA_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataOYA)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataOYA;
    }
}