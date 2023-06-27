using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class LecturerHome : System.Web.UI.Page
    {
        protected void Type_SelectedIndexChanged(object sender, EventArgs e)
        {
            displayTable();
        }

        private void displayTable()
        {

            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string type = Type.SelectedValue;

            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand projCom = new SqlCommand("ViewBachelorProjects", conn);
                projCom.CommandType = CommandType.StoredProcedure;
                if (type == "academic")
                {
                    projCom.Parameters.Add(new SqlParameter("@ProjectType", type));
                }
                else if (type == "industrial")
                {
                    projCom.Parameters.Add(new SqlParameter("@ProjectType", "industrial"));
                }
                else
                {
                    projCom.Parameters.Add(new SqlParameter("@ProjectType", DBNull.Value));
                }
                projCom.Parameters.Add(new SqlParameter("@User_id", c));

                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(projCom);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                StringBuilder sb = new StringBuilder();
                sb.Append("<center>");
                sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:#ffffff>");
                sb.Append("<tr>");
                foreach (DataColumn dc in dt.Columns)
                {
                    sb.Append("<th style=color:#00ffff>");
                    sb.Append(dc.ColumnName.ToUpper());
                    sb.Append("</th>");

                }
                sb.Append("</tr>");

                foreach (DataRow dr in dt.Rows)
                {
                    sb.Append("<tr>");
                    foreach (DataColumn dc in dt.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(dr[dc.ColumnName].ToString());
                        sb.Append("</th>");

                    }
                    sb.Append("</tr>");
                }
                sb.Append("</table>");
                sb.Append("</center>");
                Panel2.Controls.Add(new Label { Text = sb.ToString() });
                conn.Close();
            }
        }


        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {


                Type.SelectedValue = "All";
            }


        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
            }
            SqlCommand cmd = new SqlCommand();
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                cmd.CommandText = "IF EXISTS (SELECT * FROM Lecturer WHERE Lecturer_id = @Lecturer_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@Lecturer_id", c);
                cmd.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    int output = (int)result;
                    if (output != 1)
                    {
                        Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }
                }
                conn2.Close();
            }
            if (!Page.IsPostBack)
            {

                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = System.Data.CommandType.Text;
                command.CommandText = "SELECT Industrial_code FROM Industrial WHERE L_id IS NULL";
                Type.Items.Insert(0, new ListItem("All", "All"));
                Type.Items.Insert(1, new ListItem("Academic", "academic"));
                Type.Items.Insert(2, new ListItem("Industrial", "industrial"));

                // BindDropDownList();
                Type.SelectedValue = "All";
                displayTable();

                conn.Open();
                DropDownList.DataSource = command.ExecuteReader();
                DropDownList.DataTextField = "Industrial_code";
                DropDownList.DataBind();
                DropDownList.Items.Insert(0, new ListItem("None", "None"));
                DropDownList.SelectedValue = "None";
                conn.Close();

            }
        }

        protected void SuperviseProject(object sender, EventArgs e)
        {
            if (DropDownList.SelectedValue != "None")
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand command = new SqlCommand("SuperviseIndustrial", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter param = (SqlParameter)Session["user"];
                int L_id = (int)param.Value;

                command.Parameters.Add(new SqlParameter("@Lecturer_id", L_id));
                command.Parameters.Add(new SqlParameter("@proj_code", DropDownList.SelectedValue));

                conn.Open();
                command.ExecuteNonQuery();
                conn.Close();

                addedSuccessfully.Text = "You now supervise the project with code " + DropDownList.SelectedValue + "!";
                addedSuccessfully.ForeColor = System.Drawing.Color.Green;
                addedSuccessfully.Visible = true;

                command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = System.Data.CommandType.Text;
                command.CommandText = "SELECT Industrial_code FROM Industrial WHERE L_id IS NULL";


                conn.Open();
                DropDownList.DataSource = command.ExecuteReader();
                DropDownList.DataTextField = "Industrial_code";
                DropDownList.DataBind();
                DropDownList.Items.Insert(0, new ListItem("None", "None"));
                DropDownList.SelectedValue = "None";
                conn.Close();
            }
            else {
                addedSuccessfully.Text = "You have to select a project first :<";
                addedSuccessfully.ForeColor = System.Drawing.Color.Red;
                addedSuccessfully.Visible = true;
            }
        }

        protected void DropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            addedSuccessfully.Visible = false;
        }
    }
}