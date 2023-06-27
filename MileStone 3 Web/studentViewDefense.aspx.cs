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
    public partial class studentViewDefense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
            }

            SqlCommand cmd45 = new SqlCommand();
            SqlParameter param45 = (SqlParameter)Session["user"];
            int c45 = (int)param45.Value;
            string connStr45 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn45 = new SqlConnection(connStr45))
            {
                cmd45.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid) SELECT 1 ELSE SELECT 0";
                cmd45.Parameters.AddWithValue("@sid", c45);
                cmd45.Connection = conn45;
                conn45.Open();
                // Execute the query and get the result
                object result45 = cmd45.ExecuteScalar();
                if (result45 != null && result45 != DBNull.Value)
                {
                    int output = (int)result45;
                    if (output != 1)
                    {
                        Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }
                }
                conn45.Close();
            }


            SqlCommand cmd = new SqlCommand();
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                cmd.CommandText = "IF EXISTS (SELECT * FROM Defense WHERE sid = @c) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@c", c);
                cmd.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    int output = (int)result;
                    if (output != 1)
                    {
                        Label1.Text = "You don't have a defense yet";
                        Label1.Visible = true;
                        OK.Visible = false;
                    }

                    else
                    {
                        conn2.Close();

                        Label1.Visible = false;
                        OK.Visible = true;

                        SqlCommand ViewDefense = new SqlCommand();
                        ViewDefense.CommandText = "ViewMyDefense";  // Name of the stored procedure
                        ViewDefense.Connection = conn2;
                        ViewDefense.CommandType = CommandType.StoredProcedure;
                        ViewDefense.Parameters.AddWithValue("@sid", c);

                        conn2.Open();
                        SqlDataAdapter sda = new SqlDataAdapter(ViewDefense);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        StringBuilder sb = new StringBuilder();
                        sb.Append("<center>");
                        sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:white>");
                        sb.Append("<tr>");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("ID");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("Location");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("Content");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("Time");
                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("Date");
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
                        conn2.Close();
                    }

                } 
            }
        }
    }
}