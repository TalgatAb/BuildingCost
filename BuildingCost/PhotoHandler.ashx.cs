using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace BuildingCost
{
   /// <summary>
   /// Сводное описание для PhotoHandler
   /// </summary>
   public class PhotoHandler : IHttpHandler, IRequiresSessionState
   {

      public void ProcessRequest(HttpContext context)
      {
         byte[] b = null;
         int ads_photo_id = int.TryParse(context.Request.QueryString["ads_photo_id"].ToString(), out int result) ? result : 0;
         List<AdvertPhoto> photoList = (List<AdvertPhoto>)HttpContext.Current.Session["photo_url"];
         var photo = photoList.Where(item => item.ads_photo_id == ads_photo_id).Select(item => item.photo);
         var e = photo.GetEnumerator();
         while (e.MoveNext())
         {
            b = (byte[])e.Current;
         }
         context.Response.OutputStream.Write(b, 0, b.Length);
         context.Response.Flush();
      }

      public bool IsReusable
      {
         get
         {
            return false;
         }
      }
   }
}