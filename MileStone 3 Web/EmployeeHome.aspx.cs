using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class EmployeeHome : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                Type.Items.Insert(0, new ListItem("All", "All"));
                Type.Items.Insert(1, new ListItem("Academic", "academic"));
                Type.Items.Insert(2, new ListItem("Industrial", "industrial"));

                // BindDropDownList();
                Type.SelectedValue = "All";
                displayTable();
            }

        }
    }
}