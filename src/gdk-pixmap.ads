-----------------------------------------------------------------------
--          GtkAda - Ada95 binding for the Gimp Toolkit              --
--                                                                   --
--                     Copyright (C) 1998-1999                       --
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

with Glib; use Glib;
with Gdk.Bitmap;
with Gdk.Color;
with Gdk.Drawable;
with Gdk.Window;
with Interfaces.C.Strings;

package Gdk.Pixmap is

   subtype Gdk_Pixmap is Gdk.Drawable.Gdk_Drawable;
   Null_Pixmap : constant Gdk_Pixmap;

   procedure Gdk_New (Pixmap :    out Gdk_Pixmap;
                      Window : in     Gdk.Window.Gdk_Window;
                      Width  : in     Gint;
                      Height : in     Gint;
                      Depth  : in     Gint := -1);
   --  Automatically reference the pixmap once
   --  If the depth is -1, the default depth for the window will be
   --  chosen

   procedure Ref (Pixmap : in Gdk_Pixmap);
   --  Adds a reference to a pixmap

   procedure Unref (Pixmap : in out Gdk_Pixmap);
   --  This is the usual way to destroy a pixmap. The memory is freed when
   --  there is no more reference

   procedure Create_From_Data (Pixmap :    out Gdk_Pixmap;
                               Window : in     Gdk.Window.Gdk_Window;
                               Data   : in     String;
                               Width  : in     Gint;
                               Height : in     Gint;
                               Depth  : in     Gint;
                               Fg     : in     Color.Gdk_Color;
                               Bg     : in     Color.Gdk_Color);

   procedure Create_From_Xpm (Pixmap      :    out Gdk_Pixmap;
                              Window      : in     Gdk.Window.Gdk_Window;
                              Mask        : in out Gdk.Bitmap.Gdk_Bitmap;
                              Transparent : in     Gdk.Color.Gdk_Color;
                              Filename    : in     String);

   procedure Create_From_Xpm (Pixmap      :    out Gdk_Pixmap;
                              Window      : in     Gdk.Window.Gdk_Window;
                              Colormap    : in     Gdk.Color.Gdk_Colormap;
                              Mask        : in out Gdk.Bitmap.Gdk_Bitmap;
                              Transparent : in     Gdk.Color.Gdk_Color;
                              Filename    : in     String);

   procedure Create_From_Xpm_D
     (Pixmap      :    out Gdk_Pixmap;
      Window      : in     Gdk.Window.Gdk_Window;
      Mask        : in out Gdk.Bitmap.Gdk_Bitmap;
      Transparent : in     Gdk.Color.Gdk_Color;
      Data        : in     Interfaces.C.Strings.chars_ptr_array);
   --
   --  FIXME: There should be a better type than chars_ptr_array...

   procedure Create_From_Xpm_D
     (Pixmap      :    out Gdk_Pixmap;
      Window      : in     Gdk.Window.Gdk_Window;
      Colormap    : in     Gdk.Color.Gdk_Colormap;
      Mask        : in out Gdk.Bitmap.Gdk_Bitmap;
      Transparent : in     Gdk.Color.Gdk_Color;
      Data        : in     Interfaces.C.Strings.chars_ptr_array);
   --
   --  FIXME: There should be a better type than chars_ptr_array...


private
   Null_Pixmap : constant Gdk_Pixmap := null;
   pragma Import (C, Ref, "gdk_pixmap_ref");
   pragma Import (C, Unref, "gdk_pixmap_unref");
end Gdk.Pixmap;
