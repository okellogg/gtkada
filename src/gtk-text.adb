-----------------------------------------------------------------------
--          GtkAda - Ada95 binding for the Gimp Toolkit              --
--                                                                   --
--                     Copyright (C) 1998-2000                       --
--        Emmanuel Briot, Joel Brobecker and Arnaud Charlet          --
--                                                                   --
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
-- License as published by the Free Software Foundation; either      --
-- version 2 of the License, or (at your option) any later version.  --
--                                                                   --
-- This library is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
--                                                                   --
-- As a special exception, if other files instantiate generics from  --
-- this unit, or you link this unit with other files to produce an   --
-- executable, this  unit  does not  by itself cause  the resulting  --
-- executable to be covered by the GNU General Public License. This  --
-- exception does not however invalidate any other reasons why the   --
-- executable file  might be covered by the  GNU Public License.     --
-----------------------------------------------------------------------

with System;
with Interfaces.C.Strings;
with Gdk; use Gdk;
with Gtk.Util; use Gtk.Util;

package body Gtk.Text is

   ---------------------
   -- Backward_Delete --
   ---------------------

   function Backward_Delete (Text : access Gtk_Text_Record; Nchars : in Guint)
      return Boolean
   is
      function Internal (Text : in System.Address; Nchars : in Guint)
         return Gint;
      pragma Import (C, Internal, "gtk_text_backward_delete");

   begin
      return To_Boolean (Internal (Get_Object (Text), Nchars));
   end Backward_Delete;

   --------------------
   -- Forward_Delete --
   --------------------

   function Forward_Delete
     (Text   : access Gtk_Text_Record;
      Nchars : in Guint)
      return Boolean
   is
      function Internal
        (Text   : in System.Address;
         Nchars : in Guint)
         return Gint;
      pragma Import (C, Internal, "gtk_text_forward_delete");

   begin
      return To_Boolean (Internal (Get_Object (Text), Nchars));
   end Forward_Delete;

   ------------
   -- Freeze --
   ------------

   procedure Freeze (Text : access Gtk_Text_Record) is
      procedure Internal (Text : in System.Address);
      pragma Import (C, Internal, "gtk_text_freeze");

   begin
      Internal (Get_Object (Text));
   end Freeze;

   ----------------------
   -- Get_Gap_Position --
   ----------------------

   function Get_Gap_Position (Text : access Gtk_Text_Record) return Guint is
      function Internal (Widget : in System.Address) return Guint;
      pragma Import (C, Internal, "ada_text_get_gap_position");

   begin
      return Internal (Get_Object (Text));
   end Get_Gap_Position;

   ------------------
   -- Get_Gap_Size --
   ------------------

   function Get_Gap_Size (Text : access Gtk_Text_Record) return Guint is
      function Internal (Widget : in System.Address) return Guint;
      pragma Import (C, Internal, "ada_text_get_gap_size");

   begin
      return Internal (Get_Object (Text));
   end Get_Gap_Size;

   --------------
   -- Get_Hadj --
   --------------

   function Get_Hadj (Text : access Gtk_Text_Record)
     return Gtk.Adjustment.Gtk_Adjustment
   is
      function Internal (Widget : in System.Address)
        return System.Address;
      pragma Import (C, Internal, "ada_text_get_hadj");
      Stub : Gtk.Adjustment.Gtk_Adjustment_Record;

   begin
      return Gtk.Adjustment.Gtk_Adjustment
        (Get_User_Data (Internal (Get_Object (Text)), Stub));
   end Get_Hadj;

   ----------------
   -- Get_Length --
   ----------------

   function Get_Length (Text : access Gtk_Text_Record) return Guint is
      function Internal (Text : in System.Address) return Guint;
      pragma Import (C, Internal, "gtk_text_get_length");

   begin
      return Internal (Get_Object (Text));
   end Get_Length;

   ---------------
   -- Get_Point --
   ---------------

   function Get_Point (Text : access Gtk_Text_Record) return Guint is
      function Internal (Text : in System.Address) return Guint;
      pragma Import (C, Internal, "gtk_text_get_point");

   begin
      return Internal (Get_Object (Text));
   end Get_Point;

   --------------
   -- Get_Text --
   --------------

   function Get_Text (Text : access Gtk_Text_Record) return String  is
      function Internal (Text : in System.Address)
        return Interfaces.C.Strings.chars_ptr;
      pragma Import (C, Internal, "ada_text_get_text");

   begin
      return Interfaces.C.Strings.Value (Internal (Get_Object (Text)));
   end Get_Text;

   ------------------
   -- Get_Text_End --
   ------------------

   function Get_Text_End (Text : access Gtk_Text_Record) return Guint is
      function Internal (Widget : in System.Address) return Guint;
      pragma Import (C, Internal, "ada_text_get_text_end");

   begin
      return Internal (Get_Object (Text));
   end Get_Text_End;

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New
     (Text : out Gtk_Text;
      Hadj : in Adjustment.Gtk_Adjustment := Adjustment.Null_Adjustment;
      Vadj : in Adjustment.Gtk_Adjustment := Adjustment.Null_Adjustment) is
   begin
      Text := new Gtk_Text_Record;
      Initialize (Text, Hadj, Vadj);
   end Gtk_New;

   --------------
   -- Get_Vadj --
   --------------

   function Get_Vadj (Text : access Gtk_Text_Record)
     return Gtk.Adjustment.Gtk_Adjustment
   is
      function Internal (Widget : in System.Address) return System.Address;
      pragma Import (C, Internal, "ada_text_get_vadj");
      Stub : Gtk.Adjustment.Gtk_Adjustment_Record;

   begin
      return Gtk.Adjustment.Gtk_Adjustment
        (Get_User_Data (Internal (Get_Object (Text)), Stub));
   end Get_Vadj;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
     (Text : access Gtk_Text_Record'Class;
      Hadj : in Adjustment.Gtk_Adjustment := Adjustment.Null_Adjustment;
      Vadj : in Adjustment.Gtk_Adjustment := Adjustment.Null_Adjustment)
   is
      function Internal
        (Hadj   : in System.Address;
         Vadj   : in System.Address) return System.Address;
      pragma Import (C, Internal, "gtk_text_new");

      H, V : System.Address;

      use type Gtk.Adjustment.Gtk_Adjustment;

   begin
      if Hadj = null then
         H := System.Null_Address;
      else
         H := Get_Object (Hadj);
      end if;

      if Vadj = null then
         V := System.Null_Address;
      else
         V := Get_Object (Vadj);
      end if;

      Set_Object (Text, Internal (H, V));
      Initialize_User_Data (Text);
   end Initialize;

   ------------
   -- Insert --
   ------------

   procedure Insert
     (Text   : access Gtk_Text_Record;
      Font   : in Gdk.Font.Gdk_Font;
      Fore   : in Gdk.Color.Gdk_Color;
      Back   : in Gdk.Color.Gdk_Color;
      Chars  : in String;
      Length : in Gint := -1)
   is
      procedure Internal
        (Text   : in System.Address;
         Font   : in Gdk.Font.Gdk_Font;
         Fore   : in System.Address;
         Back   : in System.Address;
         Chars  : in String;
         Length : in Gint);
      pragma Import (C, Internal, "gtk_text_insert");
      use type Gdk.Color.Gdk_Color;
      Fore_Col : aliased Gdk.Color.Gdk_Color := Fore;
      Back_Col : aliased Gdk.Color.Gdk_Color := Back;
      --  Need to use a local variable to avoid problems with 'Address if
      --  the parameter is passed in a register for instance.
      Fore_A : System.Address := Fore_Col'Address;
      Back_A : System.Address := Back_Col'Address;

   begin
      if Fore = Gdk.Color.Null_Color then
         Fore_A := System.Null_Address;
      end if;

      if Back = Gdk.Color.Null_Color then
         Back_A := System.Null_Address;
      end if;

      Internal
        (Get_Object (Text), Font, Fore_A, Back_A,
         Chars & ASCII.Nul, Length);
   end Insert;

   ---------------------
   -- Set_Adjustments --
   ---------------------

   procedure Set_Adjustments
     (Text : access Gtk_Text_Record;
      Hadj : Gtk.Adjustment.Gtk_Adjustment;
      Vadj : Gtk.Adjustment.Gtk_Adjustment)
   is
      procedure Internal
        (Text : in System.Address;
         Hadj : in System.Address;
         Vadj : in System.Address);
      pragma Import (C, Internal, "gtk_text_set_adjustments");
      use type Gtk.Adjustment.Gtk_Adjustment;
      Ha, Va : System.Address := System.Null_Address;
   begin
      if Hadj /= null then
         Ha := Get_Object (Hadj);
      end if;
      if Vadj /= null then
         Va := Get_Object (Vadj);
      end if;
      Internal (Get_Object (Text), Ha, Va);
   end Set_Adjustments;

   ------------------
   -- Set_Editable --
   ------------------

   procedure Set_Editable
     (Text     : access Gtk_Text_Record;
      Editable : in Boolean := True)
   is
      procedure Internal
        (Text     : in System.Address;
         Editable : in Gint);
      pragma Import (C, Internal, "gtk_text_set_editable");

   begin
      Internal (Get_Object (Text), Boolean'Pos (Editable));
   end Set_Editable;

   ---------------
   -- Set_Point --
   ---------------

   procedure Set_Point (Text  : access Gtk_Text_Record; Index : in Guint) is
      procedure Internal
        (Text  : in System.Address;
         Index : in Guint);
      pragma Import (C, Internal, "gtk_text_set_point");

   begin
      Internal (Get_Object (Text), Index);
   end Set_Point;

   -------------------
   -- Set_Line_Wrap --
   -------------------

   procedure Set_Line_Wrap
     (Text      : access Gtk_Text_Record;
      Line_Wrap : in Boolean := True)
   is
      procedure Internal
        (Text      : in System.Address;
         Line_Wrap : in Gint);
      pragma Import (C, Internal, "gtk_text_set_line_wrap");

   begin
      Internal (Get_Object (Text), Boolean'Pos (Line_Wrap));
   end Set_Line_Wrap;

   -------------------
   -- Set_Word_Wrap --
   -------------------

   procedure Set_Word_Wrap
     (Text      : access Gtk_Text_Record;
      Word_Wrap : in Boolean := True)
   is
      procedure Internal
        (Text      : in System.Address;
         Word_Wrap : in Gint);
      pragma Import (C, Internal, "gtk_text_set_word_wrap");

   begin
      Internal (Get_Object (Text), Boolean'Pos (Word_Wrap));
   end Set_Word_Wrap;

   ----------
   -- Thaw --
   ----------

   procedure Thaw (Text : access Gtk_Text_Record) is
      procedure Internal (Text : in System.Address);
      pragma Import (C, Internal, "gtk_text_thaw");

   begin
      Internal (Get_Object (Text));
   end Thaw;

   --------------
   -- Generate --
   --------------

   procedure Generate (N : in Node_Ptr; File : in File_Type) is
   begin
      Gen_New (N, "Text", File => File);

      Editable.Generate (N, File);

      Gen_Set (N, "Text", "editable", File);
      Gen_Set (N, "Text", "point", File);
      Gen_Set (N, "Text", "word_wrap", File);
   end Generate;

   procedure Generate (Text : in out Gtk_Object; N : in Node_Ptr) is
      S : String_Ptr;
   begin
      if not N.Specific_Data.Created then
         Gtk_New (Gtk_Text (Text));
         Set_Object (Get_Field (N, "name"), Text);
         N.Specific_Data.Created := True;
      end if;

      Editable.Generate (Text, N);

      S := Get_Field (N, "editable");

      if S /= null then
         Set_Editable (Gtk_Text (Text), Boolean'Value (S.all));
      end if;

      S := Get_Field (N, "point");

      if S /= null then
         Set_Point (Gtk_Text (Text), Guint'Value (S.all));
      end if;

      S := Get_Field (N, "word_wrap");

      if S /= null then
         Set_Word_Wrap (Gtk_Text (Text), Boolean'Value (S.all));
      end if;
   end Generate;

end Gtk.Text;
