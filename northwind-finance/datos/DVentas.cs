using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace northwind_finance.datos
{
    class DVentas
    {
        public DataTable Prods()
        {
            DataTable prods = new DataTable();
            SqlConnection conn = new SqlConnection();
            try
            {
                conn.ConnectionString = Conexion.Cn;
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "sp_showProducts";
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                adp.Fill(prods);
            }
            catch(Exception e)
            {
                throw new Exception("Error de conexión\n" + e.Message);
            }
            return prods;
        }
        public DataTable Ords()
        {
            DataTable ords = new DataTable();
            SqlConnection conn = new SqlConnection();
            try
            {
                conn.ConnectionString = Conexion.Cn;
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "sp_showOrders";
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                adp.Fill(ords);
            }
            catch (Exception e)
            {
                throw new Exception("Error de conexión\n" + e.Message);
            }
            return ords;
        }
    }
}
