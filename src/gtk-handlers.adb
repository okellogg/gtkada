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

with Unchecked_Conversion;
with Unchecked_Deallocation;
with Gtk.Object; use Gtk.Object;
with System;

package body Gtk.Handlers is

   function Do_Signal_Connect (Object     : in Gtk.Object.Gtk_Object;
                               Name       : in String;
                               Marshaller : in System.Address;
                               Func_Data  : in System.Address;
                               Destroy    : in System.Address;
                               After      : in Boolean)
                              return          Handler_Id;
   --  Internal function used to connect the signal.

   -------------------
   -- Argument_Type --
   -------------------

   function Argument_Type
     (The_Type : Gtk_Type; Name : in String; Num : in Gint) return Gtk_Type
   is
      function Internal
        (The_Type : Gtk_Type; Name : String; Num  : Gint) return Gtk_Type;
      pragma Import (C, Internal, "ada_signal_argument_type");
   begin
      return Internal (The_Type, Name & ASCII.Nul, Num);
   end Argument_Type;

   ---------------------
   -- Count_Arguments --
   ---------------------

   function Count_Arguments
     (The_Type : Gtk_Type; Name : in String) return Guint
   is
      function Internal (The_Type : Gtk_Type; Name : String) return Guint;
      pragma Import (C, Internal, "ada_signal_count_arguments");

   begin
      return Internal (The_Type, Name & ASCII.Nul);
   end Count_Arguments;

   -----------------------
   -- Do_Signal_Connect --
   -----------------------

   function Do_Signal_Connect (Object     : in Gtk.Object.Gtk_Object;
                               Name       : in String;
                               Marshaller : in System.Address;
                               Func_Data  : in System.Address;
                               Destroy    : in System.Address;
                               After      : in Boolean)
                              return Handler_Id
   is
      function Internal (Object        : System.Address;
                         Name          : String;
                         Func          : System.Address;
                         Marshaller    : System.Address;
                         Func_Data     : System.Address;
                         Destroy       : System.Address;
                         Object_Signal : Gint;
                         After         : Gint)
                         return Handler_Id;
      pragma Import (C, Internal, "gtk_signal_connect_full");
   begin
      return Internal (Get_Object (Object.all),
                       Name & Ascii.NUL,
                       System.Null_Address,
                       Marshaller,
                       Func_Data,
                       Destroy,
                       Boolean'Pos (False),
                       Boolean'Pos (After));
   end Do_Signal_Connect;

   ---------------------
   -- Return_Callback --
   ---------------------

   package body Return_Callback is

      function To_Handler is new Unchecked_Conversion
        (Gtk.Marshallers.General_Handler, Handler);
      function To_General_Handler is new Unchecked_Conversion
        (Handler, Gtk.Marshallers.General_Handler);

      procedure Set_Return_Value (Typ    : Gtk_Type;
                                  Value  : Return_Type;
                                  Params : System.Address;
                                  Num    : Guint);
      pragma Import (C, Set_Return_Value, "ada_set_return_value");
      --  Function used internally to specify the value returned by a
      --  callback.  In the gtk+ convention, such return values should go as
      --  the last element in Params (which is a GtkArg*).  Typ is the C type
      --  (matches the constants GTK_TYPE_INT, ...).  Num is the position in
      --  Params where the value should be put.

      type Acc is access all Widget_Type'Class;
      --  This type has to be declared at library level, otherwise
      --  Program_Error might be raised when trying to cast from the
      --  parameter of Marshaller to another type.

      type Data_Type_Record is record
         Func     : Handler;             --  User's callback
         Marsh    : Marshallers.Handler_Proxy := null;  -- Handler_Proxy to use
         Object   : Acc        := null;  --  Slot Object for Object_Connect
         Ret_Type : Gtk_Type;            --  The C constant used to indicate
         --                              --  the return type.
      end record;
      type Data_Type_Access is access all Data_Type_Record;
      pragma Convention (C, Data_Type_Access);
      --  Data passed to the C handler

      function Convert is new Unchecked_Conversion
        (Data_Type_Access, System.Address);
      function Convert is new Unchecked_Conversion
        (System.Address, Data_Type_Access);

      procedure Free_Data (Data : in System.Address);
      pragma Convention (C, Free_Data);
      --  Free the memory associated with the callback's data

      procedure First_Marshaller (Object    : in System.Address;
                                  User_Data : in System.Address;
                                  Nparams   : in Guint;
                                  Params    : in System.Address);
      pragma Convention (C, First_Marshaller);
      --  First level marshaller. This is the function that is actually
      --  called by gtk+. It then calls the Ada functions as required.

      -------------
      -- Connect --
      -------------

      procedure Connect
        (Widget  : access Widget_Type'Class;
         Name    : in     String;
         Marsh   : in     Marshallers.Marshaller;
         After   : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Connect (Widget, Name, Marsh, After);
      end Connect;

      --------------------
      -- Object_Connect --
      --------------------

      procedure Object_Connect
        (Widget      : access Gtk.Object.Gtk_Object_Record'Class;
         Name        : in     String;
         Marsh       : in     Marshallers.Marshaller;
         Slot_Object : access Widget_Type'Class;
         After       : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Object_Connect (Widget, Name, Marsh, Slot_Object, After);
      end Object_Connect;

      -------------
      -- Connect --
      -------------

      procedure Connect
        (Widget  : access Widget_Type'Class;
         Name    : in     String;
         Cb      : in     Handler;
         After   : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Connect (Widget, Name, Cb, After);
      end Connect;

      --------------------
      -- Object_Connect --
      --------------------

      procedure Object_Connect
        (Widget      : access Gtk.Object.Gtk_Object_Record'Class;
         Name        : in     String;
         Cb          : in     Handler;
         Slot_Object : access Widget_Type'Class;
         After       : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Object_Connect (Widget, Name, Cb, Slot_Object, After);
      end Object_Connect;

      ---------------
      -- Free_Data --
      ---------------

      procedure Free_Data (Data : in System.Address) is
         procedure Internal is new Unchecked_Deallocation
           (Data_Type_Record, Data_Type_Access);
         D : Data_Type_Access := Convert (Data);
      begin
         Internal (D);
      end Free_Data;

      ----------------------
      -- First_Marshaller --
      ----------------------

      procedure First_Marshaller (Object    : in System.Address;
                                  User_Data : in System.Address;
                                  Nparams   : in Guint;
                                  Params    : in System.Address)
      is
         use type Marshallers.Handler_Proxy;

         Data  : Data_Type_Access := Convert (User_Data);
         Stub  : Widget_Type;
         Value : Return_Type;
      begin
         if Data.Func = null then
            return;
         end if;

         if Data.Object = null then
            if Data.Marsh /= null then
               Value := Data.Marsh (Acc (Get_User_Data (Object, Stub)),
                                    Gtk.Arguments.Make_Args (Nparams, Params),
                                    To_General_Handler (Data.Func));
            else
               Value := Data.Func (Acc (Get_User_Data (Object, Stub)),
                                   Gtk.Arguments.Make_Args (Nparams, Params));
            end if;
         else
            if Data.Marsh /= null then
               Value := Data.Marsh (Data.Object,
                                    Gtk.Arguments.Make_Args (Nparams, Params),
                                    To_General_Handler (Data.Func));
            else
               Value := Data.Func
                 (Data.Object, Gtk.Arguments.Make_Args (Nparams, Params));
            end if;
         end if;

         --  Insert the value into the Params array, as expected.
         Set_Return_Value (Data.Ret_Type, Value, Params, Nparams);
      end First_Marshaller;

      -------------
      -- Connect --
      -------------

      function Connect
        (Widget  : access Widget_Type'Class;
         Name    : in     String;
         Marsh   : in     Marshallers.Marshaller;
         After   : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func     => To_Handler (Marsh.Func),
                                 Marsh    => Marsh.Marsh,
                                 Object   => null,
                                 Ret_Type => Argument_Type (Get_Type (Widget),
                                                            Name,
                                                            -1));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) /= Gtk_Type_None,
            "Handlers for this signal should not return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Connect;

      --------------------
      -- Object_Connect --
      --------------------

      function Object_Connect
        (Widget      : access Gtk.Object.Gtk_Object_Record'Class;
         Name        : in     String;
         Marsh       : in     Marshallers.Marshaller;
         Slot_Object : access Widget_Type'Class;
         After       : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func     => To_Handler (Marsh.Func),
                                 Marsh    => Marsh.Marsh,
                                 Object   => Acc (Slot_Object),
                                 Ret_Type => Argument_Type
                                   (Gtk.Object.Get_Type (Widget),
                                    Name,
                                    -1));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) /= Gtk_Type_None,
            "Handlers for this signal should not return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Object_Connect;

      -------------
      -- Connect --
      -------------

      function Connect
        (Widget  : access Widget_Type'Class;
         Name    : in     String;
         Cb      : in     Handler;
         After   : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func     => Cb,
                                 Marsh    => null,
                                 Object   => null,
                                 Ret_Type => Argument_Type (Get_Type (Widget),
                                                            Name,
                                                            -1));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) /= Gtk_Type_None,
            "Handlers for this signal should not return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Connect;

      --------------------
      -- Object_Connect --
      --------------------

      function Object_Connect
        (Widget      : access Gtk.Object.Gtk_Object_Record'Class;
         Name        : in     String;
         Cb          : in     Handler;
         Slot_Object : access Widget_Type'Class;
         After       : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func     => Cb,
                                 Marsh    => null,
                                 Object   => Acc (Slot_Object),
                                 Ret_Type => Argument_Type
                                    (Gtk.Object.Get_Type (Widget),
                                     Name,
                                     -1));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) /= Gtk_Type_None,
            "Handlers for this signal should not return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Object_Connect;

   end Return_Callback;


   --------------------------
   -- User_Return_Callback --
   --------------------------

   package body User_Return_Callback is

      function To_Handler is new Unchecked_Conversion
        (Gtk.Marshallers.General_Handler, Handler);
      function To_General_Handler is new Unchecked_Conversion
        (Handler, Gtk.Marshallers.General_Handler);

      procedure Set_Return_Value (Typ    : Gtk_Type;
                                  Value  : Return_Type;
                                  Params : System.Address;
                                  Num    : Guint);
      pragma Import (C, Set_Return_Value, "ada_set_return_value");
      --  Function used internally to specify the value returned by a
      --  callback.  In the gtk+ convention, such return values should go as
      --  the last element in Params (which is a GtkArg*).  Typ is the C type
      --  (matches the constants GTK_TYPE_INT, ...).  Num is the position in
      --  Params where the value should be put.

      type Acc is access all Widget_Type'Class;
      --  This type has to be declared at library level, otherwise
      --  Program_Error might be raised when trying to cast from the
      --  parameter of Marshaller to another type.

      type User_Access is access User_Type;
      type Data_Type_Record is record
         Func     : Handler;             --  User's callback
         Marsh    : Marshallers.Handler_Proxy := null; --  Handler_Proxy to use
         User     : User_Access  := null;
         Ret_Type : Gtk_Type;            --  The C constant used to indicate
         --                              --  the return type.
      end record;
      type Data_Type_Access is access all Data_Type_Record;
      pragma Convention (C, Data_Type_Access);
      --  Data passed to the C handler

      function Convert is new Unchecked_Conversion
        (Data_Type_Access, System.Address);
      function Convert is new Unchecked_Conversion
        (System.Address, Data_Type_Access);

      procedure Free_Data (Data : in System.Address);
      pragma Convention (C, Free_Data);
      --  Free the memory associated with the callback's data

      procedure First_Marshaller (Object    : in System.Address;
                                  User_Data : in System.Address;
                                  Nparams   : in Guint;
                                  Params    : in System.Address);
      pragma Convention (C, First_Marshaller);
      --  First level marshaller. This is the function that is actually
      --  called by gtk+. It then calls the Ada functions as required.

      ---------------
      -- Free_Data --
      ---------------

      procedure Free_Data (Data : in System.Address) is
         procedure Internal is new Unchecked_Deallocation
           (Data_Type_Record, Data_Type_Access);
         procedure Internal2 is new Unchecked_Deallocation
           (User_Type, User_Access);
         D : Data_Type_Access := Convert (Data);
      begin
         Internal2 (D.User);
         Internal (D);
      end Free_Data;

      ----------------------
      -- First_Marshaller --
      ----------------------

      procedure First_Marshaller (Object    : in System.Address;
                                  User_Data : in System.Address;
                                  Nparams   : in Guint;
                                  Params    : in System.Address)
      is
         use type Marshallers.Handler_Proxy;

         Data  : Data_Type_Access := Convert (User_Data);
         Stub  : Widget_Type;
         Value : Return_Type;
      begin
         if Data.Func = null then
            return;
         end if;

         if Data.Marsh /= null then
            Value := Data.Marsh (Acc (Get_User_Data (Object, Stub)),
                                 Gtk.Arguments.Make_Args (Nparams, Params),
                                 To_General_Handler (Data.Func),
                                 Data.User.all);
         else
            Value := Data.Func (Acc (Get_User_Data (Object, Stub)),
                                Gtk.Arguments.Make_Args (Nparams, Params),
                                Data.User.all);
         end if;
         --  Insert the value into the Params array, as expected.
         Set_Return_Value (Data.Ret_Type, Value, Params, Nparams);
      end First_Marshaller;

      -------------
      -- Connect --
      -------------

      procedure Connect
        (Widget    : access Widget_Type'Class;
         Name      : in     String;
         Marsh     : in     Marshallers.Marshaller;
         User_Data : in     User_Type;
         After     : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Connect (Widget, Name, Marsh, User_Data, After);
      end Connect;

      -------------
      -- Connect --
      -------------

      procedure Connect
        (Widget    : access Widget_Type'Class;
         Name      : in     String;
         Cb        : in     Handler;
         User_Data : in     User_Type;
         After     : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Connect (Widget, Name, Cb, User_Data, After);
      end Connect;

      -------------
      -- Connect --
      -------------

      function Connect
        (Widget    : access Widget_Type'Class;
         Name      : in     String;
         Marsh     : in     Marshallers.Marshaller;
         User_Data : in     User_Type;
         After     : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func     => To_Handler (Marsh.Func),
                                 Marsh    => Marsh.Marsh,
                                 User     => new User_Type'(User_Data),
                                 Ret_Type => Argument_Type
                                   (Get_Type (Widget),
                                    Name,
                                    -1));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) /= Gtk_Type_None,
            "Handlers for this signal should not return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Connect;

      -------------
      -- Connect --
      -------------

      function Connect
        (Widget    : access Widget_Type'Class;
         Name      : in     String;
         Cb        : in     Handler;
         User_Data : in     User_Type;
         After     : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func     => Cb,
                                 Marsh    => null,
                                 User     => new User_Type'(User_Data),
                                 Ret_Type => Argument_Type
                                   (Get_Type (Widget),
                                    Name,
                                    -1));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) /= Gtk_Type_None,
            "Handlers for this signal should not return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Connect;

   end User_Return_Callback;

   --------------
   -- Callback --
   --------------

   package body Callback is

      function To_Handler is new Unchecked_Conversion
        (Gtk.Marshallers.General_Handler, Handler);
      function To_General_Handler is new Unchecked_Conversion
        (Handler, Gtk.Marshallers.General_Handler);

      type Acc is access all Widget_Type'Class;
      --  This type has to be declared at library level, otherwise
      --  Program_Error might be raised when trying to cast from the
      --  parameter of Marshaller to another type.

      type Data_Type_Record is record
         Func   : Handler;             --  User's callback
         Marsh  : Marshallers.Handler_Proxy := null;  --  Handler_Proxy to use
         Object : Acc        := null;  --  Slot Object for Object_Connect
      end record;
      type Data_Type_Access is access all Data_Type_Record;
      pragma Convention (C, Data_Type_Access);
      --  Data passed to the C handler

      function Convert is new Unchecked_Conversion
        (Data_Type_Access, System.Address);
      function Convert is new Unchecked_Conversion
        (System.Address, Data_Type_Access);

      procedure Free_Data (Data : in System.Address);
      pragma Convention (C, Free_Data);
      --  Free the memory associated with the callback's data

      procedure First_Marshaller (Object    : in System.Address;
                                  User_Data : in System.Address;
                                  Nparams   : in Guint;
                                  Params    : in System.Address);
      pragma Convention (C, First_Marshaller);
      --  First level marshaller. This is the function that is actually
      --  called by gtk+. It then calls the Ada functions as required.

      ---------------
      -- Free_Data --
      ---------------

      procedure Free_Data (Data : in System.Address) is
         procedure Internal is new Unchecked_Deallocation
           (Data_Type_Record, Data_Type_Access);
         D : Data_Type_Access := Convert (Data);
      begin
         Internal (D);
      end Free_Data;

      ----------------------
      -- First_Marshaller --
      ----------------------

      procedure First_Marshaller (Object    : in System.Address;
                                  User_Data : in System.Address;
                                  Nparams   : in Guint;
                                  Params    : in System.Address)
      is
         use type Marshallers.Handler_Proxy;

         Data : Data_Type_Access := Convert (User_Data);
         Stub : Widget_Type;
      begin
         if Data.Func = null then
            return;
         end if;

         if Data.Object = null then
            if Data.Marsh /= null then
               Data.Marsh (Acc (Get_User_Data (Object, Stub)),
                           Gtk.Arguments.Make_Args (Nparams, Params),
                           To_General_Handler (Data.Func));
            else
               Data.Func (Acc (Get_User_Data (Object, Stub)),
                          Gtk.Arguments.Make_Args (Nparams, Params));
            end if;
         else
            if Data.Marsh /= null then
               Data.Marsh (Data.Object,
                           Gtk.Arguments.Make_Args (Nparams, Params),
                           To_General_Handler (Data.Func));
            else
               Data.Func (Data.Object,
                          Gtk.Arguments.Make_Args (Nparams, Params));
            end if;
         end if;
      end First_Marshaller;

      -------------
      -- Connect --
      -------------

      procedure Connect
        (Widget  : access Widget_Type'Class;
         Name    : in     String;
         Marsh   : in     Marshallers.Marshaller;
         After   : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Connect (Widget, Name, Marsh, After);
      end Connect;

      --------------------
      -- Object_Connect --
      --------------------

      procedure Object_Connect
        (Widget      : access Gtk.Object.Gtk_Object_Record'Class;
         Name        : in     String;
         Marsh       : in     Marshallers.Marshaller;
         Slot_Object : access Widget_Type'Class;
         After       : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Object_Connect (Widget, Name, Marsh, Slot_Object, After);
      end Object_Connect;

      -------------
      -- Connect --
      -------------

      procedure Connect
        (Widget  : access Widget_Type'Class;
         Name    : in     String;
         Cb      : in     Handler;
         After   : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Connect (Widget, Name, Cb, After);
      end Connect;

      --------------------
      -- Object_Connect --
      --------------------

      procedure Object_Connect
        (Widget      : access Gtk.Object.Gtk_Object_Record'Class;
         Name        : in     String;
         Cb          : in     Handler;
         Slot_Object : access Widget_Type'Class;
         After       : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Object_Connect (Widget, Name, Cb, Slot_Object, After);
      end Object_Connect;

      -------------
      -- Connect --
      -------------

      function Connect
        (Widget  : access Widget_Type'Class;
         Name    : in     String;
         Marsh   : in     Marshallers.Marshaller;
         After   : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func  => To_Handler (Marsh.Func),
                                 Marsh => Marsh.Marsh,
                                 Object => null);
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) = Gtk_Type_None,
            "Handlers for this signal should return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Connect;

      --------------------
      -- Object_Connect --
      --------------------

      function Object_Connect
        (Widget      : access Gtk.Object.Gtk_Object_Record'Class;
         Name        : in     String;
         Marsh       : in     Marshallers.Marshaller;
         Slot_Object : access Widget_Type'Class;
         After       : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func  => To_Handler (Marsh.Func),
                                 Marsh => Marsh.Marsh,
                                 Object => Acc (Slot_Object));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) = Gtk_Type_None,
            "Handlers for this signal should return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Object_Connect;

      -------------
      -- Connect --
      -------------

      function Connect
        (Widget  : access Widget_Type'Class;
         Name    : in     String;
         Cb      : in     Handler;
         After   : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func   => Cb,
                                 Marsh  => null,
                                 Object => null);
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) = Gtk_Type_None,
            "Handlers for this signal should return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Connect;

      --------------------
      -- Object_Connect --
      --------------------

      function Object_Connect
        (Widget      : access Gtk.Object.Gtk_Object_Record'Class;
         Name        : in     String;
         Cb          : in     Handler;
         Slot_Object : access Widget_Type'Class;
         After       : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func   => Cb,
                                 Marsh  => null,
                                 Object => Acc (Slot_Object));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) = Gtk_Type_None,
            "Handlers for this signal should return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Object_Connect;

   end Callback;

   -------------------
   -- User_Callback --
   -------------------

   package body User_Callback is


      function To_Handler is new Unchecked_Conversion
        (Gtk.Marshallers.General_Handler, Handler);
      function To_General_Handler is new Unchecked_Conversion
        (Handler, Gtk.Marshallers.General_Handler);

      type Acc is access all Widget_Type'Class;
      --  This type has to be declared at library level, otherwise
      --  Program_Error might be raised when trying to cast from the
      --  parameter of Marshaller to another type.

      type User_Access is access User_Type;
      type Data_Type_Record is record
         Func   : Handler;             --  User's callback
         Marsh  : Marshallers.Handler_Proxy := null;  --  Handler_Proxy to use
         User   : User_Access := null;
      end record;
      type Data_Type_Access is access all Data_Type_Record;
      pragma Convention (C, Data_Type_Access);
      --  Data passed to the C handler

      function Convert is new Unchecked_Conversion
        (Data_Type_Access, System.Address);
      function Convert is new Unchecked_Conversion
        (System.Address, Data_Type_Access);

      procedure Free_Data (Data : in System.Address);
      pragma Convention (C, Free_Data);
      --  Free the memory associated with the callback's data

      procedure First_Marshaller (Object    : in System.Address;
                                  User_Data : in System.Address;
                                  Nparams   : in Guint;
                                  Params    : in System.Address);
      pragma Convention (C, First_Marshaller);
      --  First level marshaller. This is the function that is actually
      --  called by gtk+. It then calls the Ada functions as required.

      ---------------
      -- Free_Data --
      ---------------

      procedure Free_Data (Data : in System.Address) is
         procedure Internal is new Unchecked_Deallocation
           (Data_Type_Record, Data_Type_Access);
         procedure Internal2 is new Unchecked_Deallocation
           (User_Type, User_Access);
         D : Data_Type_Access := Convert (Data);
      begin
         Internal2 (D.User);
         Internal (D);
      end Free_Data;

      ----------------------
      -- First_Marshaller --
      ----------------------

      procedure First_Marshaller (Object    : in System.Address;
                                  User_Data : in System.Address;
                                  Nparams   : in Guint;
                                  Params    : in System.Address)
      is
         use type Marshallers.Handler_Proxy;

         Data : Data_Type_Access := Convert (User_Data);
         Stub : Widget_Type;
      begin
         if Data.Func = null then
            return;
         end if;

         if Data.Marsh /= null then
            Data.Marsh (Acc (Get_User_Data (Object, Stub)),
                        Gtk.Arguments.Make_Args (Nparams, Params),
                        To_General_Handler (Data.Func),
                        Data.User.all);
         else
            Data.Func (Acc (Get_User_Data (Object, Stub)),
                       Gtk.Arguments.Make_Args (Nparams, Params),
                       Data.User.all);
         end if;
      end First_Marshaller;

      -------------
      -- Connect --
      -------------

      procedure Connect
        (Widget    : access Widget_Type'Class;
         Name      : in     String;
         Marsh     : in     Marshallers.Marshaller;
         User_Data : in     User_Type;
         After     : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Connect (Widget, Name, Marsh, User_Data, After);
      end Connect;

      -------------
      -- Connect --
      -------------

      procedure Connect
        (Widget    : access Widget_Type'Class;
         Name      : in     String;
         Cb        : in     Handler;
         User_Data : in     User_Type;
         After     : in     Boolean := False)
      is
         Id : Handler_Id;
      begin
         Id := Connect (Widget, Name, Cb, User_Data, After);
      end Connect;

      -------------
      -- Connect --
      -------------

      function Connect
        (Widget    : access Widget_Type'Class;
         Name      : in     String;
         Marsh     : in     Marshallers.Marshaller;
         User_Data : in     User_Type;
         After     : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func  => To_Handler (Marsh.Func),
                                 Marsh => Marsh.Marsh,
                                 User  => new User_Type'(User_Data));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) = Gtk_Type_None,
            "Handlers for this signal should return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Connect;

      -------------
      -- Connect --
      -------------

      function Connect
        (Widget    : access Widget_Type'Class;
         Name      : in     String;
         Cb        : in     Handler;
         User_Data : in     User_Type;
         After     : in     Boolean := False)
        return Handler_Id
      is
         D : Data_Type_Access :=
           new Data_Type_Record'(Func  => Cb,
                                 Marsh => null,
                                 User  => new User_Type'(User_Data));
      begin
         pragma Assert
           (Argument_Type (Get_Type (Widget), Name, -1) = Gtk_Type_None,
            "Handlers for this signal should return a value.");

         return Do_Signal_Connect (Gtk.Object.Gtk_Object (Widget),
                                   Name,
                                   First_Marshaller'Address,
                                   Convert (D),
                                   Free_Data'Address,
                                   After);
      end Connect;

   end User_Callback;

   ----------------
   -- Disconnect --
   ----------------

   procedure Disconnect
     (Object : access Gtk.Object.Gtk_Object_Record'Class;
      Id     : in Handler_Id)
   is
      procedure Internal (Obj : System.Address; Id : Handler_Id);
      pragma Import (C, Internal, "gtk_signal_disconnect");

   begin
      Internal (Obj => Get_Object (Object.all),
                Id  => Id);
   end Disconnect;

   -----------------------
   -- Emit_Stop_By_Name --
   -----------------------

   procedure Emit_Stop_By_Name
     (Object : access Gtk.Object.Gtk_Object_Record'Class;
      Name   : in String)
   is
      procedure Internal (Object : in System.Address;
                          Name   : in String);
      pragma Import (C, Internal, "gtk_signal_emit_stop_by_name");
   begin
      Internal (Get_Object (Object.all), Name & Ascii.NUL);
   end Emit_Stop_By_Name;

   -------------------
   -- Handler_Block --
   -------------------

   procedure Handler_Block
     (Obj : access Gtk.Object.Gtk_Object_Record'Class;
      Id  : in Handler_Id)
   is
      procedure Internal (Obj : in System.Address; Id : in Handler_Id);
      pragma Import (C, Internal, "gtk_signal_handler_block");
   begin
      Internal (Obj => Get_Object (Obj.all), Id  => Id);
   end Handler_Block;

   ----------------------
   -- Handlers_Destroy --
   ----------------------

   procedure Handlers_Destroy (Obj : access Object.Gtk_Object_Record'Class)
   is
      procedure Internal (Obj : System.Address);
      pragma Import (C, Internal, "gtk_signal_handlers_destroy");
   begin
      Internal (Obj => Get_Object (Obj.all));
   end Handlers_Destroy;

   ---------------------
   -- Handler_Unblock --
   ---------------------

   procedure Handler_Unblock
     (Obj : access Gtk.Object.Gtk_Object_Record'Class;
      Id  : in Handler_Id)
   is
      procedure Internal (Obj : in System.Address; Id : in Handler_Id);
      pragma Import (C, Internal, "gtk_signal_handler_unblock");
   begin
      Internal (Obj => Get_Object (Obj.all), Id  => Id);
   end Handler_Unblock;

end Gtk.Handlers;

--  Design of the package:
--
--  The callback package should accomodate the following:
--  * Sometimes, the user does not want to get the handler_id.  Thus, we give
--    the two versions of Connect, either as a procedure or a function.
--  * Some gtk+ signals expect a handler that returns a value, whereas others
--    return nothing. The simplest here is to have two kinds of packages, one
--    for each case.  The standard gtk+ signals (up to 1.2) have the following
--    possible return values: gboolean, gchar*, gint, guint, void
--  * The first argument to a handler is always a Gtk Object.  since GtkAda is
--    full object oriented, we could simply have the first parameter be a
--    Gtk_Object'Class, but this would require in most cases an explicit cast
--    from the user. It is nice to give the opportunity to have a specific
--    type.
--  * The standard callbacks can have any number of arguments (or even
--    none). These arguments depend on the signal type, and the widget type.
--    The only possibility to cover all the cases is to pass these arguments as
--    an array. The package Marshallers provides a convenient interface between
--    these general callbacks and a more usual implementation.
--  * The user can specify some Data to be passed to the handler.  Or there
--    can be none. Once again, we create two versions of the standard packages.
--
--  How the callbacks work:
--     --------      --------------------      ---------------------
--     | Gtk+ |  ->  | First_Marshaller |  ->  | User's Marshaller |
--     --------      --------------------      ---------------------
--                                   \                 |
--                                    \  or            V
--                                     \       -------------------
--                                      \--->  | User's Callback |
--                                             -------------------
--
--  First_Marshaller is an internal function defined in this package. It
--  creates its own user data to memorize both the User's Marshaller (if any),
--  User's Callback, and the User's Data (if any). It then calls the
--  appropriate function in the user's code.
--  The user_data of First_Marshaller is automatically deallocated when the
--  callback is disconnected or the widget is killed, using some capabilities
--  of gtk+ itself.
