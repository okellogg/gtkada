-----------------------------------------------------------------------
--          GtkAda - Ada95 binding for the Gimp Toolkit              --
--                                                                   --
--                     Copyright (C) 2000                            --
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

with Glib;         use Glib;
with Gtk.Widget;   use Gtk.Widget;
with Gtkada.Types; use Gtkada.Types;
with Gdk.Color;    use Gdk.Color;
with Interfaces.C; use Interfaces.C;

package body Gtk.Extra.Plot_Data is

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New
     (Data : out Gtk_Plot_Data; Func : Plot_Function := null) is
   begin
      Data := new Gtk_Plot_Data_Record;
      Initialize (Data, Func);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
     (Data : access Gtk_Plot_Data_Record'Class; Func : Plot_Function := null)
   is
      function Internal return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_new");

      function Internal2 (Func : Plot_Function) return System.Address;
      pragma Import (C, Internal2, "gtk_plot_data_new_function");
   begin
      if Func = null then
         Set_Object (Data, Internal);
      else
         Set_Object (Data, Internal2 (Func));
      end if;
      Initialize_User_Data (Data);
   end Initialize;

   --------------
   -- Set_Name --
   --------------

   procedure Set_Name (Data : access Gtk_Plot_Data_Record; Name : String) is
      procedure Internal (Data : System.Address; Name : in String);
      pragma Import (C, Internal, "gtk_plot_data_set_name");
   begin
      Internal (Get_Object (Data), Name & ASCII.NUL);
   end Set_Name;

   -----------
   -- Paint --
   -----------

   procedure Paint (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_paint");
   begin
      Internal (Get_Object (Data));
   end Paint;

   -----------------
   -- Draw_Points --
   -----------------

   procedure Draw_Points (Data : access Gtk_Plot_Data_Record; N : Gint) is
      procedure Internal (Data : System.Address; N : Gint);
      pragma Import (C, Internal, "gtk_plot_data_draw_points");
   begin
      Internal (Get_Object (Data), N);
   end Draw_Points;

   -----------------
   -- Draw_Symbol --
   -----------------

   procedure Draw_Symbol
     (Data : access Gtk_Plot_Data_Record; X, Y : Gdouble)
   is
      procedure Internal (Data : System.Address; X, Y : Gdouble);
      pragma Import (C, Internal, "gtk_plot_data_draw_symbol");
   begin
      Internal (Get_Object (Data), X, Y);
   end Draw_Symbol;

   ----------------
   -- Set_Points --
   ----------------

   procedure Set_Points
     (Data : access Gtk_Plot_Data_Record;
      X    : Gdouble_Array_Access;
      Y    : Gdouble_Array_Access;
      Dx   : Gdouble_Array_Access;
      Dy   : Gdouble_Array_Access)
   is
      procedure Internal (Data       : in System.Address;
                          X          : in System.Address;
                          Y          : in System.Address;
                          Dx         : in System.Address;
                          Dy         : in System.Address;
                          Num_Points : in Gint);
      pragma Import (C, Internal, "gtk_plot_data_set_points");
      Xa, Ya, Dxa, Dya : System.Address := System.Null_Address;
   begin
      if X /= null then
         Xa := X (X'First)'Address;
      end if;

      if Y /= null then
         Ya := Y (Y'First)'Address;
      end if;

      if Dx /= null then
         Dxa := Dx (Dx'First)'Address;
      end if;

      if Dy /= null then
         Dya := Dy (Dy'First)'Address;
      end if;

      Internal (Get_Object (Data), Xa, Ya, Dxa, Dya, X'Length);
   end Set_Points;

   ----------------
   -- Get_Points --
   ----------------

   procedure Get_Points
     (Data : access Gtk_Plot_Data_Record;
      X    : out Points_Array;
      Y    : out Points_Array;
      Dx   : out Points_Array;
      Dy   : out Points_Array)
   is
      procedure Internal (Data       : in System.Address;
                          X          : out System.Address;
                          Y          : out System.Address;
                          Dx         : out System.Address;
                          Dy         : out System.Address;
                          Num_Points : out Gint);
      pragma Import (C, Internal, "gtk_plot_data_get_points");
      Num_Points : Gint;
      X1, Y1, Dx1, Dy1 : System.Address;
   begin
      Internal (Get_Object (Data), X1, Y1, Dx1, Dy1, Num_Points);
      X  := (Points => To_Double_Array (X1),  Num_Points => Num_Points);
      Y  := (Points => To_Double_Array (Y1),  Num_Points => Num_Points);
      Dx := (Points => To_Double_Array (Dx1), Num_Points => Num_Points);
      Dy := (Points => To_Double_Array (Dy1), Num_Points => Num_Points);
   end Get_Points;

   -----------
   -- Set_X --
   -----------

   procedure Set_X
     (Data : access Gtk_Plot_Data_Record; X : Gdouble_Array_Access)
   is
      procedure Internal (Data : System.Address; X : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_x");
   begin
      pragma Assert (Get_Numpoints (Data) = X'Length);
      Internal (Get_Object (Data), X (X'First)'Address);
   end Set_X;

   -----------
   -- Set_Y --
   -----------

   procedure Set_Y
     (Data : access Gtk_Plot_Data_Record; Y : Gdouble_Array_Access)
   is
      procedure Internal (Data : System.Address; Y : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_y");
   begin
      pragma Assert (Get_Numpoints (Data) = Y'Length);
      Internal (Get_Object (Data), Y (Y'First)'Address);
   end Set_Y;

   -----------
   -- Set_Z --
   -----------

   procedure Set_Z
     (Data : access Gtk_Plot_Data_Record; Z : Gdouble_Array_Access)
   is
      procedure Internal (Data : System.Address; Z : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_z");
   begin
      pragma Assert (Get_Numpoints (Data) = Z'Length);
      Internal (Get_Object (Data), Z (Z'First)'Address);
   end Set_Z;

   -----------
   -- Set_A --
   -----------

   procedure Set_A
     (Data : access Gtk_Plot_Data_Record; A : Gdouble_Array_Access)
   is
      procedure Internal (Data : System.Address; A : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_a");
   begin
      pragma Assert (Get_Numpoints (Data) = A'Length);
      Internal (Get_Object (Data), A (A'First)'Address);
   end Set_A;

   ------------
   -- Set_Dx --
   ------------

   procedure Set_Dx
     (Data : access Gtk_Plot_Data_Record; Dx : Gdouble_Array_Access)
   is
      procedure Internal (Data : System.Address; Dx : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_dx");
   begin
      pragma Assert (Get_Numpoints (Data) = Dx'Length);
      Internal (Get_Object (Data), Dx (Dx'First)'Address);
   end Set_Dx;

   ------------
   -- Set_Dy --
   ------------

   procedure Set_Dy
     (Data : access Gtk_Plot_Data_Record; Dy : Gdouble_Array_Access)
   is
      procedure Internal (Data : System.Address; Dy : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_dy");
   begin
      pragma Assert (Get_Numpoints (Data) = Dy'Length);
      Internal (Get_Object (Data), Dy (Dy'First)'Address);
   end Set_Dy;

   ------------
   -- Set_Dz --
   ------------

   procedure Set_Dz
     (Data : access Gtk_Plot_Data_Record; Dz : Gdouble_Array_Access)
   is
      procedure Internal (Data : System.Address; Dz : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_dz");
   begin
      pragma Assert (Get_Numpoints (Data) = Dz'Length);
      Internal (Get_Object (Data), Dz (Dz'First)'Address);
   end Set_Dz;

   ------------
   -- Set_Da --
   ------------

   procedure Set_Da
     (Data : access Gtk_Plot_Data_Record; Da : Gdouble_Array_Access)
   is
      procedure Internal (Data : System.Address; Da : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_da");
   begin
      pragma Assert (Get_Numpoints (Data) = Da'Length);
      Internal (Get_Object (Data), Da (Da'First)'Address);
   end Set_Da;

   -----------
   -- Get_X --
   -----------

   function Get_X (Data : access Gtk_Plot_Data_Record) return Points_Array is
      function Internal (Data : System.Address; Num_Points : System.Address)
         return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_x");

      Num_Points : aliased Gint;
      S : System.Address := Internal (Get_Object (Data), Num_Points'Address);
   begin
      return (Points => To_Double_Array (S), Num_Points => Num_Points);
   end Get_X;

   -----------
   -- Get_Y --
   -----------

   function Get_Y (Data : access Gtk_Plot_Data_Record) return Points_Array is
      function Internal (Data : System.Address; Num_Points : System.Address)
         return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_y");

      Num_Points : aliased Gint;
      S : System.Address := Internal (Get_Object (Data), Num_Points'Address);
   begin
      return (Points => To_Double_Array (S), Num_Points => Num_Points);
   end Get_Y;

   -----------
   -- Get_Z --
   -----------

   function Get_Z (Data : access Gtk_Plot_Data_Record) return Points_Array is
      function Internal (Data : System.Address; Num_Points : System.Address)
         return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_z");

      Num_Points : aliased Gint;
      S : System.Address := Internal (Get_Object (Data), Num_Points'Address);
   begin
      return (Points => To_Double_Array (S), Num_Points => Num_Points);
   end Get_Z;

   -----------
   -- Get_A --
   -----------

   function Get_A (Data : access Gtk_Plot_Data_Record) return Points_Array is
      function Internal (Data : System.Address; Num_Points : System.Address)
         return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_a");

      Num_Points : aliased Gint;
      S : System.Address := Internal (Get_Object (Data), Num_Points'Address);
   begin
      return (Points => To_Double_Array (S), Num_Points => Num_Points);
   end Get_A;

   ------------
   -- Get_Dx --
   ------------

   function Get_Dx (Data : access Gtk_Plot_Data_Record) return Points_Array is
      function Internal (Data : System.Address; Num_Points : System.Address)
         return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_dx");

      Num_Points : aliased Gint;
      S : System.Address := Internal (Get_Object (Data), Num_Points'Address);
   begin
      return (Points => To_Double_Array (S), Num_Points => Num_Points);
   end Get_Dx;

   ------------
   -- Get_Dy --
   ------------

   function Get_Dy (Data : access Gtk_Plot_Data_Record) return Points_Array is
      function Internal (Data : System.Address; Num_Points : System.Address)
         return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_dy");

      Num_Points : aliased Gint;
      S : System.Address := Internal (Get_Object (Data), Num_Points'Address);
   begin
      return (Points => To_Double_Array (S), Num_Points => Num_Points);
   end Get_Dy;

   ------------
   -- Get_Dz --
   ------------

   function Get_Dz (Data : access Gtk_Plot_Data_Record) return Points_Array is
      function Internal (Data : System.Address; Num_Points : System.Address)
         return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_dz");

      Num_Points : aliased Gint;
      S : System.Address := Internal (Get_Object (Data), Num_Points'Address);
   begin
      return (Points => To_Double_Array (S), Num_Points => Num_Points);
   end Get_Dz;

   ------------
   -- Get_Da --
   ------------

   function Get_Da  (Data : access Gtk_Plot_Data_Record) return Points_Array is
      function Internal (Data : System.Address; Num_Points : System.Address)
         return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_da");

      Num_Points : aliased Gint;
      S : System.Address := Internal (Get_Object (Data), Num_Points'Address);
   begin
      return (Points => To_Double_Array (S), Num_Points => Num_Points);
   end Get_Da;

   -------------------
   -- Set_Numpoints --
   -------------------

   procedure Set_Numpoints (Data : access Gtk_Plot_Data_Record; Num : Gint) is
      procedure Internal (Data : System.Address; Num : Gint);
      pragma Import (C, Internal, "gtk_plot_data_set_numpoints");
   begin
      Internal (Get_Object (Data), Num);
   end Set_Numpoints;

   -------------------
   -- Get_Numpoints --
   -------------------

   function Get_Numpoints (Data : access Gtk_Plot_Data_Record) return Gint is
      function Internal (Data : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_plot_data_get_numpoints");
   begin
      return Internal (Get_Object (Data));
   end Get_Numpoints;

   ----------------
   -- Set_Labels --
   ----------------

   procedure Set_Labels
     (Data : access Gtk_Plot_Data_Record;
      Labels : Gtkada.Types.Chars_Ptr_Array)
   is
      procedure Internal (Data : System.Address; Labels : Chars_Ptr_Array);
      pragma Import (C, Internal, "gtk_plot_data_set_labels");
   begin
      Internal (Get_Object (Data), Labels);
   end Set_Labels;

   ----------------
   -- Get_Labels --
   ----------------

   function Get_Labels (Data : access Gtk_Plot_Data_Record)
      return Gtkada.Types.Chars_Ptr_Array
   is
      type Str_Array is array (Natural) of Chars_Ptr;
      type Str_Array_Access is access all Str_Array;
      pragma Convention (C, Str_Array_Access);

      function Internal (Data : System.Address) return Str_Array_Access;
      pragma Import (C, Internal, "gtk_plot_data_get_labels");

      N : constant size_t := size_t (Get_Numpoints (Data));

   begin
      return Chars_Ptr_Array
        (Internal (Get_Object (Data))(0 .. Integer (N) - 1));
   end Get_Labels;

   -----------------
   -- Show_Labels --
   -----------------

   procedure Show_Labels
     (Data : access Gtk_Plot_Data_Record; Show : Boolean)
   is
      procedure Internal (Data : System.Address; Show : Gint);
      pragma Import (C, Internal, "gtk_plot_data_show_labels");
   begin
      Internal (Get_Object (Data), Boolean'Pos (Show));
   end Show_Labels;

   ---------------------------
   -- Labels_Set_Attributes --
   ---------------------------

   procedure Labels_Set_Attributes
     (Data : access Gtk_Plot_Data_Record;
      Font : String;
      Height : Gint;
      Angle  : Gint;
      Foreground : Gdk.Color.Gdk_Color;
      Background : Gdk.Color.Gdk_Color)
   is
      procedure Internal
        (Data : System.Address;
         Font : String;
         Height, Angle : Gint;
         Foreground, Background : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_labels_set_attributes");

      F : aliased Gdk_Color := Foreground;
      B : aliased Gdk_Color := Background;
   begin
      Internal (Get_Object (Data), Font & ASCII.NUL, Height, Angle,
                F'Address, B'Address);
   end Labels_Set_Attributes;

   ----------------
   -- Set_Symbol --
   ----------------

   procedure Set_Symbol
     (Data         : access Gtk_Plot_Data_Record;
      The_Type     : Plot_Symbol_Type;
      Style        : Plot_Symbol_Style;
      Size         : Gint;
      Line_Width   : Gfloat;
      Color        : Gdk.Color.Gdk_Color;
      Border_Color : Gdk.Color.Gdk_Color)
   is
      procedure Internal
        (Data                  : System.Address;
         The_Type              : Plot_Symbol_Type;
         Style                 : Plot_Symbol_Style;
         Size                  : Gint;
         Line_Width            : Gfloat;
         Color, Border_Color   : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_symbol");

      C : aliased Gdk_Color := Color;
      B : aliased Gdk_Color := Border_Color;

   begin
      Internal
        (Get_Object (Data), The_Type, Style, Size,
         Line_Width, C'Address, B'Address);
   end Set_Symbol;

   ----------------
   -- Get_Symbol --
   ----------------

   procedure Get_Symbol
     (Data         : access Gtk_Plot_Data_Record;
      The_Type     : out Plot_Symbol_Type;
      Style        : out Plot_Symbol_Style;
      Size         : out Gint;
      Line_Width   : out Gint;
      Color        : out Gdk.Color.Gdk_Color;
      Border_Color : out Gdk.Color.Gdk_Color)
   is
      procedure Internal
        (Data         : System.Address;
         The_Type     : out Plot_Symbol_Type;
         Style        : out Plot_Symbol_Style;
         Size         : out Gint;
         Line_Width   : out Gint;
         Color        : System.Address;
         Border_Color : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_get_symbol");
      C, B : aliased Gdk_Color;
   begin
      Internal (Get_Object (Data), The_Type, Style, Size, Line_Width,
                C'Address, B'Address);
      Color := C;
      Border_Color := B;
   end Get_Symbol;

   -------------------
   -- Set_Connector --
   -------------------

   procedure Set_Connector
     (Data : access Gtk_Plot_Data_Record; Connector : Plot_Connector)
   is
      procedure Internal (Data : System.Address; Connector : Plot_Connector);
      pragma Import (C, Internal, "gtk_plot_data_set_connector");

   begin
      Internal (Get_Object (Data), Connector);
   end Set_Connector;

   -------------------
   -- Get_Connector --
   -------------------

   function Get_Connector (Data : access Gtk_Plot_Data_Record)
      return Plot_Connector
   is
      function Internal (Data : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_plot_data_get_connector");
   begin
      return Plot_Connector'Val (Internal (Get_Object (Data)));
   end Get_Connector;

   -------------------------
   -- Set_Line_Attributes --
   -------------------------

   procedure Set_Line_Attributes
     (Data  : access Gtk_Plot_Data_Record;
      Style : Plot_Line_Style;
      Width : Gfloat;
      Color : Gdk.Color.Gdk_Color)
   is
      procedure Internal
        (Data  : System.Address;
         Style : Plot_Line_Style;
         Width : Gfloat;
         Color : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_line_attributes");

      C : aliased Gdk_Color := Color;

   begin
      Internal (Get_Object (Data), Style, Width, C'Address);
   end Set_Line_Attributes;

   -------------------------
   -- Get_Line_Attributes --
   -------------------------

   procedure Get_Line_Attributes
     (Data  : access Gtk_Plot_Data_Record;
      Style : out Plot_Line_Style;
      Width : out Gfloat;
      Color : out Gdk.Color.Gdk_Color)
   is
      procedure Internal
        (Data  : System.Address;
         Style : out Plot_Line_Style;
         Width : out Gfloat;
         Color : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_get_line_attributes");
      C : aliased Gdk_Color;
   begin
      Internal (Get_Object (Data), Style, Width, C'Address);
      Color := C;
   end Get_Line_Attributes;

   ----------------------
   -- Set_X_Attributes --
   ----------------------

   procedure Set_X_Attributes
     (Data  : access Gtk_Plot_Data_Record;
      Style : Plot_Line_Style;
      Width : Gfloat;
      Color : Gdk.Color.Gdk_Color)
   is
      procedure Internal
        (Data  : System.Address;
         Style : Plot_Line_Style;
         Width : Gfloat;
         Color : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_x_attributes");

      C : aliased Gdk_Color := Color;

   begin
      Internal (Get_Object (Data), Style, Width, C'Address);
   end Set_X_Attributes;

   ----------------------
   -- Set_Y_Attributes --
   ----------------------

   procedure Set_Y_Attributes
     (Data  : access Gtk_Plot_Data_Record;
      Style : Plot_Line_Style;
      Width : Gfloat;
      Color : Gdk.Color.Gdk_Color)
   is
      procedure Internal
        (Data  : System.Address;
         Style : Plot_Line_Style;
         Width : Gfloat;
         Color : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_y_attributes");

      C : aliased Gdk_Color := Color;

   begin
      Internal (Get_Object (Data), Style, Width, C'Address);
   end Set_Y_Attributes;

   ----------------------
   -- Set_Z_Attributes --
   ----------------------

   procedure Set_Z_Attributes
     (Data  : access Gtk_Plot_Data_Record;
      Style : Plot_Line_Style;
      Width : Gfloat;
      Color : Gdk.Color.Gdk_Color)
   is
      procedure Internal
        (Data  : System.Address;
         Style : Plot_Line_Style;
         Width : Gfloat;
         Color : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_z_attributes");

      C : aliased Gdk_Color := Color;

   begin
      Internal (Get_Object (Data), Style, Width, C'Address);
   end Set_Z_Attributes;

   -------------------
   -- Show_Xerrbars --
   -------------------

   procedure Show_Xerrbars (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_show_xerrbars");
   begin
      Internal (Get_Object (Data));
   end Show_Xerrbars;

   -------------------
   -- Show_Yerrbars --
   -------------------

   procedure Show_Yerrbars (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_show_yerrbars");
   begin
      Internal (Get_Object (Data));
   end Show_Yerrbars;

   -------------------
   -- Show_Zerrbars --
   -------------------

   procedure Show_Zerrbars (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_show_zerrbars");
   begin
      Internal (Get_Object (Data));
   end Show_Zerrbars;

   -------------------
   -- Hide_Xerrbars --
   -------------------

   procedure Hide_Xerrbars (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_hide_xerrbars");
   begin
      Internal (Get_Object (Data));
   end Hide_Xerrbars;

   -------------------
   -- Hide_Yerrbars --
   -------------------

   procedure Hide_Yerrbars (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_hide_yerrbars");
   begin
      Internal (Get_Object (Data));
   end Hide_Yerrbars;

   -------------------
   -- Hide_Zerrbars --
   -------------------

   procedure Hide_Zerrbars (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_hide_zerrbars");
   begin
      Internal (Get_Object (Data));
   end Hide_Zerrbars;

   ---------------
   -- Fill_Area --
   ---------------

   procedure Fill_Area (Data : access Gtk_Plot_Data_Record; Fill : Boolean) is
      procedure Internal (Data : System.Address; Fill : Gint);
      pragma Import (C, Internal, "gtk_plot_data_fill_area");
   begin
      Internal (Get_Object (Data), Boolean'Pos (Fill));
   end Fill_Area;

   --------------------
   -- Area_Is_Filled --
   --------------------

   function Area_Is_Filled (Data : access Gtk_Plot_Data_Record)
      return Boolean
   is
      function Internal (Data : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_plot_data_area_is_filled");
   begin
      return Boolean'Val (Internal (Get_Object (Data)));
   end Area_Is_Filled;

   ----------------
   -- Set_Legend --
   ----------------

   procedure Set_Legend (Data : access Gtk_Plot_Data_Record; Legend : String)
   is
      procedure Internal (Data : System.Address; Legend : String);
      pragma Import (C, Internal, "gtk_plot_data_set_legend");
   begin
      Internal (Get_Object (Data), Legend & ASCII.NUL);
   end Set_Legend;

   -----------------
   -- Show_Legend --
   -----------------

   procedure Show_Legend (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_show_legend");
   begin
      Internal (Get_Object (Data));
   end Show_Legend;

   -----------------
   -- Hide_Legend --
   -----------------

   procedure Hide_Legend (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_hide_legend");
   begin
      Internal (Get_Object (Data));
   end Hide_Legend;

   --------------------------
   -- Set_Legend_Precision --
   --------------------------

   procedure Set_Legend_Precision
     (Data : access Gtk_Plot_Data_Record; Precision : Gint)
   is
      procedure Internal (Data : System.Address; Precision : Gint);
      pragma Import (C, Internal, "gtk_plot_data_set_legend_precision");
   begin
      Internal (Get_Object (Data), Precision);
   end Set_Legend_Precision;

   --------------------------
   -- Get_Legend_Precision --
   --------------------------

   function Get_Legend_Precision (Data : access Gtk_Plot_Data_Record)
      return Gint
   is
      function Internal (Data : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_plot_data_get_legend_precision");
   begin
      return Internal (Get_Object (Data));
   end Get_Legend_Precision;

   -----------------------
   -- Set_Gradient_Mask --
   -----------------------

   procedure Set_Gradient_Mask
     (Data : access Gtk_Plot_Data_Record; Mask : Plot_Gradient)
   is
      procedure Internal (Data : System.Address; Mask : Plot_Gradient);
      pragma Import (C, Internal, "gtk_plot_data_set_gradient_mask");

   begin
      Internal (Get_Object (Data), Mask);
   end Set_Gradient_Mask;

   -----------------------
   -- Get_Gradient_Mask --
   -----------------------

   function Get_Gradient_Mask (Data : access Gtk_Plot_Data_Record)
      return Plot_Gradient
   is
      function Internal (Data : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_plot_data_get_gradient_mask");
   begin
      return Plot_Gradient'Val (Internal (Get_Object (Data)));
   end Get_Gradient_Mask;

   --------------------------
   -- Gradient_Set_Visible --
   --------------------------

   procedure Gradient_Set_Visible
     (Data : access Gtk_Plot_Data_Record; Visible : Boolean)
   is
      procedure Internal (Data : System.Address; Visible : Gint);
      pragma Import (C, Internal, "gtk_plot_data_gradient_set_visible");
   begin
      Internal (Get_Object (Data), Boolean'Pos (Visible));
   end Gradient_Set_Visible;

   ----------------------
   -- Gradient_Visible --
   ----------------------

   function Gradient_Visible (Data : access Gtk_Plot_Data_Record)
      return Boolean
   is
      function Internal (Data : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_plot_data_gradient_visible");
   begin
      return Boolean'Val (Internal (Get_Object (Data)));
   end Gradient_Visible;

   -------------------------
   -- Set_Gradient_Colors --
   -------------------------

   procedure Set_Gradient_Colors
     (Data : access Gtk_Plot_Data_Record;
      Min, Max : Gdk.Color.Gdk_Color)
   is
      procedure Internal (Data, Min, Max : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_gradient_colors");
      Mi : aliased Gdk_Color := Min;
      Ma : aliased Gdk_Color := Max;
   begin
      Internal (Get_Object (Data), Mi'Address, Ma'Address);
   end Set_Gradient_Colors;

   -------------------------
   -- Get_Gradient_Colors --
   -------------------------

   procedure Get_Gradient_Colors
     (Data : access Gtk_Plot_Data_Record;
      Min, Max : out Gdk.Color.Gdk_Color)
   is
      procedure Internal (Data, Min, Max : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_get_gradient_colors");
      Mi, Ma : aliased Gdk_Color;
   begin
      Internal (Get_Object (Data), Mi'Address, Ma'Address);
      Min := Mi;
      Max := Ma;
   end Get_Gradient_Colors;

   ------------------
   -- Set_Gradient --
   ------------------

   procedure Set_Gradient
     (Data     : access Gtk_Plot_Data_Record;
      Min, Max : Gdouble;
      Nlevels  : Gint)
   is
      procedure Internal (Data : System.Address; Min, Max : Gdouble; N : Gint);
      pragma Import (C, Internal, "gtk_plot_data_set_gradient");
   begin
      Internal (Get_Object (Data), Min, Max, Nlevels);
   end Set_Gradient;

   ------------------
   -- Get_Gradient --
   ------------------

   procedure Get_Gradient
     (Data     : access Gtk_Plot_Data_Record;
      Min, Max : out Gdouble;
      Nlevels  : out Gint)
   is
      procedure Internal (Data : System.Address;
                          Min, Max : out Gdouble;
                          N : out Gint);
      pragma Import (C, Internal, "gtk_plot_data_get_gradient");
   begin
      Internal (Get_Object (Data), Min, Max, Nlevels);
   end Get_Gradient;

   ------------------------
   -- Get_Gradient_Level --
   ------------------------

   procedure Get_Gradient_Level
     (Data  : access Gtk_Plot_Data_Record;
      Level : Gdouble;
      Color : out Gdk.Color.Gdk_Color)
   is
      procedure Internal (Data : System.Address;
                          Level : Gdouble;
                          Color : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_get_gradient_level");
      C : aliased Gdk_Color;
   begin
      Internal (Get_Object (Data), Level, C'Address);
      Color := C;
   end Get_Gradient_Level;

   --------------
   -- Set_Link --
   --------------

   procedure Set_Link
     (Data : access Gtk_Plot_Data_Record;
      Link : System.Address)
   is
      procedure Internal (Data, Link : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_set_link");
   begin
      Internal (Get_Object (Data), Link);
   end Set_Link;

   --------------
   -- Get_Link --
   --------------

   function Get_Link (Data : access Gtk_Plot_Data_Record)
      return System.Address
   is
      function Internal (Data : System.Address) return System.Address;
      pragma Import (C, Internal, "gtk_plot_data_get_link");
   begin
      return Internal (Get_Object (Data));
   end Get_Link;

   -----------------
   -- Remove_Link --
   -----------------

   procedure Remove_Link (Data : access Gtk_Plot_Data_Record) is
      procedure Internal (Data : System.Address);
      pragma Import (C, Internal, "gtk_plot_data_remove_link");
   begin
      Internal (Get_Object (Data));
   end Remove_Link;
end Gtk.Extra.Plot_Data;
