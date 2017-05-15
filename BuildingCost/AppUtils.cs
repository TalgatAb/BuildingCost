using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace BuildingCost
{
   public class AppUtils
   {
      // Тип пользователя
      // utype_person = 1 - Частное лицо
      // utype_company  = 2 - Компания
      [Flags]
      public enum uTypes : int { utype_person = 1, utype_company = 2 };


      static String connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

      /// <summary>
      /// Лог журнал ошибки
      /// </summary>
      /// <param name="errorNumber">Номер ошибки</param>
      /// <param name="errorProcedure">Имя программы</param>
      /// <param name="errorMessage">Сообщение об ошибке</param>
      /// <param name="userName">Пользователь</param>
      /// <param name="errorLine">Номер строки</param>
      /// <param name="errorSeverity">Важность</param>
      /// <param name="errorState">Состояние</param>
      /// <param name="errorLogId">ИД записи</param>
      public static void AddErrorLog(int errorNumber, string errorProcedure, string errorMessage, string userName,
         out int errorLogId, int errorLine = -1, int errorSeverity = -1, int errorState = -1)
      {
         errorLogId = 0;

         if (errorNumber == -2147467259) return;

         string unescapeErrMsg = errorMessage;

         try
         {
            unescapeErrMsg = Regex.Unescape(errorMessage);
         }
         catch { };

         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.StoredProcedure;
               cmd.CommandText = "AddErrorLog";
               cmd.Parameters.Add("@errorNumber", SqlDbType.Int).Value = errorNumber;
               cmd.Parameters.Add("@errorProcedure", SqlDbType.NVarChar, 126).Value = errorProcedure;
               cmd.Parameters.Add("@errorMessage", SqlDbType.NVarChar, 4000).Value = unescapeErrMsg;
               cmd.Parameters.Add("@userName", SqlDbType.NVarChar, 50).Value = userName;
               cmd.Parameters.Add("@errorLine", SqlDbType.Int).Value = errorLine;
               cmd.Parameters.Add("@errorSeverity", SqlDbType.Int).Value = errorSeverity;
               cmd.Parameters.Add("@errorState", SqlDbType.Int).Value = errorState;
               cmd.Parameters.Add("@errorLogId", SqlDbType.Int).Value = 0;
               cmd.ExecuteNonQuery();
               errorLogId = cmd.Parameters["@errorLogId"].Value as int? ?? 0;
            }
         }
      }

      public string GetCounters(DateTime cur_date, Int16 obj_id, int branch)
      {
         string result = string.Empty;
         var period = new DateTime(cur_date.Year, 1, 1);
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.StoredProcedure;
               cmd.CommandText = "dbo.GetCounters";
               cmd.Parameters.Add("@period", SqlDbType.Date).Value = period;
               cmd.Parameters.Add("@obj_id", SqlDbType.SmallInt).Value = obj_id;
               cmd.Parameters.Add("@branch", SqlDbType.Int).Value = branch;

               result = cmd.ExecuteScalar()?.ToString();
            }
         }
         return result;
      }

      public string GetCountersTmp(DateTime cur_date, Int16 obj_id, int branch)
      {
         string result = string.Empty;
         var period = new DateTime(cur_date.Year, 1, 1);
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.StoredProcedure;
               cmd.CommandText = "dbo.GetCountersTmp";
               cmd.Parameters.Add("@period", SqlDbType.Date).Value = period;
               cmd.Parameters.Add("@obj_id", SqlDbType.SmallInt).Value = obj_id;
               cmd.Parameters.Add("@branch", SqlDbType.Int).Value = branch;

               result = cmd.ExecuteScalar()?.ToString();
            }
         }
         return result;
      }

      public int GetNextValue(string seq_name)
      {
         int result = 0;
         using (SqlConnection cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (SqlCommand cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.StoredProcedure;
               cmd.CommandText = "SeqGetNextValue";
               cmd.Parameters.Add("@seq_name", SqlDbType.NVarChar, 50).Value = seq_name;
               result = cmd.ExecuteScalar() as int? ?? 0;
            }
         }
         return result;
      }

      public int GetCurrentDepId(string _userId)
      {
         int result = 0;
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandText = "SELECT u.dep_id FROM dbo.UsersInfo u WHERE u.usr_id = @usr_id";
               cmd.Parameters.Add("@usr_id", SqlDbType.NVarChar, 128).Value = _userId;
               result = cmd.ExecuteScalar() as int? ?? 0;
            }
         }
         return result;
      }

      public string GetModelName(int model_id = 0)
      {
         string result = "";
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.Text;
               cmd.CommandText = "SELECT dbo.GetModelName(@model_id)";
               cmd.Parameters.Add("@model_id", SqlDbType.Int).Value = model_id;
               result = cmd.ExecuteScalar() as string ?? string.Empty;
            }
         }
         return result;
      }

      public string GetTransName(int trans_id = 0)
      {
         string result = "";
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.Text;
               cmd.CommandText = "SELECT dbo.GetTransName(@trans_id)";
               cmd.Parameters.Add("@trans_id", SqlDbType.Int).Value = trans_id;
               result = cmd.ExecuteScalar() as string ?? string.Empty;
            }
         }
         return result;
      }

      public int GetMaxCalcPeriod(int model_id = 0)
      {
         int result = 0;
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.Text;
               cmd.CommandText = "SELECT dbo.GetMaxCalcPeriod(@model_id)";
               cmd.Parameters.Add("@model_id", SqlDbType.Int).Value = model_id;
               result = cmd.ExecuteScalar() as int? ?? 0;
            }
         }
         return result;
      }

      public int GetTransMaxCalcPeriod(int trans_id = 0)
      {
         int result = 0;
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.Text;
               cmd.CommandText = "SELECT dbo.GetTransMaxCalcPeriod(@trans_id)";
               cmd.Parameters.Add("@trans_id", SqlDbType.Int).Value = trans_id;
               result = cmd.ExecuteScalar() as int? ?? 0;
            }
         }
         return result;
      }

      public string GetUnitName(int unit_id = 0)
      {
         string result = "";
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.Text;
               cmd.CommandText = "SELECT dbo.GetUnitName(@unit_id)";
               cmd.Parameters.Add("@unit_id", SqlDbType.Int).Value = unit_id;
               result = cmd.ExecuteScalar() as string ?? string.Empty;
            }
         }
         return result;
      }

      //@model_id int,
      //@max_period int,
      //@usr_name nvarchar(50),
      //@dep_id smallint = 2,
      //@success int = 0 out
      public int CreatePassToPeriod(int model_id, int max_period, string usr_name, int dep_id)
      {
         int result = 0;
         using (var cnn = new SqlConnection(connectionString))
         {
            cnn.Open();
            using (var cmd = cnn.CreateCommand())
            {
               cmd.CommandType = CommandType.StoredProcedure;
               cmd.CommandText = "CreatePassToPeriod";
               cmd.Parameters.Add("@model_id", SqlDbType.Int).Value = model_id;
               cmd.Parameters.Add("@max_period", SqlDbType.Int).Value = max_period;
               cmd.Parameters.Add("@usr_name", SqlDbType.NVarChar, 50).Value = usr_name;
               cmd.Parameters.Add("@dep_id", SqlDbType.Int).Value = dep_id;
               cmd.Parameters.Add("@success", SqlDbType.Int).Value = 0;
               cmd.ExecuteNonQuery();
               result = cmd.Parameters["@success"].Value as int? ?? 0;
            }
         }
         return result;
      }
   }
}