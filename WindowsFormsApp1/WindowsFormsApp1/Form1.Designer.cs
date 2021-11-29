namespace WindowsFormsApp1
{
    partial class Form1
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.tb_learner = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.dt_dategetted = new System.Windows.Forms.DateTimePicker();
            this.cb_result = new System.Windows.Forms.ComboBox();
            this.tb_description = new System.Windows.Forms.TextBox();
            this.tb_course = new System.Windows.Forms.TextBox();
            this.tb_university = new System.Windows.Forms.TextBox();
            this.tb_certificate = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.bt_insert = new System.Windows.Forms.Button();
            this.bt_update = new System.Windows.Forms.Button();
            this.bt_delete = new System.Windows.Forms.Button();
            this.bt_reset = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dataGridView1);
            this.groupBox1.Location = new System.Drawing.Point(3, 13);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1127, 253);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Certificate Infromation";
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(0, 19);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(1121, 228);
            this.dataGridView1.TabIndex = 0;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.tb_learner);
            this.groupBox2.Controls.Add(this.label7);
            this.groupBox2.Controls.Add(this.dt_dategetted);
            this.groupBox2.Controls.Add(this.cb_result);
            this.groupBox2.Controls.Add(this.tb_description);
            this.groupBox2.Controls.Add(this.tb_course);
            this.groupBox2.Controls.Add(this.tb_university);
            this.groupBox2.Controls.Add(this.tb_certificate);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Location = new System.Drawing.Point(3, 272);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(883, 260);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Detail Information";
            // 
            // tb_learner
            // 
            this.tb_learner.Location = new System.Drawing.Point(635, 36);
            this.tb_learner.Name = "tb_learner";
            this.tb_learner.Size = new System.Drawing.Size(156, 20);
            this.tb_learner.TabIndex = 15;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(564, 39);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(57, 13);
            this.label7.TabIndex = 14;
            this.label7.Text = "Learner ID";
            // 
            // dt_dategetted
            // 
            this.dt_dategetted.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dt_dategetted.Location = new System.Drawing.Point(635, 171);
            this.dt_dategetted.Name = "dt_dategetted";
            this.dt_dategetted.Size = new System.Drawing.Size(156, 20);
            this.dt_dategetted.TabIndex = 13;
            this.dt_dategetted.ValueChanged += new System.EventHandler(this.dt_dategetted_ValueChanged);
            // 
            // cb_result
            // 
            this.cb_result.FormattingEnabled = true;
            this.cb_result.Items.AddRange(new object[] {
            "Excellent",
            "Good",
            "Pass"});
            this.cb_result.Location = new System.Drawing.Point(100, 170);
            this.cb_result.Name = "cb_result";
            this.cb_result.Size = new System.Drawing.Size(156, 21);
            this.cb_result.TabIndex = 12;
            // 
            // tb_description
            // 
            this.tb_description.Location = new System.Drawing.Point(100, 224);
            this.tb_description.Name = "tb_description";
            this.tb_description.Size = new System.Drawing.Size(691, 20);
            this.tb_description.TabIndex = 11;
            // 
            // tb_course
            // 
            this.tb_course.Location = new System.Drawing.Point(635, 107);
            this.tb_course.Name = "tb_course";
            this.tb_course.Size = new System.Drawing.Size(156, 20);
            this.tb_course.TabIndex = 9;
            // 
            // tb_university
            // 
            this.tb_university.Location = new System.Drawing.Point(100, 107);
            this.tb_university.Name = "tb_university";
            this.tb_university.Size = new System.Drawing.Size(156, 20);
            this.tb_university.TabIndex = 7;
            // 
            // tb_certificate
            // 
            this.tb_certificate.Location = new System.Drawing.Point(100, 36);
            this.tb_certificate.Name = "tb_certificate";
            this.tb_certificate.Size = new System.Drawing.Size(156, 20);
            this.tb_certificate.TabIndex = 6;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(18, 227);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(60, 13);
            this.label6.TabIndex = 5;
            this.label6.Text = "Description";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(556, 174);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(65, 13);
            this.label5.TabIndex = 4;
            this.label5.Text = "Date Getted";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(567, 110);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(54, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = "Course ID";
            this.label4.Click += new System.EventHandler(this.label4_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(41, 173);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(37, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Result";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(11, 110);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(67, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "University ID";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(10, 39);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(68, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Certificate ID";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // bt_insert
            // 
            this.bt_insert.Location = new System.Drawing.Point(979, 301);
            this.bt_insert.Name = "bt_insert";
            this.bt_insert.Size = new System.Drawing.Size(75, 23);
            this.bt_insert.TabIndex = 2;
            this.bt_insert.Text = "Insert";
            this.bt_insert.UseVisualStyleBackColor = true;
            this.bt_insert.Click += new System.EventHandler(this.bt_insert_Click);
            // 
            // bt_update
            // 
            this.bt_update.Location = new System.Drawing.Point(979, 365);
            this.bt_update.Name = "bt_update";
            this.bt_update.Size = new System.Drawing.Size(75, 23);
            this.bt_update.TabIndex = 3;
            this.bt_update.Text = "Update";
            this.bt_update.UseVisualStyleBackColor = true;
            this.bt_update.Click += new System.EventHandler(this.bt_update_Click);
            // 
            // bt_delete
            // 
            this.bt_delete.Location = new System.Drawing.Point(979, 426);
            this.bt_delete.Name = "bt_delete";
            this.bt_delete.Size = new System.Drawing.Size(75, 23);
            this.bt_delete.TabIndex = 4;
            this.bt_delete.Text = "Delete";
            this.bt_delete.UseVisualStyleBackColor = true;
            this.bt_delete.Click += new System.EventHandler(this.bt_delete_Click);
            // 
            // bt_reset
            // 
            this.bt_reset.Location = new System.Drawing.Point(979, 501);
            this.bt_reset.Name = "bt_reset";
            this.bt_reset.Size = new System.Drawing.Size(75, 23);
            this.bt_reset.TabIndex = 5;
            this.bt_reset.Text = "Reset";
            this.bt_reset.UseVisualStyleBackColor = true;
            this.bt_reset.Click += new System.EventHandler(this.bt_reset_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1134, 549);
            this.Controls.Add(this.bt_reset);
            this.Controls.Add(this.bt_delete);
            this.Controls.Add(this.bt_update);
            this.Controls.Add(this.bt_insert);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "Form1";
            this.Text = "Manage Certificate";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.DateTimePicker dt_dategetted;
        private System.Windows.Forms.ComboBox cb_result;
        private System.Windows.Forms.TextBox tb_description;
        private System.Windows.Forms.TextBox tb_course;
        private System.Windows.Forms.TextBox tb_university;
        private System.Windows.Forms.TextBox tb_certificate;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button bt_insert;
        private System.Windows.Forms.Button bt_update;
        private System.Windows.Forms.Button bt_delete;
        private System.Windows.Forms.Button bt_reset;
        private System.Windows.Forms.TextBox tb_learner;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.DataGridView dataGridView1;
    }
}

