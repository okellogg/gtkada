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

with Gdk.Drawable;
with Gdk.GC;
with Gdk.Window;

package Gdk.Bitmap is

   subtype Gdk_Bitmap is Gdk.Drawable.Gdk_Drawable;

   Null_Bitmap : constant Gdk_Bitmap;

   procedure Gdk_New (Bitmap : out Gdk_Bitmap;
                      Window : in  Gdk.Window.Gdk_Window;
                      Width  : in  Gint;
                      Height : in  Gint);

   procedure Ref (Bitmap : in Gdk_Bitmap);

   procedure Unref (Bitmap : in out Gdk_Bitmap);
   --  This is the usual way to destroy a bitmap. The memory is freed when
   --  there is no more reference

   procedure Create_From_Data (Bitmap :    out Gdk_Bitmap;
                               Window : in     Gdk.Window.Gdk_Window;
                               Data   : in     String;
                               Width  : in     Gint;
                               Height : in     Gint);

   procedure Set_Clip_Mask (GC    : in Gdk.GC.Gdk_GC;
                            Mask  : in Gdk_Bitmap);
   --  If MASK is set to Null_Bitmap, then no clip_mask is used for drawing

private
   Null_Bitmap : constant Gdk_Bitmap := null;
   pragma Import (C, Ref, "gdk_bitmap_ref");
   pragma Import (C, Unref, "gdk_bitmap_unref");
   pragma Import (C, Set_Clip_Mask, "gdk_gc_set_clip_mask");
end Gdk.Bitmap;
