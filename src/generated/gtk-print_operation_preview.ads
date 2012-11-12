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


pragma Warnings (Off, "*is already use-visible*");
with Glib;       use Glib;
with Glib.Types; use Glib.Types;

package Gtk.Print_Operation_Preview is

   type Gtk_Print_Operation_Preview is new Glib.Types.GType_Interface;

   ------------------
   -- Constructors --
   ------------------

   function Get_Type return Glib.GType;
   pragma Import (C, Get_Type, "gtk_print_operation_preview_get_type");

   -------------
   -- Methods --
   -------------

   procedure End_Preview (Preview : Gtk_Print_Operation_Preview);
   pragma Import (C, End_Preview, "gtk_print_operation_preview_end_preview");
   --  Ends a preview.
   --  This function must be called to finish a custom print preview.
   --  Since: gtk+ 2.10

   function Is_Selected
      (Preview : Gtk_Print_Operation_Preview;
       Page_Nr : Gint) return Boolean;
   --  Returns whether the given page is included in the set of pages that
   --  have been selected for printing.
   --  Since: gtk+ 2.10
   --  "page_nr": a page number

   procedure Render_Page
      (Preview : Gtk_Print_Operation_Preview;
       Page_Nr : Gint);
   pragma Import (C, Render_Page, "gtk_print_operation_preview_render_page");
   --  Renders a page to the preview, using the print context that was passed
   --  to the Gtk.Print_Operation.Gtk_Print_Operation::preview handler together
   --  with Preview.
   --  A custom iprint preview should use this function in its ::expose
   --  handler to render the currently selected page.
   --  Note that this function requires a suitable cairo context to be
   --  associated with the print context.
   --  Since: gtk+ 2.10
   --  "page_nr": the page to render

   -------------
   -- Signals --
   -------------
   --  The following new signals are defined for this widget:
   --
   --  "got-page-size"
   --     procedure Handler
   --       (Self       : access Gtk_Print_Operation_Preview;
   --        Context    : not null access Gtk.Print_Context.Gtk_Print_Context_Record'Class;
   --        Page_Setup : not null access Gtk.Page_Setup.Gtk_Page_Setup_Record'Class)
   --       ;
   --    --  "context": the current Gtk.Print_Context.Gtk_Print_Context
   --    --  "page_setup": the Gtk.Page_Setup.Gtk_Page_Setup for the current page
   --  The ::got-page-size signal is emitted once for each page that gets
   --  rendered to the preview.
   --
   --  A handler for this signal should update the Context according to
   --  Page_Setup and set up a suitable cairo context, using
   --  gtk_print_context_set_cairo_context.
   --
   --  "ready"
   --     procedure Handler
   --       (Self    : access Gtk_Print_Operation_Preview;
   --        Context : not null access Gtk.Print_Context.Gtk_Print_Context_Record'Class)
   --       ;
   --    --  "context": the current Gtk.Print_Context.Gtk_Print_Context
   --  The ::ready signal gets emitted once per preview operation, before the
   --  first page is rendered.
   --
   --  A handler for this signal can be used for setup tasks.

   Signal_Got_Page_Size : constant Glib.Signal_Name := "got-page-size";
   Signal_Ready : constant Glib.Signal_Name := "ready";

end Gtk.Print_Operation_Preview;