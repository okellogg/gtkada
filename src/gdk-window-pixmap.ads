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

with Gdk.Pixmap;

package Gdk.Window.Pixmap is

   procedure Set_Back_Pixmap (Window          : in Gdk_Window;
                              Pixmap          : in Gdk.Pixmap.Gdk_Pixmap;
                              Parent_Relative : in Gint);

   --  void          gdk_window_set_icon        (GdkWindow       *window,
   --                                            GdkWindow       *icon_window,
   --                                            GdkPixmap       *pixmap,
   --                                            GdkBitmap       *mask);
   --  void          gdk_window_set_icon_name   (GdkWindow       *window,
   --                                            gchar           *name);

private
   pragma Import (C, Set_Back_Pixmap, "gdk_window_set_back_pixmap");
end Gdk.Window.Pixmap;
