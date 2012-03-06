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
--  <description>
--  The frame widget is a Bin that surrounds its child with a decorative frame
--  and an optional label. If present, the label is drawn in a gap in the top
--  side of the frame. The position of the label can be controlled with
--  Gtk.Frame.Set_Label_Align.
--
--  == GtkFrame as GtkBuildable ==
--
--  The GtkFrame implementation of the GtkBuildable interface supports placing
--  a child in the label position by specifying "label" as the "type" attribute
--  of a <child> element. A normal content child can be specified without
--  specifying a <child> type attribute.
--
--  == A UI definition fragment with GtkFrame ==
--
--    <object class="GtkFrame">
--    <child type="label">
--    <object class="GtkLabel" id="frame-label"/>
--    </child>
--    <child>
--    <object class="GtkEntry" id="frame-content"/>
--    </child>
--    </object>
--  </description>
--  <description>
--  This is a very convenient widget to visually group related widgets (like
--  groups of buttons for instance), possibly with a title to explain the
--  purpose of this group.
--
--  A Gtk_Frame has only one child, so you have to put a container like for
--  instance a Gtk_Box inside if you want the frame to surround multiple
--  widgets.
--
--  </description>
--  <screenshot>gtk-frame</screenshot>
--  <group>Ornaments</group>
--  <testgtk>create_frame.adb</testgtk>

pragma Warnings (Off, "*is already use-visible*");
with Glib;            use Glib;
with Glib.Properties; use Glib.Properties;
with Glib.Types;      use Glib.Types;
with Gtk.Bin;         use Gtk.Bin;
with Gtk.Buildable;   use Gtk.Buildable;
with Gtk.Enums;       use Gtk.Enums;
with Gtk.Widget;      use Gtk.Widget;

package Gtk.Frame is

   type Gtk_Frame_Record is new Gtk_Bin_Record with null record;
   type Gtk_Frame is access all Gtk_Frame_Record'Class;

   ------------------
   -- Constructors --
   ------------------

   procedure Gtk_New (Frame : out Gtk_Frame; Label : UTF8_String := "");
   procedure Initialize
      (Frame : not null access Gtk_Frame_Record'Class;
       Label : UTF8_String := "");
   --  Creates a new Gtk.Frame.Gtk_Frame, with optional label Label. If Label
   --  is NULL, the label is omitted.
   --  "label": the text to use as the label of the frame

   function Get_Type return Glib.GType;
   pragma Import (C, Get_Type, "gtk_frame_get_type");

   -------------
   -- Methods --
   -------------

   function Get_Label
      (Frame : not null access Gtk_Frame_Record) return UTF8_String;
   procedure Set_Label
      (Frame : not null access Gtk_Frame_Record;
       Label : UTF8_String := "");
   --  Sets the text of the label. If Label is NULL, the current label is
   --  removed.
   --  "label": the text to use as the label of the frame

   procedure Get_Label_Align
      (Frame  : not null access Gtk_Frame_Record;
       Xalign : out Gfloat;
       Yalign : out Gfloat);
   procedure Set_Label_Align
      (Frame  : not null access Gtk_Frame_Record;
       Xalign : Gfloat;
       Yalign : Gfloat);
   --  Sets the alignment of the frame widget's label. The default values for
   --  a newly created frame are 0.0 and 0.5.
   --  "xalign": The position of the label along the top edge of the widget. A
   --  value of 0.0 represents left alignment; 1.0 represents right alignment.
   --  "yalign": The y alignment of the label. A value of 0.0 aligns under the
   --  frame; 1.0 aligns above the frame. If the values are exactly 0.0 or 1.0
   --  the gap in the frame won't be painted because the label will be
   --  completely above or below the frame.

   function Get_Label_Widget
      (Frame : not null access Gtk_Frame_Record)
       return Gtk.Widget.Gtk_Widget;
   procedure Set_Label_Widget
      (Frame        : not null access Gtk_Frame_Record;
       Label_Widget : not null access Gtk.Widget.Gtk_Widget_Record'Class);
   --  Sets the label widget for the frame. This is the widget that will
   --  appear embedded in the top edge of the frame as a title.
   --  "label_widget": the new label widget

   function Get_Shadow_Type
      (Frame : not null access Gtk_Frame_Record)
       return Gtk.Enums.Gtk_Shadow_Type;
   procedure Set_Shadow_Type
      (Frame    : not null access Gtk_Frame_Record;
       The_Type : Gtk.Enums.Gtk_Shadow_Type);
   --  Sets the shadow type for Frame.
   --  "type": the new Gtk.Enums.Gtk_Shadow_Type

   ---------------------------------------------
   -- Inherited subprograms (from interfaces) --
   ---------------------------------------------
   --  Methods inherited from the Buildable interface are not duplicated here
   --  since they are meant to be used by tools, mostly. If you need to call
   --  them, use an explicit cast through the "-" operator below.

   ----------------
   -- Interfaces --
   ----------------
   --  This class implements several interfaces. See Glib.Types
   --
   --  - "Buildable"

   package Implements_Buildable is new Glib.Types.Implements
     (Gtk.Buildable.Gtk_Buildable, Gtk_Frame_Record, Gtk_Frame);
   function "+"
     (Widget : access Gtk_Frame_Record'Class)
   return Gtk.Buildable.Gtk_Buildable
   renames Implements_Buildable.To_Interface;
   function "-"
     (Interf : Gtk.Buildable.Gtk_Buildable)
   return Gtk_Frame
   renames Implements_Buildable.To_Object;

   ----------------
   -- Properties --
   ----------------
   --  The following properties are defined for this widget. See
   --  Glib.Properties for more information on properties)
   --
   --  Name: Label_Property
   --  Type: UTF8_String
   --  Flags: read-write
   --
   --  Name: Label_Widget_Property
   --  Type: Gtk.Widget.Gtk_Widget
   --  Flags: read-write
   --
   --  Name: Label_Xalign_Property
   --  Type: Gfloat
   --  Flags: read-write
   --
   --  Name: Label_Yalign_Property
   --  Type: Gfloat
   --  Flags: read-write
   --
   --  Name: Shadow_Type_Property
   --  Type: Gtk.Enums.Gtk_Shadow_Type
   --  Flags: read-write

   Label_Property : constant Glib.Properties.Property_String;
   Label_Widget_Property : constant Glib.Properties.Property_Object;
   Label_Xalign_Property : constant Glib.Properties.Property_Float;
   Label_Yalign_Property : constant Glib.Properties.Property_Float;
   Shadow_Type_Property : constant Gtk.Enums.Property_Gtk_Shadow_Type;

private
   Label_Property : constant Glib.Properties.Property_String :=
     Glib.Properties.Build ("label");
   Label_Widget_Property : constant Glib.Properties.Property_Object :=
     Glib.Properties.Build ("label-widget");
   Label_Xalign_Property : constant Glib.Properties.Property_Float :=
     Glib.Properties.Build ("label-xalign");
   Label_Yalign_Property : constant Glib.Properties.Property_Float :=
     Glib.Properties.Build ("label-yalign");
   Shadow_Type_Property : constant Gtk.Enums.Property_Gtk_Shadow_Type :=
     Gtk.Enums.Build ("shadow-type");
end Gtk.Frame;
