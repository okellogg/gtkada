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

pragma Style_Checks (Off);
pragma Warnings (Off, "*is already use-visible*");
with Ada.Unchecked_Conversion;
with Glib.Type_Conversion_Hooks; use Glib.Type_Conversion_Hooks;

package body Gtk.File_Filter is

   function To_Gtk_File_Filter_Func is new Ada.Unchecked_Conversion
     (System.Address, Gtk_File_Filter_Func);

   procedure C_Gtk_File_Filter_Add_Custom
      (Self   : System.Address;
       Needed : Integer;
       Func   : System.Address;
       Data   : System.Address;
       Notify : Glib.G_Destroy_Notify_Address);
   pragma Import (C, C_Gtk_File_Filter_Add_Custom, "gtk_file_filter_add_custom");
   --  Adds rule to a filter that allows files based on a custom callback
   --  function. The bitfield Needed which is passed in provides information
   --  about what sorts of information that the filter function needs; this
   --  allows GTK+ to avoid retrieving expensive information when it isn't
   --  needed by the filter.
   --  Since: gtk+ 2.4
   --  "needed": bitfield of flags indicating the information that the custom
   --  filter function needs.
   --  "func": callback function; if the function returns True, then the file
   --  will be displayed.
   --  "data": data to pass to Func
   --  "notify": function to call to free Data when it is no longer needed.

   function Internal_Gtk_File_Filter_Func
      (Filter_Info : Gtk_File_Filter_Info;
       Data        : System.Address) return Integer;
   pragma Convention (C, Internal_Gtk_File_Filter_Func);
   --  "filter_info": a Gtk_File_Filter_Info that is filled according to the
   --  Needed flags passed to Gtk.File_Filter.Add_Custom
   --  "data": user data passed to Gtk.File_Filter.Add_Custom

   -----------------------------------
   -- Internal_Gtk_File_Filter_Func --
   -----------------------------------

   function Internal_Gtk_File_Filter_Func
      (Filter_Info : Gtk_File_Filter_Info;
       Data        : System.Address) return Integer
   is
      Func : constant Gtk_File_Filter_Func := To_Gtk_File_Filter_Func (Data);
   begin
      return Boolean'Pos (Func (Filter_Info));
   end Internal_Gtk_File_Filter_Func;

   package Type_Conversion is new Glib.Type_Conversion_Hooks.Hook_Registrator
     (Get_Type'Access, Gtk_File_Filter_Record);
   pragma Unreferenced (Type_Conversion);

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New (Self : out Gtk_File_Filter) is
   begin
      Self := new Gtk_File_Filter_Record;
      Gtk.File_Filter.Initialize (Self);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : access Gtk_File_Filter_Record'Class) is
      function Internal return System.Address;
      pragma Import (C, Internal, "gtk_file_filter_new");
   begin
      Set_Object (Self, Internal);
   end Initialize;

   ----------------
   -- Add_Custom --
   ----------------

   procedure Add_Custom
      (Self   : access Gtk_File_Filter_Record;
       Needed : Gtk_File_Filter_Flags;
       Func   : Gtk_File_Filter_Func;
       Notify : Glib.G_Destroy_Notify_Address)
   is
   begin
      C_Gtk_File_Filter_Add_Custom (Get_Object (Self), Gtk.File_Filter.Gtk_File_Filter_Flags'Pos (Needed), Internal_Gtk_File_Filter_Func'Address, Func'Address, Notify);
   end Add_Custom;

   package body Add_Custom_User_Data is

      package Users is new Glib.Object.User_Data_Closure
        (User_Data_Type, Destroy);
      function To_Gtk_File_Filter_Func is new Ada.Unchecked_Conversion
        (System.Address, Gtk_File_Filter_Func);

      function Internal_Cb
         (Filter_Info : Gtk_File_Filter_Info;
          Data        : System.Address) return Boolean;
      --  The type of function that is used with custom filters, see
      --  Gtk.File_Filter.Add_Custom.
      --  "filter_info": a Gtk_File_Filter_Info that is filled according to
      --  the Needed flags passed to Gtk.File_Filter.Add_Custom
      --  "data": user data passed to Gtk.File_Filter.Add_Custom

      ----------------
      -- Add_Custom --
      ----------------

      procedure Add_Custom
         (Self   : access Gtk.File_Filter.Gtk_File_Filter_Record'Class;
          Needed : Gtk.File_Filter.Gtk_File_Filter_Flags;
          Func   : Gtk_File_Filter_Func;
          Data   : User_Data_Type;
          Notify : Glib.G_Destroy_Notify_Address)
      is
      begin
         C_Gtk_File_Filter_Add_Custom (Get_Object (Self), Gtk.File_Filter.Gtk_File_Filter_Flags'Pos (Needed), Internal_Cb'Address, Users.Build (Func'Address, Data), Notify);
      end Add_Custom;

      -----------------
      -- Internal_Cb --
      -----------------

      function Internal_Cb
         (Filter_Info : Gtk_File_Filter_Info;
          Data        : System.Address) return Boolean
      is
         D : constant Users.Internal_Data_Access := Users.Convert (Data);
      begin
         return To_Gtk_File_Filter_Func (D.Func) (Filter_Info, D.Data.all);
      end Internal_Cb;

   end Add_Custom_User_Data;

   -------------------
   -- Add_Mime_Type --
   -------------------

   procedure Add_Mime_Type
      (Self      : access Gtk_File_Filter_Record;
       Mime_Type : UTF8_String)
   is
      procedure Internal
         (Self      : System.Address;
          Mime_Type : Interfaces.C.Strings.chars_ptr);
      pragma Import (C, Internal, "gtk_file_filter_add_mime_type");
      Tmp_Mime_Type : Interfaces.C.Strings.chars_ptr := New_String (Mime_Type);
   begin
      Internal (Get_Object (Self), Tmp_Mime_Type);
      Free (Tmp_Mime_Type);
   end Add_Mime_Type;

   -----------------
   -- Add_Pattern --
   -----------------

   procedure Add_Pattern
      (Self    : access Gtk_File_Filter_Record;
       Pattern : UTF8_String)
   is
      procedure Internal
         (Self    : System.Address;
          Pattern : Interfaces.C.Strings.chars_ptr);
      pragma Import (C, Internal, "gtk_file_filter_add_pattern");
      Tmp_Pattern : Interfaces.C.Strings.chars_ptr := New_String (Pattern);
   begin
      Internal (Get_Object (Self), Tmp_Pattern);
      Free (Tmp_Pattern);
   end Add_Pattern;

   ------------------------
   -- Add_Pixbuf_Formats --
   ------------------------

   procedure Add_Pixbuf_Formats (Self : access Gtk_File_Filter_Record) is
      procedure Internal (Self : System.Address);
      pragma Import (C, Internal, "gtk_file_filter_add_pixbuf_formats");
   begin
      Internal (Get_Object (Self));
   end Add_Pixbuf_Formats;

   ------------
   -- Filter --
   ------------

   function Filter
      (Self        : access Gtk_File_Filter_Record;
       Filter_Info : Gtk_File_Filter_Info) return Boolean
   is
      function Internal
         (Self        : System.Address;
          Filter_Info : Gtk_File_Filter_Info) return Integer;
      pragma Import (C, Internal, "gtk_file_filter_filter");
   begin
      return Boolean'Val (Internal (Get_Object (Self), Filter_Info));
   end Filter;

   --------------
   -- Get_Name --
   --------------

   function Get_Name
      (Self : access Gtk_File_Filter_Record) return UTF8_String
   is
      function Internal
         (Self : System.Address) return Interfaces.C.Strings.chars_ptr;
      pragma Import (C, Internal, "gtk_file_filter_get_name");
   begin
      return Interfaces.C.Strings.Value (Internal (Get_Object (Self)));
   end Get_Name;

   ----------------
   -- Get_Needed --
   ----------------

   function Get_Needed
      (Self : access Gtk_File_Filter_Record) return Gtk_File_Filter_Flags
   is
      function Internal (Self : System.Address) return Integer;
      pragma Import (C, Internal, "gtk_file_filter_get_needed");
   begin
      return Gtk.File_Filter.Gtk_File_Filter_Flags'Val (Internal (Get_Object (Self)));
   end Get_Needed;

   --------------
   -- Set_Name --
   --------------

   procedure Set_Name
      (Self : access Gtk_File_Filter_Record;
       Name : UTF8_String)
   is
      procedure Internal
         (Self : System.Address;
          Name : Interfaces.C.Strings.chars_ptr);
      pragma Import (C, Internal, "gtk_file_filter_set_name");
      Tmp_Name : Interfaces.C.Strings.chars_ptr := New_String (Name);
   begin
      Internal (Get_Object (Self), Tmp_Name);
      Free (Tmp_Name);
   end Set_Name;

end Gtk.File_Filter;
