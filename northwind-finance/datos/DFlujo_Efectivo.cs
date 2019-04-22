using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace northwind_finance.datos
{
    class DFlujo_Efectivo
    {
        public DataTable FE()
        {
            DataTable dataFE = new DataTable("Flujo de efectivo");
            SqlConnection SqlCon = new SqlConnection();
            try
            {
                SqlCon.ConnectionString = Conexion.Cn;
                SqlCommand SqlCmd = new SqlCommand();
                SqlCmd.Connection = SqlCon;
                SqlCmd.CommandText = "sp_Flujo_Efectivo";
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter SqlDat = new SqlDataAdapter(SqlCmd);
                SqlDat.Fill(dataFE);

            }
            catch (Exception ex)
            {
                dataFE = null;
            }
            return dataFE;
        }
    }
}
