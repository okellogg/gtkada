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

with Gdk.GC;

package Gdk.Window.Gc is

   --  Because the Gdk.Gc package spec depends on the Gdk.Window package,
   --  the following services can not be moved in the parent package.

   procedure Copy_Area (Window        : in Gdk_Window;
                        Gc            : in Gdk.GC.Gdk_GC;
                        X             : in Gint;
                        Y             : in Gint;
                        Source_Window : in Gdk_Window;
                        Source_X      : in Gint;
                        Source_Y      : in Gint;
                        Width         : in Gint;
                        Height        : in Gint);

private
   pragma Import (C, Copy_Area, "gdk_window_copy_area");
end Gdk.Window.Gc;
