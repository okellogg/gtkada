------------------------------------------------------------------------------
--                                                                          --
--      Copyright (C) 1998-2000 E. Briot, J. Brobecker and A. Charlet       --
--                     Copyright (C) 2000-2012, AdaCore                     --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

pragma Ada_05;
pragma Style_Checks (Off);
pragma Warnings (Off, "*is already use-visible*");
with Glib.Type_Conversion_Hooks; use Glib.Type_Conversion_Hooks;
with Interfaces.C.Strings;       use Interfaces.C.Strings;

package body Gtk.Style_Context is

   function Get_Style_Context
     (Widget : not null access Gtk_Widget_Record'Class)
   return Gtk_Style_Context
   is
      function Internal (Widget : System.Address) return System.Address;
      pragma Import (C, Internal, "gtk_widget_get_style_context");
      Stub_Gtk_Style_Context : Gtk_Style_Context_Record;
   begin
      return Gtk_Style_Context
        (Get_User_Data (Internal (Get_Object (Widget)), Stub_Gtk_Style_Context));
   end Get_Style_Context;

   package Type_Conversion_Gtk_Style_Context is new Glib.Type_Conversion_Hooks.Hook_Registrator
     (Get_Type'Access, Gtk_Style_Context_Record);
   pragma Unreferenced (Type_Conversion_Gtk_Style_Context);

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New (Self : out Gtk_Style_Context) is
   begin
      Self := new Gtk_Style_Context_Record;
      Gtk.Style_Context.Initialize (Self);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
      (Self : not null access Gtk_Style_Context_Record'Class)
   is
      function Internal return System.Address;
      pragma Import (C, Internal, "gtk_style_context_new");
   begin
      Set_Object (Self, Internal);
   end Initialize;

   ---------------
   -- Add_Class --
   ---------------

   procedure Add_Class
      (Self       : not null access Gtk_Style_Context_Record;
       Class_Name : UTF8_String)
   is
      procedure Internal
         (Self       : System.Address;
          Class_Name : Interfaces.C.Strings.chars_ptr);
      pragma Import (C, Internal, "gtk_style_context_add_class");
      Tmp_Class_Name : Interfaces.C.Strings.chars_ptr := New_String (Class_Name);
   begin
      Internal (Get_Object (Self), Tmp_Class_Name);
      Free (Tmp_Class_Name);
   end Add_Class;

   ------------------
   -- Add_Provider --
   ------------------

   procedure Add_Provider
      (Self     : not null access Gtk_Style_Context_Record;
       Provider : Gtk.Style_Provider.Gtk_Style_Provider;
       Priority : Guint)
   is
      procedure Internal
         (Self     : System.Address;
          Provider : Gtk.Style_Provider.Gtk_Style_Provider;
          Priority : Guint);
      pragma Import (C, Internal, "gtk_style_context_add_provider");
   begin
      Internal (Get_Object (Self), Provider, Priority);
   end Add_Provider;

   ----------------
   -- Add_Region --
   ----------------

   procedure Add_Region
      (Self        : not null access Gtk_Style_Context_Record;
       Region_Name : UTF8_String;
       Flags       : Gtk.Enums.Gtk_Region_Flags)
   is
      procedure Internal
         (Self        : System.Address;
          Region_Name : Interfaces.C.Strings.chars_ptr;
          Flags       : Gtk.Enums.Gtk_Region_Flags);
      pragma Import (C, Internal, "gtk_style_context_add_region");
      Tmp_Region_Name : Interfaces.C.Strings.chars_ptr := New_String (Region_Name);
   begin
      Internal (Get_Object (Self), Tmp_Region_Name, Flags);
      Free (Tmp_Region_Name);
   end Add_Region;

   -----------------------
   -- Cancel_Animations --
   -----------------------

   procedure Cancel_Animations
      (Self      : not null access Gtk_Style_Context_Record;
       Region_Id : System.Address)
   is
      procedure Internal (Self : System.Address; Region_Id : System.Address);
      pragma Import (C, Internal, "gtk_style_context_cancel_animations");
   begin
      Internal (Get_Object (Self), Region_Id);
   end Cancel_Animations;

   --------------------------
   -- Get_Background_Color --
   --------------------------

   procedure Get_Background_Color
      (Self  : not null access Gtk_Style_Context_Record;
       State : Gtk.Enums.Gtk_State_Flags;
       Color : out Gdk.RGBA.Gdk_RGBA)
   is
      procedure Internal
         (Self  : System.Address;
          State : Gtk.Enums.Gtk_State_Flags;
          Color : out Gdk.RGBA.Gdk_RGBA);
      pragma Import (C, Internal, "gtk_style_context_get_background_color");
   begin
      Internal (Get_Object (Self), State, Color);
   end Get_Background_Color;

   ----------------
   -- Get_Border --
   ----------------

   procedure Get_Border
      (Self   : not null access Gtk_Style_Context_Record;
       State  : Gtk.Enums.Gtk_State_Flags;
       Border : out Gtk.Style.Gtk_Border)
   is
      procedure Internal
         (Self   : System.Address;
          State  : Gtk.Enums.Gtk_State_Flags;
          Border : out Gtk.Style.Gtk_Border);
      pragma Import (C, Internal, "gtk_style_context_get_border");
   begin
      Internal (Get_Object (Self), State, Border);
   end Get_Border;

   ----------------------
   -- Get_Border_Color --
   ----------------------

   procedure Get_Border_Color
      (Self  : not null access Gtk_Style_Context_Record;
       State : Gtk.Enums.Gtk_State_Flags;
       Color : out Gdk.RGBA.Gdk_RGBA)
   is
      procedure Internal
         (Self  : System.Address;
          State : Gtk.Enums.Gtk_State_Flags;
          Color : out Gdk.RGBA.Gdk_RGBA);
      pragma Import (C, Internal, "gtk_style_context_get_border_color");
   begin
      Internal (Get_Object (Self), State, Color);
   end Get_Border_Color;

   ---------------
   -- Get_Color --
   ---------------

   procedure Get_Color
      (Self  : not null access Gtk_Style_Context_Record;
       State : Gtk.Enums.Gtk_State_Flags;
       Color : out Gdk.RGBA.Gdk_RGBA)
   is
      procedure Internal
         (Self  : System.Address;
          State : Gtk.Enums.Gtk_State_Flags;
          Color : out Gdk.RGBA.Gdk_RGBA);
      pragma Import (C, Internal, "gtk_style_context_get_color");
   begin
      Internal (Get_Object (Self), State, Color);
   end Get_Color;

   -------------------
   -- Get_Direction --
   -------------------

   function Get_Direction
      (Self : not null access Gtk_Style_Context_Record)
       return Gtk.Enums.Gtk_Text_Direction
   is
      function Internal
         (Self : System.Address) return Gtk.Enums.Gtk_Text_Direction;
      pragma Import (C, Internal, "gtk_style_context_get_direction");
   begin
      return Internal (Get_Object (Self));
   end Get_Direction;

   --------------
   -- Get_Font --
   --------------

   function Get_Font
      (Self  : not null access Gtk_Style_Context_Record;
       State : Gtk.Enums.Gtk_State_Flags)
       return Pango.Font.Pango_Font_Description
   is
      function Internal
         (Self  : System.Address;
          State : Gtk.Enums.Gtk_State_Flags)
          return Pango.Font.Pango_Font_Description;
      pragma Import (C, Internal, "gtk_style_context_get_font");
   begin
      return Internal (Get_Object (Self), State);
   end Get_Font;

   ------------------------
   -- Get_Junction_Sides --
   ------------------------

   function Get_Junction_Sides
      (Self : not null access Gtk_Style_Context_Record)
       return Gtk.Enums.Gtk_Junction_Sides
   is
      function Internal
         (Self : System.Address) return Gtk.Enums.Gtk_Junction_Sides;
      pragma Import (C, Internal, "gtk_style_context_get_junction_sides");
   begin
      return Internal (Get_Object (Self));
   end Get_Junction_Sides;

   ----------------
   -- Get_Margin --
   ----------------

   procedure Get_Margin
      (Self   : not null access Gtk_Style_Context_Record;
       State  : Gtk.Enums.Gtk_State_Flags;
       Margin : out Gtk.Style.Gtk_Border)
   is
      procedure Internal
         (Self   : System.Address;
          State  : Gtk.Enums.Gtk_State_Flags;
          Margin : out Gtk.Style.Gtk_Border);
      pragma Import (C, Internal, "gtk_style_context_get_margin");
   begin
      Internal (Get_Object (Self), State, Margin);
   end Get_Margin;

   -----------------
   -- Get_Padding --
   -----------------

   procedure Get_Padding
      (Self    : not null access Gtk_Style_Context_Record;
       State   : Gtk.Enums.Gtk_State_Flags;
       Padding : out Gtk.Style.Gtk_Border)
   is
      procedure Internal
         (Self    : System.Address;
          State   : Gtk.Enums.Gtk_State_Flags;
          Padding : out Gtk.Style.Gtk_Border);
      pragma Import (C, Internal, "gtk_style_context_get_padding");
   begin
      Internal (Get_Object (Self), State, Padding);
   end Get_Padding;

   --------------
   -- Get_Path --
   --------------

   function Get_Path
      (Self : not null access Gtk_Style_Context_Record)
       return Gtk.Widget.Gtk_Widget_Path
   is
      function Internal
         (Self : System.Address) return Gtk.Widget.Gtk_Widget_Path;
      pragma Import (C, Internal, "gtk_style_context_get_path");
   begin
      return Internal (Get_Object (Self));
   end Get_Path;

   ------------------
   -- Get_Property --
   ------------------

   procedure Get_Property
      (Self     : not null access Gtk_Style_Context_Record;
       Property : UTF8_String;
       State    : Gtk.Enums.Gtk_State_Flags;
       Value    : out Glib.Values.GValue)
   is
      procedure Internal
         (Self     : System.Address;
          Property : Interfaces.C.Strings.chars_ptr;
          State    : Gtk.Enums.Gtk_State_Flags;
          Value    : out Glib.Values.GValue);
      pragma Import (C, Internal, "gtk_style_context_get_property");
      Tmp_Property : Interfaces.C.Strings.chars_ptr := New_String (Property);
   begin
      Internal (Get_Object (Self), Tmp_Property, State, Value);
      Free (Tmp_Property);
   end Get_Property;

   ----------------
   -- Get_Screen --
   ----------------

   function Get_Screen
      (Self : not null access Gtk_Style_Context_Record)
       return Gdk.Screen.Gdk_Screen
   is
      function Internal (Self : System.Address) return System.Address;
      pragma Import (C, Internal, "gtk_style_context_get_screen");
      Stub_Gdk_Screen : Gdk.Screen.Gdk_Screen_Record;
   begin
      return Gdk.Screen.Gdk_Screen (Get_User_Data (Internal (Get_Object (Self)), Stub_Gdk_Screen));
   end Get_Screen;

   ---------------
   -- Get_State --
   ---------------

   function Get_State
      (Self : not null access Gtk_Style_Context_Record)
       return Gtk.Enums.Gtk_State_Flags
   is
      function Internal
         (Self : System.Address) return Gtk.Enums.Gtk_State_Flags;
      pragma Import (C, Internal, "gtk_style_context_get_state");
   begin
      return Internal (Get_Object (Self));
   end Get_State;

   ------------------------
   -- Get_Style_Property --
   ------------------------

   procedure Get_Style_Property
      (Self          : not null access Gtk_Style_Context_Record;
       Property_Name : UTF8_String;
       Value         : in out Glib.Values.GValue)
   is
      procedure Internal
         (Self          : System.Address;
          Property_Name : Interfaces.C.Strings.chars_ptr;
          Value         : in out Glib.Values.GValue);
      pragma Import (C, Internal, "gtk_style_context_get_style_property");
      Tmp_Property_Name : Interfaces.C.Strings.chars_ptr := New_String (Property_Name);
   begin
      Internal (Get_Object (Self), Tmp_Property_Name, Value);
      Free (Tmp_Property_Name);
   end Get_Style_Property;

   ---------------
   -- Has_Class --
   ---------------

   function Has_Class
      (Self       : not null access Gtk_Style_Context_Record;
       Class_Name : UTF8_String) return Boolean
   is
      function Internal
         (Self       : System.Address;
          Class_Name : Interfaces.C.Strings.chars_ptr) return Integer;
      pragma Import (C, Internal, "gtk_style_context_has_class");
      Tmp_Class_Name : Interfaces.C.Strings.chars_ptr := New_String (Class_Name);
      Tmp_Return     : Integer;
   begin
      Tmp_Return := Internal (Get_Object (Self), Tmp_Class_Name);
      Free (Tmp_Class_Name);
      return Boolean'Val (Tmp_Return);
   end Has_Class;

   ----------------
   -- Has_Region --
   ----------------

   procedure Has_Region
      (Self         : not null access Gtk_Style_Context_Record;
       Region_Name  : UTF8_String;
       Flags_Return : out Gtk.Enums.Gtk_Region_Flags;
       Is_Defined   : out Boolean)
   is
      function Internal
         (Self             : System.Address;
          Region_Name      : Interfaces.C.Strings.chars_ptr;
          Acc_Flags_Return : access Gtk.Enums.Gtk_Region_Flags)
          return Integer;
      pragma Import (C, Internal, "gtk_style_context_has_region");
      Acc_Flags_Return : aliased Gtk.Enums.Gtk_Region_Flags;
      Tmp_Region_Name  : Interfaces.C.Strings.chars_ptr := New_String (Region_Name);
      Tmp_Return       : Integer;
   begin
      Tmp_Return := Internal (Get_Object (Self), Tmp_Region_Name, Acc_Flags_Return'Access);
      Flags_Return := Acc_Flags_Return;
      Free (Tmp_Region_Name);
      Is_Defined := Boolean'Val (Tmp_Return);
   end Has_Region;

   ----------------
   -- Invalidate --
   ----------------

   procedure Invalidate (Self : not null access Gtk_Style_Context_Record) is
      procedure Internal (Self : System.Address);
      pragma Import (C, Internal, "gtk_style_context_invalidate");
   begin
      Internal (Get_Object (Self));
   end Invalidate;

   ------------------
   -- List_Classes --
   ------------------

   function List_Classes
      (Self : not null access Gtk_Style_Context_Record)
       return Gtk.Enums.String_List.Glist
   is
      function Internal (Self : System.Address) return System.Address;
      pragma Import (C, Internal, "gtk_style_context_list_classes");
      Tmp_Return : Gtk.Enums.String_List.Glist;
   begin
      Gtk.Enums.String_List.Set_Object (Tmp_Return, Internal (Get_Object (Self)));
      return Tmp_Return;
   end List_Classes;

   ------------------
   -- List_Regions --
   ------------------

   function List_Regions
      (Self : not null access Gtk_Style_Context_Record)
       return Gtk.Enums.String_List.Glist
   is
      function Internal (Self : System.Address) return System.Address;
      pragma Import (C, Internal, "gtk_style_context_list_regions");
      Tmp_Return : Gtk.Enums.String_List.Glist;
   begin
      Gtk.Enums.String_List.Set_Object (Tmp_Return, Internal (Get_Object (Self)));
      return Tmp_Return;
   end List_Regions;

   ------------------
   -- Lookup_Color --
   ------------------

   procedure Lookup_Color
      (Self       : not null access Gtk_Style_Context_Record;
       Color_Name : UTF8_String;
       Color      : out Gdk.RGBA.Gdk_RGBA;
       Found      : out Boolean)
   is
      function Internal
         (Self       : System.Address;
          Color_Name : Interfaces.C.Strings.chars_ptr;
          Acc_Color  : access Gdk.RGBA.Gdk_RGBA) return Integer;
      pragma Import (C, Internal, "gtk_style_context_lookup_color");
      Acc_Color      : aliased Gdk.RGBA.Gdk_RGBA;
      Tmp_Color_Name : Interfaces.C.Strings.chars_ptr := New_String (Color_Name);
      Tmp_Return     : Integer;
   begin
      Tmp_Return := Internal (Get_Object (Self), Tmp_Color_Name, Acc_Color'Access);
      Color := Acc_Color;
      Free (Tmp_Color_Name);
      Found := Boolean'Val (Tmp_Return);
   end Lookup_Color;

   ---------------------
   -- Lookup_Icon_Set --
   ---------------------

   function Lookup_Icon_Set
      (Self     : not null access Gtk_Style_Context_Record;
       Stock_Id : UTF8_String) return Gtk.Icon_Factory.Gtk_Icon_Set
   is
      function Internal
         (Self     : System.Address;
          Stock_Id : Interfaces.C.Strings.chars_ptr)
          return Gtk.Icon_Factory.Gtk_Icon_Set;
      pragma Import (C, Internal, "gtk_style_context_lookup_icon_set");
      Tmp_Stock_Id : Interfaces.C.Strings.chars_ptr := New_String (Stock_Id);
      Tmp_Return   : Gtk.Icon_Factory.Gtk_Icon_Set;
   begin
      Tmp_Return := Internal (Get_Object (Self), Tmp_Stock_Id);
      Free (Tmp_Stock_Id);
      return Tmp_Return;
   end Lookup_Icon_Set;

   -------------------------
   -- Notify_State_Change --
   -------------------------

   procedure Notify_State_Change
      (Self        : not null access Gtk_Style_Context_Record;
       Window      : Gdk.Window.Gdk_Window;
       Region_Id   : System.Address;
       State       : Gtk.Enums.Gtk_State_Type;
       State_Value : Boolean)
   is
      procedure Internal
         (Self        : System.Address;
          Window      : Gdk.Window.Gdk_Window;
          Region_Id   : System.Address;
          State       : Gtk.Enums.Gtk_State_Type;
          State_Value : Integer);
      pragma Import (C, Internal, "gtk_style_context_notify_state_change");
   begin
      Internal (Get_Object (Self), Window, Region_Id, State, Boolean'Pos (State_Value));
   end Notify_State_Change;

   ---------------------------
   -- Pop_Animatable_Region --
   ---------------------------

   procedure Pop_Animatable_Region
      (Self : not null access Gtk_Style_Context_Record)
   is
      procedure Internal (Self : System.Address);
      pragma Import (C, Internal, "gtk_style_context_pop_animatable_region");
   begin
      Internal (Get_Object (Self));
   end Pop_Animatable_Region;

   ----------------------------
   -- Push_Animatable_Region --
   ----------------------------

   procedure Push_Animatable_Region
      (Self      : not null access Gtk_Style_Context_Record;
       Region_Id : System.Address)
   is
      procedure Internal (Self : System.Address; Region_Id : System.Address);
      pragma Import (C, Internal, "gtk_style_context_push_animatable_region");
   begin
      Internal (Get_Object (Self), Region_Id);
   end Push_Animatable_Region;

   ------------------
   -- Remove_Class --
   ------------------

   procedure Remove_Class
      (Self       : not null access Gtk_Style_Context_Record;
       Class_Name : UTF8_String)
   is
      procedure Internal
         (Self       : System.Address;
          Class_Name : Interfaces.C.Strings.chars_ptr);
      pragma Import (C, Internal, "gtk_style_context_remove_class");
      Tmp_Class_Name : Interfaces.C.Strings.chars_ptr := New_String (Class_Name);
   begin
      Internal (Get_Object (Self), Tmp_Class_Name);
      Free (Tmp_Class_Name);
   end Remove_Class;

   ---------------------
   -- Remove_Provider --
   ---------------------

   procedure Remove_Provider
      (Self     : not null access Gtk_Style_Context_Record;
       Provider : Gtk.Style_Provider.Gtk_Style_Provider)
   is
      procedure Internal
         (Self     : System.Address;
          Provider : Gtk.Style_Provider.Gtk_Style_Provider);
      pragma Import (C, Internal, "gtk_style_context_remove_provider");
   begin
      Internal (Get_Object (Self), Provider);
   end Remove_Provider;

   -------------------
   -- Remove_Region --
   -------------------

   procedure Remove_Region
      (Self        : not null access Gtk_Style_Context_Record;
       Region_Name : UTF8_String)
   is
      procedure Internal
         (Self        : System.Address;
          Region_Name : Interfaces.C.Strings.chars_ptr);
      pragma Import (C, Internal, "gtk_style_context_remove_region");
      Tmp_Region_Name : Interfaces.C.Strings.chars_ptr := New_String (Region_Name);
   begin
      Internal (Get_Object (Self), Tmp_Region_Name);
      Free (Tmp_Region_Name);
   end Remove_Region;

   -------------
   -- Restore --
   -------------

   procedure Restore (Self : not null access Gtk_Style_Context_Record) is
      procedure Internal (Self : System.Address);
      pragma Import (C, Internal, "gtk_style_context_restore");
   begin
      Internal (Get_Object (Self));
   end Restore;

   ----------
   -- Save --
   ----------

   procedure Save (Self : not null access Gtk_Style_Context_Record) is
      procedure Internal (Self : System.Address);
      pragma Import (C, Internal, "gtk_style_context_save");
   begin
      Internal (Get_Object (Self));
   end Save;

   -----------------------
   -- Scroll_Animations --
   -----------------------

   procedure Scroll_Animations
      (Self   : not null access Gtk_Style_Context_Record;
       Window : Gdk.Window.Gdk_Window;
       Dx     : Gint;
       Dy     : Gint)
   is
      procedure Internal
         (Self   : System.Address;
          Window : Gdk.Window.Gdk_Window;
          Dx     : Gint;
          Dy     : Gint);
      pragma Import (C, Internal, "gtk_style_context_scroll_animations");
   begin
      Internal (Get_Object (Self), Window, Dx, Dy);
   end Scroll_Animations;

   --------------------
   -- Set_Background --
   --------------------

   procedure Set_Background
      (Self   : not null access Gtk_Style_Context_Record;
       Window : Gdk.Window.Gdk_Window)
   is
      procedure Internal
         (Self   : System.Address;
          Window : Gdk.Window.Gdk_Window);
      pragma Import (C, Internal, "gtk_style_context_set_background");
   begin
      Internal (Get_Object (Self), Window);
   end Set_Background;

   -------------------
   -- Set_Direction --
   -------------------

   procedure Set_Direction
      (Self      : not null access Gtk_Style_Context_Record;
       Direction : Gtk.Enums.Gtk_Text_Direction)
   is
      procedure Internal
         (Self      : System.Address;
          Direction : Gtk.Enums.Gtk_Text_Direction);
      pragma Import (C, Internal, "gtk_style_context_set_direction");
   begin
      Internal (Get_Object (Self), Direction);
   end Set_Direction;

   ------------------------
   -- Set_Junction_Sides --
   ------------------------

   procedure Set_Junction_Sides
      (Self  : not null access Gtk_Style_Context_Record;
       Sides : Gtk.Enums.Gtk_Junction_Sides)
   is
      procedure Internal
         (Self  : System.Address;
          Sides : Gtk.Enums.Gtk_Junction_Sides);
      pragma Import (C, Internal, "gtk_style_context_set_junction_sides");
   begin
      Internal (Get_Object (Self), Sides);
   end Set_Junction_Sides;

   --------------
   -- Set_Path --
   --------------

   procedure Set_Path
      (Self : not null access Gtk_Style_Context_Record;
       Path : Gtk.Widget.Gtk_Widget_Path)
   is
      procedure Internal
         (Self : System.Address;
          Path : Gtk.Widget.Gtk_Widget_Path);
      pragma Import (C, Internal, "gtk_style_context_set_path");
   begin
      Internal (Get_Object (Self), Path);
   end Set_Path;

   ----------------
   -- Set_Screen --
   ----------------

   procedure Set_Screen
      (Self   : not null access Gtk_Style_Context_Record;
       Screen : not null access Gdk.Screen.Gdk_Screen_Record'Class)
   is
      procedure Internal (Self : System.Address; Screen : System.Address);
      pragma Import (C, Internal, "gtk_style_context_set_screen");
   begin
      Internal (Get_Object (Self), Get_Object (Screen));
   end Set_Screen;

   ---------------
   -- Set_State --
   ---------------

   procedure Set_State
      (Self  : not null access Gtk_Style_Context_Record;
       Flags : Gtk.Enums.Gtk_State_Flags)
   is
      procedure Internal
         (Self  : System.Address;
          Flags : Gtk.Enums.Gtk_State_Flags);
      pragma Import (C, Internal, "gtk_style_context_set_state");
   begin
      Internal (Get_Object (Self), Flags);
   end Set_State;

   ----------------------
   -- State_Is_Running --
   ----------------------

   procedure State_Is_Running
      (Self       : not null access Gtk_Style_Context_Record;
       State      : Gtk.Enums.Gtk_State_Type;
       Progress   : out Gdouble;
       Is_Running : out Boolean)
   is
      function Internal
         (Self         : System.Address;
          State        : Gtk.Enums.Gtk_State_Type;
          Acc_Progress : access Gdouble) return Integer;
      pragma Import (C, Internal, "gtk_style_context_state_is_running");
      Acc_Progress : aliased Gdouble;
      Tmp_Return   : Integer;
   begin
      Tmp_Return := Internal (Get_Object (Self), State, Acc_Progress'Access);
      Progress := Acc_Progress;
      Is_Running := Boolean'Val (Tmp_Return);
   end State_Is_Running;

   -----------------------------
   -- Add_Provider_For_Screen --
   -----------------------------

   procedure Add_Provider_For_Screen
      (Screen   : not null access Gdk.Screen.Gdk_Screen_Record'Class;
       Provider : Gtk.Style_Provider.Gtk_Style_Provider;
       Priority : Guint)
   is
      procedure Internal
         (Screen   : System.Address;
          Provider : Gtk.Style_Provider.Gtk_Style_Provider;
          Priority : Guint);
      pragma Import (C, Internal, "gtk_style_context_add_provider_for_screen");
   begin
      Internal (Get_Object (Screen), Provider, Priority);
   end Add_Provider_For_Screen;

   --------------------------------
   -- Remove_Provider_For_Screen --
   --------------------------------

   procedure Remove_Provider_For_Screen
      (Screen   : not null access Gdk.Screen.Gdk_Screen_Record'Class;
       Provider : Gtk.Style_Provider.Gtk_Style_Provider)
   is
      procedure Internal
         (Screen   : System.Address;
          Provider : Gtk.Style_Provider.Gtk_Style_Provider);
      pragma Import (C, Internal, "gtk_style_context_remove_provider_for_screen");
   begin
      Internal (Get_Object (Screen), Provider);
   end Remove_Provider_For_Screen;

   -------------------
   -- Reset_Widgets --
   -------------------

   procedure Reset_Widgets
      (Screen : not null access Gdk.Screen.Gdk_Screen_Record'Class)
   is
      procedure Internal (Screen : System.Address);
      pragma Import (C, Internal, "gtk_style_context_reset_widgets");
   begin
      Internal (Get_Object (Screen));
   end Reset_Widgets;

end Gtk.Style_Context;
