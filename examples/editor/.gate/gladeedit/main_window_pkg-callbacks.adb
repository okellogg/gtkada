with System; use System;
with Glib; use Glib;
with Gdk.Event; use Gdk.Event;
with Gdk.Types; use Gdk.Types;
with Gtk.Accel_Group; use Gtk.Accel_Group;
with Gtk.Object; use Gtk.Object;
with Gtk.Enums; use Gtk.Enums;
with Gtk.Style; use Gtk.Style;
with Gtk.Widget; use Gtk.Widget;

package body Main_Window_Pkg.Callbacks is

   use Gtk.Arguments;

   ---------------------------------
   -- On_Main_Window_Delete_Event --
   ---------------------------------

   procedure On_Main_Window_Delete_Event
     (Object : access Gtk_Window_Record'Class;
      Params : Gtk.Arguments.Gtk_Args)
   is
      Arg1 : Gdk_Event := To_Event (Params, 1);
   begin
      null;
   end On_Main_Window_Delete_Event;

   ---------------------
   -- On_New_Activate --
   ---------------------

   procedure On_New_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_New_Activate;

   ----------------------
   -- On_Open_Activate --
   ----------------------

   procedure On_Open_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_Open_Activate;

   ----------------------
   -- On_Save_Activate --
   ----------------------

   procedure On_Save_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_Save_Activate;

   -------------------------
   -- On_Save_As_Activate --
   -------------------------

   procedure On_Save_As_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_Save_As_Activate;

   ----------------------
   -- On_Quit_Activate --
   ----------------------

   procedure On_Quit_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_Quit_Activate;

   ---------------------
   -- On_Cut_Activate --
   ---------------------

   procedure On_Cut_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_Cut_Activate;

   ----------------------
   -- On_Copy_Activate --
   ----------------------

   procedure On_Copy_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_Copy_Activate;

   -----------------------
   -- On_Paste_Activate --
   -----------------------

   procedure On_Paste_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_Paste_Activate;

   ------------------------
   -- On_Delete_Activate --
   ------------------------

   procedure On_Delete_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_Delete_Activate;

   -----------------------
   -- On_About_Activate --
   -----------------------

   procedure On_About_Activate
     (Object : access Gtk_Menu_Item_Record'Class)
   is
   begin
      null;
   end On_About_Activate;

   ---------------------------
   -- On_New_Button_Clicked --
   ---------------------------

   procedure On_New_Button_Clicked
     (Object : access Gtk_Button_Record'Class)
   is
   begin
      null;
   end On_New_Button_Clicked;

   ----------------------------
   -- On_Open_Button_Clicked --
   ----------------------------

   procedure On_Open_Button_Clicked
     (Object : access Gtk_Button_Record'Class)
   is
   begin
      null;
   end On_Open_Button_Clicked;

   ----------------------------
   -- On_Save_Button_Clicked --
   ----------------------------

   procedure On_Save_Button_Clicked
     (Object : access Gtk_Button_Record'Class)
   is
   begin
      null;
   end On_Save_Button_Clicked;

   ---------------------
   -- On_Text_Changed --
   ---------------------

   procedure On_Text_Changed
     (Object : access Gtk_Text_Record'Class)
   is
   begin
      null;
   end On_Text_Changed;

end Main_Window_Pkg.Callbacks;
