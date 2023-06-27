using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class studentViewThesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["user"] == null)
            {
                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
            }
            SqlCommand cmd = new SqlCommand();
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string Title;
            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                cmd.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@sid", c);
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


                SqlCommand Get = new SqlCommand();
                Get.CommandText = "SELECT Title FROM Thesis WHERE sid = @sid";
                Get.Parameters.AddWithValue("@sid", c);
                Get.Connection = conn2;

                SqlCommand T = new SqlCommand();
                T.CommandText = "IF EXISTS (SELECT Title FROM Thesis WHERE sid = @sid ) SELECT 1 ELSE SELECT 0";
                T.Parameters.AddWithValue("@sid", c);


                T.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object resultT = T.ExecuteScalar();
                if (resultT != null && resultT != DBNull.Value)
                {
                    int output = (int)resultT;
                    if (output != 1)
                    {
                        Label1.Text = "You don't have a thesis yet";
                        Label1.Visible = true;
                        OK.Visible = false;

                    }


                    else
                    {

                        Label1.Visible = false;
                        OK.Visible = true;
                        Title = Get.ExecuteScalar().ToString();


                        conn2.Close();



                        SqlCommand ViewThesis = new SqlCommand();
                        ViewThesis.CommandText = "ViewMyThesis";  // Name of the stored procedure
                        ViewThesis.Connection = conn2;
                        ViewThesis.CommandType = CommandType.StoredProcedure;
                        ViewThesis.Parameters.AddWithValue("@sid", c);
                        ViewThesis.Parameters.AddWithValue("@title", Title);


                        conn2.Open();
                        SqlDataAdapter sda = new SqlDataAdapter(ViewThesis);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        StringBuilder sb = new StringBuilder();
                        sb.Append("<center>");
                        sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:white>");
                        sb.Append("<tr>");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("ID");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("Title");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("Deadline");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("PDF Document");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("Grade");


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
                        Panel3.Controls.Add(new System.Web.UI.WebControls.Label { Text = sb.ToString() });
                        OK.Visible = true;
                        conn2.Close();
                    }

                }
            } }
    }
}