using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace WindowsFormsApp1
{
   
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-NQFDIC1\_SSI_DSS532;Initial Catalog=ASSIGNMENT2;Integrated Security=True";
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable();

        void loaddata()
        {
            command = connection.CreateCommand();
            command.CommandText = "SELECT Certificate_ID, Learner_ID,First_Name,Last_Name,CE.Course_ID,Course_name,CE.University_ID,University_name,Date_getted,Result,CE.Description FROM CERTIFICATE CE JOIN USERTB US ON CE.Learner_ID = US.User_ID JOIN COURSE CO ON CE.Course_ID = CO.Course_ID JOIN UNIVERSITY UN ON CE.University_ID = UN.University_ID";
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgv.DataSource=table;

        }

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(str);
            connection.Open();
            loaddata();
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void dgv_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            tb_certificate.ReadOnly = true;
            int i;
            i = dgv.CurrentRow.Index;
            tb_certificate.Text = dgv.Rows[i].Cells[0].Value.ToString();
            tb_learner.Text = dgv.Rows[i].Cells[1].Value.ToString();
            tb_course.Text = dgv.Rows[i].Cells[4].Value.ToString();
            tb_university.Text = dgv.Rows[i].Cells[6].Value.ToString();
            dt_dategetted.Text = dgv.Rows[i].Cells[8].Value.ToString();
            cb_result.Text = dgv.Rows[i].Cells[9].Value.ToString();
            tb_description.Text = dgv.Rows[i].Cells[10].Value.ToString();
        }

        private void bt_insert_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "INSERT INTO Certificate values ( '" + tb_certificate.Text + "','" + tb_learner.Text+ "','" + tb_course.Text + "','" + tb_university.Text + "','" + dt_dategetted.Text + "','" + cb_result.Text + "','" + tb_description.Text + " ')";
            command.ExecuteNonQuery();
            loaddata();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void bt_delete_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "DELETE FROM CERTIFICATE WHERE Certificate_ID='"+tb_certificate.Text+ "'";
            command.ExecuteNonQuery();
            loaddata();
        }

        private void bt_update_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "UPDATE CERTIFICATE set Learner_ID='" + tb_learner.Text + "',Course_ID='" + tb_course.Text + "',University_ID='" + tb_university.Text + "',Date_getted='" + dt_dategetted.Text + "',Result='" + cb_result.Text + "',Description='" + tb_description.Text + "' WHERE Certificate_ID='" + tb_certificate.Text + "'";
            command.ExecuteNonQuery();
            loaddata();

        }

        private void bt_reset_Click(object sender, EventArgs e)
        {
            tb_certificate.Text = "";
            tb_learner.Text = "";
            tb_university.Text = "";
            tb_course.Text = "";
            dt_dategetted.Text = "01/01/2021";
            cb_result.Text = "";
            tb_description.Text = "";
        }

        private void dt_dategetted_ValueChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }
    }
}
