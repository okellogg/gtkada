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
--  The Gtk.Entry_Buffer.Gtk_Entry_Buffer class contains the actual text
--  displayed in a Gtk.GEntry.Gtk_Entry widget.
--
--  A single Gtk.Entry_Buffer.Gtk_Entry_Buffer object can be shared by
--  multiple Gtk.GEntry.Gtk_Entry widgets which will then share the same text
--  content, but not the cursor position, visibility attributes, icon etc.
--
--  Gtk.Entry_Buffer.Gtk_Entry_Buffer may be derived from. Such a derived
--  class might allow text to be stored in an alternate location, such as
--  non-pageable memory, useful in the case of important passwords. Or a
--  derived class could integrate with an application's concept of undo/redo.
--
--  </description>

pragma Warnings (Off, "*is already use-visible*");
with Glib;            use Glib;
with Glib.Object;     use Glib.Object;
with Glib.Properties; use Glib.Properties;

package Gtk.Entry_Buffer is

   type Gtk_Entry_Buffer_Record is new GObject_Record with null record;
   type Gtk_Entry_Buffer is access all Gtk_Entry_Buffer_Record'Class;

   ------------------
   -- Constructors --
   ------------------

   procedure Gtk_New
      (Self            : out Gtk_Entry_Buffer;
       Initial_Chars   : UTF8_String := "";
       N_Initial_Chars : Gint);
   procedure Initialize
      (Self            : not null access Gtk_Entry_Buffer_Record'Class;
       Initial_Chars   : UTF8_String := "";
       N_Initial_Chars : Gint);
   --  Create a new GtkEntryBuffer object.
   --  Optionally, specify initial text to set in the buffer.
   --  Since: gtk+ 2.18
   --  "initial_chars": initial buffer text, or NULL
   --  "n_initial_chars": number of characters in Initial_Chars, or -1

   function Get_Type return Glib.GType;
   pragma Import (C, Get_Type, "gtk_entry_buffer_get_type");

   -------------
   -- Methods --
   -------------

   function Delete_Text
      (Self     : not null access Gtk_Entry_Buffer_Record;
       Position : Guint;
       N_Chars  : Gint) return Guint;
   --  Deletes a sequence of characters from the buffer. N_Chars characters
   --  are deleted starting at Position. If N_Chars is negative, then all
   --  characters until the end of the text are deleted.
   --  If Position or N_Chars are out of bounds, then they are coerced to sane
   --  values.
   --  Note that the positions are specified in characters, not bytes.
   --  Since: gtk+ 2.18
   --  "position": position at which to delete text
   --  "n_chars": number of characters to delete

   procedure Emit_Deleted_Text
      (Self     : not null access Gtk_Entry_Buffer_Record;
       Position : Guint;
       N_Chars  : Guint);
   --  Used when subclassing Gtk.Entry_Buffer.Gtk_Entry_Buffer
   --  Since: gtk+ 2.18
   --  "position": position at which text was deleted
   --  "n_chars": number of characters deleted

   procedure Emit_Inserted_Text
      (Self     : not null access Gtk_Entry_Buffer_Record;
       Position : Guint;
       Chars    : UTF8_String;
       N_Chars  : Guint);
   --  Used when subclassing Gtk.Entry_Buffer.Gtk_Entry_Buffer
   --  Since: gtk+ 2.18
   --  "position": position at which text was inserted
   --  "chars": text that was inserted
   --  "n_chars": number of characters inserted

   function Get_Bytes
      (Self : not null access Gtk_Entry_Buffer_Record) return gsize;
   --  Retrieves the length in bytes of the buffer. See
   --  Gtk.Entry_Buffer.Get_Length.
   --  Since: gtk+ 2.18

   function Get_Length
      (Self : not null access Gtk_Entry_Buffer_Record) return Guint;
   --  Retrieves the length in characters of the buffer.
   --  Since: gtk+ 2.18

   function Get_Max_Length
      (Self : not null access Gtk_Entry_Buffer_Record) return Gint;
   procedure Set_Max_Length
      (Self       : not null access Gtk_Entry_Buffer_Record;
       Max_Length : Gint);
   --  Sets the maximum allowed length of the contents of the buffer. If the
   --  current contents are longer than the given length, then they will be
   --  truncated to fit.
   --  Since: gtk+ 2.18
   --  "max_length": the maximum length of the entry buffer, or 0 for no
   --  maximum. (other than the maximum length of entries.) The value passed in
   --  will be clamped to the range 0-65536.

   function Get_Text
      (Self : not null access Gtk_Entry_Buffer_Record) return UTF8_String;
   procedure Set_Text
      (Self    : not null access Gtk_Entry_Buffer_Record;
       Chars   : UTF8_String;
       N_Chars : Gint);
   --  Sets the text in the buffer.
   --  This is roughly equivalent to calling Gtk.Entry_Buffer.Delete_Text and
   --  Gtk.Entry_Buffer.Insert_Text.
   --  Note that N_Chars is in characters, not in bytes.
   --  Since: gtk+ 2.18
   --  "chars": the new text
   --  "n_chars": the number of characters in Text, or -1

   function Insert_Text
      (Self     : not null access Gtk_Entry_Buffer_Record;
       Position : Guint;
       Chars    : UTF8_String;
       N_Chars  : Gint) return Guint;
   --  Inserts N_Chars characters of Chars into the contents of the buffer, at
   --  position Position.
   --  If N_Chars is negative, then characters from chars will be inserted
   --  until a null-terminator is found. If Position or N_Chars are out of
   --  bounds, or the maximum buffer text length is exceeded, then they are
   --  coerced to sane values.
   --  Note that the position and length are in characters, not in bytes.
   --  Since: gtk+ 2.18
   --  "position": the position at which to insert text.
   --  "chars": the text to insert into the buffer.
   --  "n_chars": the length of the text in characters, or -1

   ----------------
   -- Properties --
   ----------------
   --  The following properties are defined for this widget. See
   --  Glib.Properties for more information on properties)
   --
   --  Name: Length_Property
   --  Type: Guint
   --  Flags: read-write
   --  The length (in characters) of the text in buffer.
   --
   --  Name: Max_Length_Property
   --  Type: Gint
   --  Flags: read-write
   --  The maximum length (in characters) of the text in the buffer.
   --
   --  Name: Text_Property
   --  Type: UTF8_String
   --  Flags: read-write
   --  The contents of the buffer.

   Length_Property : constant Glib.Properties.Property_Uint;
   Max_Length_Property : constant Glib.Properties.Property_Int;
   Text_Property : constant Glib.Properties.Property_String;

   -------------
   -- Signals --
   -------------
   --  The following new signals are defined for this widget:
   --
   --  "deleted-text"
   --     procedure Handler
   --       (Self     : access Gtk_Entry_Buffer_Record'Class;
   --        Position : Guint;
   --        N_Chars  : Guint);
   --    --  "position": the position the text was deleted at.
   --    --  "n_chars": The number of characters that were deleted.
   --  This signal is emitted after text is deleted from the buffer.
   --
   --  "inserted-text"
   --     procedure Handler
   --       (Self     : access Gtk_Entry_Buffer_Record'Class;
   --        Position : Guint;
   --        Chars    : UTF8_String;
   --        N_Chars  : Guint);
   --    --  "position": the position the text was inserted at.
   --    --  "chars": The text that was inserted.
   --    --  "n_chars": The number of characters that were inserted.
   --  This signal is emitted after text is inserted into the buffer.

   Signal_Deleted_Text : constant Glib.Signal_Name := "deleted-text";
   Signal_Inserted_Text : constant Glib.Signal_Name := "inserted-text";

private
   Length_Property : constant Glib.Properties.Property_Uint :=
     Glib.Properties.Build ("length");
   Max_Length_Property : constant Glib.Properties.Property_Int :=
     Glib.Properties.Build ("max-length");
   Text_Property : constant Glib.Properties.Property_String :=
     Glib.Properties.Build ("text");
end Gtk.Entry_Buffer;
