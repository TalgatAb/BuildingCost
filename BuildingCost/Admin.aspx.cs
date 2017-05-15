using BuildingCost.Models;
using DevExpress.Web.Bootstrap;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuildingCost
{
   public partial class Admin : System.Web.UI.Page
   {
      int errorLogId = 0;

      protected void Page_Load(object sender, EventArgs e)
      {

      }

      protected void UsersGridView_CustomErrorText(object sender, DevExpress.Web.ASPxGridViewCustomErrorTextEventArgs e)
      {
         e.ErrorText = e.Exception.Message;
         var lineNumber = new System.Diagnostics.StackTrace(e.Exception, true).GetFrame(0).GetFileLineNumber();
         AppUtils.AddErrorLog(e.Exception.HResult, e.Exception.Source, $"{e.Exception.Message} - {e.Exception.StackTrace}",
            Context.User.Identity.GetUserName(), out errorLogId, lineNumber, -1, -1);
      }

      protected void UsersGridView_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
      {
         BootstrapGridView grid = sender as BootstrapGridView;
         var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
         var user = manager.FindById(e.Keys["Id"].ToString());
         grid.CancelEdit();
         e.Cancel = true;
         if (user != null)
         {
            IdentityResult result = manager.Delete(user);
            if (!result.Succeeded)
               throw new Exception(result.Errors.FirstOrDefault());
         }
         grid.DataBind();
      }

      protected void UsersGridView_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
      {
         BootstrapGridView grid = sender as BootstrapGridView;
         var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
         var user = new ApplicationUser() { UserName = e.NewValues["Email"].ToString(), Email = e.NewValues["Email"].ToString(), PhoneNumber = e.NewValues["PhoneNumber"]?.ToString() ?? string.Empty };
         IdentityResult result = manager.Create(user, "password123");
         grid.CancelEdit();
         e.Cancel = true;
         if (!result.Succeeded)
            throw new Exception(result.Errors.FirstOrDefault());

         grid.DataBind();
      }

      protected void UsersGridView_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
      {
         BootstrapGridView grid = sender as BootstrapGridView;

         var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
         var user = manager.FindById(e.Keys["Id"].ToString());
         if (user != null)
         {
            user.Email = e.NewValues["Email"].ToString();
            user.PhoneNumber = e.NewValues["PhoneNumber"]?.ToString() ?? string.Empty;
            IdentityResult result = manager.Update(user);
            if (!result.Succeeded)
            {
               grid.CancelEdit();
               e.Cancel = true;
               throw new Exception(result.Errors.FirstOrDefault());
            }
         }
         else
         {
            grid.CancelEdit();
            e.Cancel = true;
         }
         grid.DataBind();
      }

      protected void UsersGridView_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
      {
         BootstrapGridView grid = sender as BootstrapGridView;
         if (e.NewValues["Email"] == null)
            e.Errors[grid.Columns["Email"]] = "Обязательное поле для заполнения!";

         if (e.Errors.Count > 0)
            e.RowError = "Пожалуйста, исправьте все ошибки!";
      }

      protected void RolesGridView_CustomErrorText(object sender, DevExpress.Web.ASPxGridViewCustomErrorTextEventArgs e)
      {
         e.ErrorText = e.Exception.Message;
         var lineNumber = new System.Diagnostics.StackTrace(e.Exception, true).GetFrame(0).GetFileLineNumber();
         AppUtils.AddErrorLog(e.Exception.HResult, e.Exception.Source, $"{e.Exception.Message} - {e.Exception.StackTrace}",
            Context.User.Identity.GetUserName(), out errorLogId, lineNumber, -1, -1);
      }

      protected void RolesGridView_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
      {
         BootstrapGridView grid = sender as BootstrapGridView;

         var context = new ApplicationDbContext();
         var manager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
         var role = manager.FindById(e.Keys["Id"].ToString());
         grid.CancelEdit();
         e.Cancel = true;
         if (role != null)
         {
            IdentityResult result = manager.Delete(role);
            if (!result.Succeeded)
               throw new Exception(result.Errors.FirstOrDefault());

            context.SaveChanges();
         }
         grid.DataBind();
      }

      protected void RolesGridView_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
      {
         BootstrapGridView grid = sender as BootstrapGridView;

         var context = new ApplicationDbContext();
         var manager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
         var role = new IdentityRole(e.NewValues["Name"].ToString());
         IdentityResult result = manager.Create(role);
         grid.CancelEdit();
         e.Cancel = true;
         if (!result.Succeeded)
            throw new Exception(result.Errors.FirstOrDefault());

         context.SaveChanges();
         grid.DataBind();
      }

      protected void RolesGridView_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
      {
         BootstrapGridView grid = sender as BootstrapGridView;

         var context = new ApplicationDbContext();
         var manager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
         var role = manager.FindById(e.Keys["Id"].ToString());
         if (role != null)
         {
            role.Name = e.NewValues["Name"].ToString();
            IdentityResult result = manager.Update(role);
            if (!result.Succeeded)
            {
               grid.CancelEdit();
               e.Cancel = true;
               throw new Exception(result.Errors.FirstOrDefault());
            }
            context.SaveChanges();
         }
         else
         {
            grid.CancelEdit();
            e.Cancel = true;
         }
         grid.DataBind();
      }

      protected void RolesGridView_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
      {
         BootstrapGridView grid = sender as BootstrapGridView;
         if (e.NewValues["Name"] == null)
            e.Errors[grid.Columns["Name"]] = "Обязательное поле для заполнения!";

         if (e.Errors.Count > 0)
            e.RowError = "Пожалуйста, исправьте все ошибки!";
      }

      protected void MUserInRolesGridView_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
      {
         string userId = string.Empty;
         string role = string.Empty;
         string roleId = string.Empty;

         if (e.Parameters.Equals("add"))
         {
            List<Object> userSelectedValues = MUsersGridView.GetSelectedFieldValues("Id");
            List<Object> roleSelectedValues = MRolesGridView.GetSelectedFieldValues("Name");
            if ((userSelectedValues != null && userSelectedValues.Count > 0) && (roleSelectedValues != null && roleSelectedValues.Count > 0))
            {
               var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
               userId = userSelectedValues[0].ToString();
               Session["UserId"] = userId;
               foreach (var item in roleSelectedValues)
               {
                  role = item.ToString();
                  if (!manager.IsInRole(userId, role))
                  {
                     IdentityResult result = manager.AddToRole(userId, role);
                     if (!result.Succeeded)
                        throw new Exception(result.Errors.FirstOrDefault());
                  }
               }
            }
         }
         else if (e.Parameters.Equals("del"))
         {
            List<Object> userSelectedValues = MUsersGridView.GetSelectedFieldValues("Id");
            List<Object> roleSelectedValues = MUserInRolesGridView.GetSelectedFieldValues("RoleId");
            if ((userSelectedValues != null && userSelectedValues.Count > 0) && (roleSelectedValues != null && roleSelectedValues.Count > 0))
            {
               userId = userSelectedValues[0].ToString();
               Session["UserId"] = userId;
               var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
               var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(new ApplicationDbContext()));
               foreach (var item in roleSelectedValues)
               {
                  roleId = item.ToString();
                  role = roleManager?.FindById(roleId)?.Name ?? string.Empty;
                  if (manager.IsInRole(userId, role))
                  {
                     IdentityResult result = manager.RemoveFromRole(userId, role);
                     if (!result.Succeeded)
                        throw new Exception(result.Errors.FirstOrDefault());
                  }
               }
            }
         }
         else
         {
            Session["UserId"] = e.Parameters;
         }
         MUserInRolesGridView.DataBind();
      }
   }
}