
with Gtk.Box;

package Gtk.Hbox is

   type Hbox is new Gtk.Box.Box with private;

   procedure Gtk_New (Widget      : out Hbox;
                      Homogeneous : in Boolean;
                      Spacing     : in GInt);
   --  mapping: New gtkhbox.h gtk_hbox_new


private

   type Hbox is new Gtk.Box.Box with null record;

end Gtk.Hbox;
