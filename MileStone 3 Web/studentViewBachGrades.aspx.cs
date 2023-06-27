using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class studentViewBachGrades : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid AND TotalBachelorGrade > 00.00) SELECT 1 ELSE SELECT 0";
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
                        grade.ForeColor = System.Drawing.Color.Red;

                        grade.Text = "Your grade hasn't been posted yet";
                        grade.Visible = true;
                        OK.Visible = false;
                        // Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }



                    else
                    {
                        grade.Visible = false;
                        OK.Visible = true;
                        conn2.Close();
                        SqlCommand ViewMyBachelorProjectGrade = new SqlCommand();
                        ViewMyBachelorProjectGrade.CommandText = "ViewMyBachelorProjectGrade";  // Name of the stored procedure
                        ViewMyBachelorProjectGrade.Connection = conn2;
                        ViewMyBachelorProjectGrade.CommandType = CommandType.StoredProcedure;
                        ViewMyBachelorProjectGrade.Parameters.AddWithValue("@sid", c);

                        conn2.Open();


                        SqlDataAdapter sda = new SqlDataAdapter(ViewMyBachelorProjectGrade);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        StringBuilder sb = new StringBuilder();
                        sb.Append("<center>");
                        sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:white>");
                        sb.Append("<tr>");


                        sb.Append("<th style=color:#00ffff>");
                        sb.Append("Total Bachelor Grade");
                        sb.Append("</th>");
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
                        Double Bg = Convert.ToDouble(dt.Rows[0][0]);
                        if (Bg != 0.00)
                        {
                            Panel3.Controls.Add(new System.Web.UI.WebControls.Label { Text = sb.ToString() });
                        }
                        else
                        {
                            grade.ForeColor = System.Drawing.Color.Red;
                            grade.Text = "Your grade has't been posted yet";
                        }


                        conn2.Close();
                    }
                }
            }
        }
    }
}