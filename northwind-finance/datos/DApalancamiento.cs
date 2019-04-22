using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;


namespace northwind_finance.datos
{
    class DApalancamiento
    {
        public DataTable Apal(int noAcciones)
        {
            DataTable dataApal = new DataTable("Apalancamientos");
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon.ConnectionString = Conexion.Cn;
                SqlCommand SqlCmd = new SqlCommand();
                SqlCmd.Connection = SqlCon;
                SqlCmd.CommandText = "sp_Apalancamiento";
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter SqlDat = new SqlDataAdapter(SqlCmd);
                SqlDat.Fill(dataApal);

                SqlParameter ParDato1 = new SqlParameter();
                ParDato1.ParameterName = "@No_acciones";
                ParDato1.SqlDbType = SqlDbType.Int;
                ParDato1.Value = noAcciones;
                SqlCmd.Parameters.Add(ParDato1);

            }
            catch (Exception ex)
            {
                dataApal = null;
            }
            return dataApal;
        }
    }
}
