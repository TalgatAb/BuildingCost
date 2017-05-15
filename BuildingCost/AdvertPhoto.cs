using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BuildingCost
{
   public class AdvertPhoto
   {
      public int ads_photo_id { get; set; }
      public int ads_id { get; set; }
      public string file_name { get; set; }
      public byte[] photo { get; set; }
      public string url { get; set; }
   }
}