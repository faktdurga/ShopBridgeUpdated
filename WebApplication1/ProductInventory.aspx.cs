using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace WebApplication1
{
    public partial class ProductInventory : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        

        protected void Page_Load(object sender, EventArgs e)
        {
           
                //PopulateGrid();
            
            

        }

        //Adding product into inventory

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();      
                }

                SqlCommand cmd = new SqlCommand("Add_Into_Inventory", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim());
                cmd.Parameters.AddWithValue("@Suffix", txtSuffix.Text.Trim());
                cmd.Parameters.AddWithValue("@ManufacturerName",txtManufacturer.Text.Trim());
                cmd.Parameters.AddWithValue("@ModelNumber", txtModel.Text.Trim());
                cmd.Parameters.AddWithValue("@MDate", txtMDate.Text.Trim());
                cmd.Parameters.AddWithValue("@Categories", lstProductCategories.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@MName", txtModelName.Text.Trim());
                cmd.Parameters.AddWithValue("@Cost", txtProductCost.Text.Trim());
                cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text.Trim());
                cmd.Parameters.AddWithValue("@PDescription", txtAddress.Text.Trim());
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script> alert('Product wass added successfully')</script>");

            }
            catch (Exception ex)
            {

                Response.Write("<script> alert('"+ex.Message+"');</script>");
            }

           
        }

        //updating exiting product inventory
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                
                SqlCommand cmd = new SqlCommand("Update_Into_Inventory", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductID", Convert.ToInt32(txtProductID.Text));
                cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim());
                cmd.Parameters.AddWithValue("@Suffix", txtSuffix.Text.Trim());
                cmd.Parameters.AddWithValue("@ManufacturerName", txtManufacturer.Text.Trim());
                cmd.Parameters.AddWithValue("@ModelNumber", txtModel.Text.Trim());
                cmd.Parameters.AddWithValue("@MDate", txtMDate.Text.Trim());
                cmd.Parameters.AddWithValue("@Categories", lstProductCategories.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@MName", txtModelName.Text.Trim());
                cmd.Parameters.AddWithValue("@Cost", txtProductCost.Text.Trim());
                cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text.Trim());
                cmd.Parameters.AddWithValue("@PDescription", txtAddress.Text.Trim());
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Write("<script> alert('Product wass added successfully')</script>");

            }
            catch (Exception ex)
            {

                Response.Write("<script> alert('" + ex.Message + "');</script>");
            }

        }

        //To search product details by Product ID and later we can perform update and delete operations
        protected void btnGO_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if(con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("BindByProductID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductID", Convert.ToInt32(txtProductID.Text));
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                DataTable dt = ds.Tables[0];

                txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                txtSuffix.Text = dt.Rows[0]["Suffix"].ToString();
                txtManufacturer.Text = dt.Rows[0]["ManufacturerName"].ToString();
                txtModel.Text = dt.Rows[0]["ModelNumber"].ToString();
                txtMDate.Text = dt.Rows[0]["ManufacturerDate"].ToString();
                txtModelName.Text = dt.Rows[0]["ModelName"].ToString();
                txtProductCost.Text = dt.Rows[0]["ProductCost"].ToString();
                txtQuantity.Text = dt.Rows[0]["ProductQuantity"].ToString();
                txtAddress.Text = dt.Rows[0]["ProductDescription"].ToString();

            }
            catch (Exception ex)
            {

                Response.Write("<script> alert('" + ex.Message + "');</script>");
            }
        }

        //Display product list on grid

        //public void PopulateGrid()
        //{

        //    try
        //    {
        //        SqlConnection con = new SqlConnection(strcon);
        //        if (con.State == ConnectionState.Closed)
        //        {
        //            con.Open();
        //        }
        //        SqlCommand cmd = new SqlCommand("Select ProductID, ProductName, ProductDescription From Inventory", con);
                
        //        SqlDataAdapter da = new SqlDataAdapter();
        //        da.SelectCommand = cmd;
        //        DataTable dt = new DataTable();
        //        da.Fill(dt);

        //        grdProductList.DataSource = dt;
        //        grdProductList.DataBind();
        //    }
        //    catch (Exception ex)
        //    {

        //        Response.Write("<script> alert('" + ex.Message + "');</script>");
        //    }   
            
          
        //}

        //Delete product from inventory
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("Delete_From_Inventory", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductID", Convert.ToInt32(txtProductID.Text));
                cmd.ExecuteNonQuery();
                Response.Write("<script> alert('Product wass deleted successfully')</script>");


            }
            catch (Exception ex)
            {

                Response.Write("<script> alert('" + ex.Message + "');</script>");
            }

        }


     
    }
}