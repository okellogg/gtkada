
#include <glib.h>
#include <gdk/gdk.h>
#include <gtk/gtk.h>
 

/*
 *
 * object macros
 *
 */

guint32 ada_object_flags (GtkObject * object)
{
  return GTK_OBJECT_FLAGS (object);
}

void
ada_object_set_flags (GtkObject * object, guint32 flags)
{
  GTK_OBJECT_SET_FLAGS (object, flags);
}

void 
ada_object_unset_flags (GtkObject * object, guint32 flags)
{
  GTK_OBJECT_UNSET_FLAGS (object, flags);
}

guint32
ada_object_destroyed (GtkObject * object)
{
  return GTK_OBJECT_DESTROYED (object);
}

guint32
ada_object_floating (GtkObject * object)
{
  return GTK_OBJECT_FLOATING (object);
}

guint32
ada_object_connected (GtkObject * object)
{
  return GTK_OBJECT_CONNECTED (object);
}


/*
 *
 * Widget macros
 *
 */

guint32 
ada_widget_toplevel (GtkWidget * widget)
{
  return GTK_WIDGET_TOPLEVEL (widget);
}

guint32
ada_widget_no_window (GtkWidget * widget)
{
  return GTK_WIDGET_NO_WINDOW (widget);
}

guint32
ada_widget_realized (GtkWidget * widget)
{
  return GTK_WIDGET_REALIZED (widget);
}

guint32
ada_widget_mapped (GtkWidget * widget)
{
  return GTK_WIDGET_MAPPED (widget);
}

guint32
ada_widget_visible (GtkWidget * widget)
{
  return GTK_WIDGET_VISIBLE (widget);
}

guint32
ada_widget_drawable (GtkWidget * widget)
{
  return GTK_WIDGET_DRAWABLE (widget);
}

guint32 
ada_widget_sensitive (GtkWidget * widget)
{
  return GTK_WIDGET_SENSITIVE (widget);
}

guint32
ada_widget_parent_sensitive (GtkWidget * widget)
{
  return GTK_WIDGET_PARENT_SENSITIVE (widget);
}

guint32
ada_widget_is_sensitive (GtkWidget * widget)
{
  return GTK_WIDGET_IS_SENSITIVE (widget);
}

guint32
ada_widget_can_focus (GtkWidget * widget)
{
  return GTK_WIDGET_CAN_FOCUS (widget);
}

guint32
ada_widget_has_focus (GtkWidget * widget)
{
  return GTK_WIDGET_HAS_FOCUS (widget);
}

guint32
ada_widget_has_default (GtkWidget * widget)
{
  return GTK_WIDGET_HAS_DEFAULT (widget);
}

guint32
ada_widget_has_grab (GtkWidget * widget)
{
  return GTK_WIDGET_HAS_GRAB (widget);
}

guint32
ada_widget_basic (GtkWidget * widget)
{
  return GTK_WIDGET_BASIC (widget);
}

guint32
ada_widget_rc_style (GtkWidget * widget)
{
  return GTK_WIDGET_RC_STYLE (widget);
}

guint16
ada_widget_allocation_height (GtkWidget* widget)
{
  return widget->allocation.height;
}

guint16
ada_widget_allocation_width (GtkWidget* widget)
{
  return widget->allocation.width;
}

gint16
ada_widget_allocation_x (GtkWidget* widget)
{
  return widget->allocation.x;
}

gint16
ada_widget_allocation_y (GtkWidget* widget)
{
  return widget->allocation.y;
}


    
/*
 * 
 * toggle_buttons
 *
 */

gint 
ada_toggle_button_get_state (GtkToggleButton *toggle_button)
{
  return toggle_button->active;
}


/*
 *
 * radio_menu_item
 *
 */

GtkWidget*
ada_radio_menu_item_new_from_widget (GtkRadioMenuItem *group)
{
  GSList *l = NULL;
  if (group)
    l = gtk_radio_menu_item_group (group);
  return gtk_radio_menu_item_new (l);
}


GtkWidget *
ada_radio_menu_item_new_with_label_from_widget (GtkRadioMenuItem *group,
						const gchar      *label)
{
  GSList *l = NULL;
  if (group)
    l = gtk_radio_menu_item_group (group);
  return gtk_radio_menu_item_new_with_label (l, label);
}

/*
 *
 * GdkRectangle
 *
 */

GdkRectangle *
ada_gdk_rectangle_new_with_data (gint16 x, gint16 y, 
				guint16 width, guint16 height)
{
  GdkRectangle * result;

  result = g_new (GdkRectangle, 1);
  if (result)
    {
      result->x = x;
      result->y = y;
      result->width = width;
      result->height = height;
    }
  
  return result;
}

gint16
ada_gdk_rectangle_get_x (GdkRectangle * rectangle)
{
  g_return_val_if_fail (rectangle != NULL, 0);

  return rectangle->x;
}

gint16
ada_gdk_rectangle_get_y (GdkRectangle * rectangle) 
{
  g_return_val_if_fail (rectangle != NULL, 0);

  return rectangle->y;
}

guint16
ada_gdk_rectangle_get_width (GdkRectangle * rectangle)
{
  g_return_val_if_fail (rectangle != NULL, 0);
  
  return rectangle->width;
}

guint16
ada_gdk_rectangle_get_height (GdkRectangle * rectangle)
{
  g_return_val_if_fail (rectangle != NULL, 0);
  
  return rectangle->height;
}

void 
ada_gdk_rectangle_set_x (GdkRectangle * rectangle,
			 gint16 x)
{
  g_return_if_fail (rectangle != NULL);
  
  rectangle->x = x;
}


void 
ada_gdk_rectangle_set_y (GdkRectangle * rectangle,
			 gint16 y)
{
  g_return_if_fail (rectangle != NULL);
  
  rectangle->y = y;
}


void
ada_gdk_rectangle_set_width (GdkRectangle * rectangle,
			     guint16 width)
{
  g_return_if_fail (rectangle != NULL);
  
  rectangle->width = width;
}


void
ada_gdk_rectangle_set_height (GdkRectangle * rectangle,
			      guint16 height)
{
  g_return_if_fail (rectangle != NULL);
  
  rectangle->height = height;
}

void 
ada_gdk_rectangle_destroy (GdkRectangle * rectangle)
{
  g_free (rectangle);
}

/*
 *
 * GdkPoint
 *
 */

GdkPoint * 
ada_gdk_point_new_with_coordinates (const gint16 x, const gint16 y)
{
  GdkPoint * result = NULL;
  
  result = g_new (GdkPoint, 1);
  if (result)
    {
      result->x = x;
      result->y = y;
      
    }

  return result;
}

void
ada_gdk_point_set_coordinates (GdkPoint * point, 
			       const gint16 x, 
			       const gint16 y)
{
  g_return_if_fail (point != NULL);
  
  point->x = x;
  point->y = y;
}

gint16
ada_gdk_point_get_x (GdkPoint * point)
{
  g_return_val_if_fail (point != NULL, 0);
  
  return point->x;
}

gint16
ada_gdk_point_get_y (GdkPoint * point)
{
  g_return_val_if_fail (point != NULL, 0);
  
  return point->y;
}

void
ada_gdk_point_destroy (GdkPoint * point)
{
  g_free (point);
}


/*
 *
 *  GdkCursor
 *
 */

typedef enum
{
  ADA_GDK_NUM_GLYPHS,
  ADA_GDK_X_CURSOR,
  ADA_GDK_ARROW,
  ADA_GDK_BASED_ARROW_DOWN,
  ADA_GDK_BASED_ARROW_UP,
  ADA_GDK_BOAT,
  ADA_GDK_BOGOSITY,
  ADA_GDK_BOTTOM_LEFT_CORNER,
  ADA_GDK_BOTTOM_RIGHT_CORNER,
  ADA_GDK_BOTTOM_SIDE,
  ADA_GDK_BOTTOM_TEE,
  ADA_GDK_BOX_SPIRAL,
  ADA_GDK_CENTER_PTR,
  ADA_GDK_CIRCLE,
  ADA_GDK_CLOCK,
  ADA_GDK_COFFEE_MUG,
  ADA_GDK_CROSS,
  ADA_GDK_CROSS_REVERSE,
  ADA_GDK_CROSSHAIR,
  ADA_GDK_DIAMOND_CROSS,
  ADA_GDK_DOT,
  ADA_GDK_DOTBOX,
  ADA_GDK_DOUBLE_ARROW,
  ADA_GDK_DRAFT_LARGE,
  ADA_GDK_DRAFT_SMALL,
  ADA_GDK_DRAPED_BOX,
  ADA_GDK_EXCHANGE,
  ADA_GDK_FLEUR,
  ADA_GDK_GOBBLER,
  ADA_GDK_GUMBY,
  ADA_GDK_HAND1,
  ADA_GDK_HAND2,
  ADA_GDK_HEART,
  ADA_GDK_ICON,
  ADA_GDK_IRON_CROSS,
  ADA_GDK_LEFT_PTR,
  ADA_GDK_LEFT_SIDE,
  ADA_GDK_LEFT_TEE,
  ADA_GDK_LEFTBUTTON,
  ADA_GDK_LL_ANGLE,
  ADA_GDK_LR_ANGLE,
  ADA_GDK_MAN,
  ADA_GDK_MIDDLEBUTTON,
  ADA_GDK_MOUSE,
  ADA_GDK_PENCIL,
  ADA_GDK_PIRATE,
  ADA_GDK_PLUS,
  ADA_GDK_QUESTION_ARROW,
  ADA_GDK_RIGHT_PTR,
  ADA_GDK_RIGHT_SIDE,
  ADA_GDK_RIGHT_TEE,
  ADA_GDK_RIGHTBUTTON,
  ADA_GDK_RTL_LOGO,
  ADA_GDK_SAILBOAT,
  ADA_GDK_SB_DOWN_ARROW,
  ADA_GDK_SB_H_DOUBLE_ARROW,
  ADA_GDK_SB_LEFT_ARROW,
  ADA_GDK_SB_RIGHT_ARROW,
  ADA_GDK_SB_UP_ARROW,
  ADA_GDK_SB_V_DOUBLE_ARROW,
  ADA_GDK_SHUTTLE,
  ADA_GDK_SIZING,
  ADA_GDK_SPIDER,
  ADA_GDK_SPRAYCAN,
  ADA_GDK_STAR,
  ADA_GDK_TARGET,
  ADA_GDK_TCROSS,
  ADA_GDK_TOP_LEFT_ARROW,
  ADA_GDK_TOP_LEFT_CORNER,
  ADA_GDK_TOP_RIGHT_CORNER,
  ADA_GDK_TOP_SIDE,
  ADA_GDK_TOP_TEE,
  ADA_GDK_TREK,
  ADA_GDK_UL_ANGLE,
  ADA_GDK_UMBRELLA,
  ADA_GDK_UR_ANGLE,
  ADA_GDK_WATCH,
  ADA_GDK_XTERM,
  ADA_GDK_LAST_CURSOR,
  ADA_GDK_CURSOR_IS_PIXMAP
} AdaGdkCursorType;



GdkCursorType
ada_gdk_cursor_of (AdaGdkCursorType cursor_type)
{
  switch (cursor_type)
  {
  case ADA_GDK_NUM_GLYPHS : return GDK_NUM_GLYPHS; break;
  case ADA_GDK_X_CURSOR : return GDK_X_CURSOR; break;
  case ADA_GDK_ARROW : return GDK_ARROW; break;
  case ADA_GDK_BASED_ARROW_DOWN : return GDK_BASED_ARROW_DOWN; break;
  case ADA_GDK_BASED_ARROW_UP : return GDK_BASED_ARROW_UP; break;
  case ADA_GDK_BOAT : return GDK_BOAT; break;
  case ADA_GDK_BOGOSITY : return GDK_BOGOSITY; break;
  case ADA_GDK_BOTTOM_LEFT_CORNER : return GDK_BOTTOM_LEFT_CORNER; break;
  case ADA_GDK_BOTTOM_RIGHT_CORNER : return GDK_BOTTOM_RIGHT_CORNER; break;
  case ADA_GDK_BOTTOM_SIDE : return GDK_BOTTOM_SIDE; break;
  case ADA_GDK_BOTTOM_TEE : return GDK_BOTTOM_TEE; break;
  case ADA_GDK_BOX_SPIRAL : return GDK_BOX_SPIRAL; break;
  case ADA_GDK_CENTER_PTR : return GDK_CENTER_PTR; break;
  case ADA_GDK_CIRCLE : return GDK_CIRCLE; break;
  case ADA_GDK_CLOCK : return GDK_CLOCK; break;
  case ADA_GDK_COFFEE_MUG : return GDK_COFFEE_MUG; break;
  case ADA_GDK_CROSS : return GDK_CROSS; break;
  case ADA_GDK_CROSS_REVERSE : return GDK_CROSS_REVERSE; break;
  case ADA_GDK_CROSSHAIR : return GDK_CROSSHAIR; break;
  case ADA_GDK_DIAMOND_CROSS : return GDK_DIAMOND_CROSS; break;
  case ADA_GDK_DOT : return GDK_DOT; break;
  case ADA_GDK_DOTBOX : return GDK_DOTBOX; break;
  case ADA_GDK_DOUBLE_ARROW : return GDK_DOUBLE_ARROW; break;
  case ADA_GDK_DRAFT_LARGE : return GDK_DRAFT_LARGE; break;
  case ADA_GDK_DRAFT_SMALL : return GDK_DRAFT_SMALL; break;
  case ADA_GDK_DRAPED_BOX : return GDK_DRAPED_BOX; break;
  case ADA_GDK_EXCHANGE : return GDK_EXCHANGE; break;
  case ADA_GDK_FLEUR : return GDK_FLEUR; break;
  case ADA_GDK_GOBBLER : return GDK_GOBBLER; break;
  case ADA_GDK_GUMBY : return GDK_GUMBY; break;
  case ADA_GDK_HAND1 : return GDK_HAND1; break;
  case ADA_GDK_HAND2 : return GDK_HAND2; break;
  case ADA_GDK_HEART : return GDK_HEART; break;
  case ADA_GDK_ICON : return GDK_ICON; break;
  case ADA_GDK_IRON_CROSS : return GDK_IRON_CROSS; break;
  case ADA_GDK_LEFT_PTR : return GDK_LEFT_PTR; break;
  case ADA_GDK_LEFT_SIDE : return GDK_LEFT_SIDE; break;
  case ADA_GDK_LEFT_TEE : return GDK_LEFT_TEE; break;
  case ADA_GDK_LEFTBUTTON : return GDK_LEFTBUTTON; break;
  case ADA_GDK_LL_ANGLE : return GDK_LL_ANGLE; break;
  case ADA_GDK_LR_ANGLE : return GDK_LR_ANGLE; break;
  case ADA_GDK_MAN : return GDK_MAN; break;
  case ADA_GDK_MIDDLEBUTTON : return GDK_MIDDLEBUTTON; break;
  case ADA_GDK_MOUSE : return GDK_MOUSE; break;
  case ADA_GDK_PENCIL : return GDK_PENCIL; break;
  case ADA_GDK_PIRATE : return GDK_PIRATE; break;
  case ADA_GDK_PLUS : return GDK_PLUS; break;
  case ADA_GDK_QUESTION_ARROW : return GDK_QUESTION_ARROW; break;
  case ADA_GDK_RIGHT_PTR : return GDK_RIGHT_PTR; break;
  case ADA_GDK_RIGHT_SIDE : return GDK_RIGHT_SIDE; break;
  case ADA_GDK_RIGHT_TEE : return GDK_RIGHT_TEE; break;
  case ADA_GDK_RIGHTBUTTON : return GDK_RIGHTBUTTON; break;
  case ADA_GDK_RTL_LOGO : return GDK_RTL_LOGO; break;
  case ADA_GDK_SAILBOAT : return GDK_SAILBOAT; break;
  case ADA_GDK_SB_DOWN_ARROW : return GDK_SB_DOWN_ARROW; break;
  case ADA_GDK_SB_H_DOUBLE_ARROW : return GDK_SB_H_DOUBLE_ARROW; break;
  case ADA_GDK_SB_LEFT_ARROW : return GDK_SB_LEFT_ARROW; break;
  case ADA_GDK_SB_RIGHT_ARROW : return GDK_SB_RIGHT_ARROW; break;
  case ADA_GDK_SB_UP_ARROW : return GDK_SB_UP_ARROW; break;
  case ADA_GDK_SB_V_DOUBLE_ARROW : return GDK_SB_V_DOUBLE_ARROW; break;
  case ADA_GDK_SHUTTLE : return GDK_SHUTTLE; break;
  case ADA_GDK_SIZING : return GDK_SIZING; break;
  case ADA_GDK_SPIDER : return GDK_SPIDER; break;
  case ADA_GDK_SPRAYCAN : return GDK_SPRAYCAN; break;
  case ADA_GDK_STAR : return GDK_STAR; break;
  case ADA_GDK_TARGET : return GDK_TARGET; break;
  case ADA_GDK_TCROSS : return GDK_TCROSS; break;
  case ADA_GDK_TOP_LEFT_ARROW : return GDK_TOP_LEFT_ARROW; break;
  case ADA_GDK_TOP_LEFT_CORNER : return GDK_TOP_LEFT_CORNER; break;
  case ADA_GDK_TOP_RIGHT_CORNER : return GDK_TOP_RIGHT_CORNER; break;
  case ADA_GDK_TOP_SIDE : return GDK_TOP_SIDE; break;
  case ADA_GDK_TOP_TEE : return GDK_TOP_TEE; break;
  case ADA_GDK_TREK : return GDK_TREK; break;
  case ADA_GDK_UL_ANGLE : return GDK_UL_ANGLE; break;
  case ADA_GDK_UMBRELLA : return GDK_UMBRELLA; break;
  case ADA_GDK_UR_ANGLE : return GDK_UR_ANGLE; break;
  case ADA_GDK_WATCH : return GDK_WATCH; break;
  case ADA_GDK_XTERM : return GDK_XTERM; break;
  case ADA_GDK_LAST_CURSOR : return GDK_LAST_CURSOR; break;
  case ADA_GDK_CURSOR_IS_PIXMAP : return GDK_CURSOR_IS_PIXMAP; break;
  default : return GDK_XTERM; break;
  }
};

GdkCursor* 
ada_gdk_cursor_new (AdaGdkCursorType   cursor_type)
{
  return gdk_cursor_new (ada_gdk_cursor_of (cursor_type));
}


/*
 *
 * GdkEventAny
 *
 */

GdkEventType
ada_gdk_event_any_get_event_type (GdkEventAny * event)
{
  return event->type;
}


void
ada_gdk_event_any_set_event_type (GdkEventAny * event, GdkEventType type)
{
  event->type = type;
}


GdkWindow *
ada_gdk_event_any_get_window (GdkEventAny * event)
{
  return event->window;
}

void
ada_gdk_event_any_set_window (GdkEventAny * event,
			      GdkWindow * window)
{
  event->window = window;
}


gint8
ada_gdk_event_any_get_send_event (GdkEventAny * event)
{
  return event->send_event;
}

void
ada_gdk_event_any_set_send_event (GdkEventAny * event, gint8 send_event)
{
  event->send_event = send_event;
}

/*
 *
 *  GdkEventExpose
 *
 */

GdkRectangle *
ada_gdk_event_expose_get_area (GdkEventExpose * event)
{
  return &event->area;
}

void
ada_gdk_event_expose_set_area (GdkEventExpose * event,
			       GdkRectangle * area)
{
  event->area = *area;
}

gint
ada_gdk_event_expose_get_count (GdkEventExpose * event)
{
  return event->count;
}

void
ada_gdk_event_expose_set_count (GdkEventExpose * event, gint count)
{
  event->count = count;
}


/*
 *
 * GdkEventConfigure
 *
 */

gint16
ada_gdk_event_configure_get_x (GdkEventConfigure * event)
{
  return event->x;
}

void
ada_gdk_event_configure_set_x (GdkEventConfigure * event, gint16 x)
{
  event->x = x;
}

gint16
ada_gdk_event_configure_get_y (GdkEventConfigure * event)
{
  return event->y;
}

void
ada_gdk_event_configure_set_y (GdkEventConfigure * event, gint16 y)
{
  event->y = y;
}

gint16
ada_gdk_event_configure_get_width (GdkEventConfigure * event)
{
  return event->width;
}

void
ada_gdk_event_configure_set_width (GdkEventConfigure * event, gint16 width)
{
  event->width = width;
}

gint16
ada_gdk_event_configure_get_height (GdkEventConfigure * event)
{
  return event->height;
}

void
ada_gdk_event_configure_set_height (GdkEventConfigure * event, gint16 height)
{
  event->height = height;
}

/*
 *
 * GdkEventButton
 *
 */

guint32
ada_gdk_event_button_get_state (GdkEventButton * event)
{
  return event->state;
}

guint32
ada_gdk_event_button_get_button (GdkEventButton * event)
{
  return event->button;
}

gint16
ada_gdk_event_button_get_x (GdkEventButton * event)
{
  return event->x;
}

void
ada_gdk_event_button_set_x (GdkEventButton * event, gint16 x)
{
  event->x = x;
}

gint16
ada_gdk_event_button_get_y (GdkEventButton * event)
{
  return event->y;
}

void
ada_gdk_event_button_set_y (GdkEventButton * event, gint16 y)
{
  event->y = y;
}


/*
 *
 * GdkEventMotion
 *
 */

gint16
ada_gdk_event_motion_get_x (GdkEventMotion * event)
{
  return event->x;
}

gint16
ada_gdk_event_motion_get_y (GdkEventMotion * event)
{
  return event->y;
}


/*
 *
 * GtkAdjustment
 *
 */

gfloat
ada_gtk_adjustment_get_value (GtkAdjustment * adjustment)
{
  return adjustment->value;
}

void
ada_adjustment_set_page_increment (GtkAdjustment * adjustment,
                                       gfloat value)
{
  adjustment->page_increment = value;
}

void
ada_adjustment_set_page_size (GtkAdjustment * adjustment,
                                  gfloat value)
{
  adjustment->page_size = value;
}

guint32
ada_gdk_event_motion_get_state (GdkEventButton * event)
{
  return event->state;
}


/*
 *
 * GtkStyle
 *
 */

GdkGC *
ada_gtk_style_get_black_gc (GtkStyle * style)
{
  return style->black_gc;
}

/*
 *
 * GdkColor
 *
 */

GdkColor *
ada_gdk_color_new_color (void)
{
  return (GdkColor *) g_malloc (sizeof(GdkColor));
}

/***************************************************
 *  Functions for Objects
 ***************************************************/

gint
ada_object_get_type (GtkObject* object)
{
  return GTK_OBJECT_TYPE (object);
}

gchar*
ada_type_name (gint type)
{
  return gtk_type_name (type);
}

/***************************************************
 *  Functions for GtkArg
 ***************************************************/

gpointer
ada_gtkarg_value_object (GtkArg* args, guint num)
{
  gpointer return_value = NULL;
  switch (args [num].type % 256)
    {
    case GTK_TYPE_OBJECT:
      return_value = (gpointer)GTK_VALUE_OBJECT (args [num]);
      break;
    case GTK_TYPE_POINTER:
      return_value = (gpointer)GTK_VALUE_POINTER (args [num]);
      break;
    case GTK_TYPE_STRING:
      return_value = (gpointer)GTK_VALUE_STRING (args [num]);
      break;
    case GTK_TYPE_BOXED:
      return_value = (gpointer)GTK_VALUE_BOXED (args [num]);
      break;
    default:
      {
	fprintf (stderr, "request for an Object value (%d) when we have a %d\n",
		 GTK_TYPE_OBJECT, (args[num].type % 256));
      }
    }
  return return_value;
}

/***************************************************
 *  Functions to get the field of a color selection
 *  dialog
 ***************************************************/

GtkWidget*
ada_colorsel_dialog_get_colorsel (GtkColorSelectionDialog* dialog)
{
  return dialog->colorsel;
}

GtkWidget*
ada_colorsel_dialog_get_ok_button (GtkColorSelectionDialog* dialog)
{
  return dialog->ok_button;
}

GtkWidget*
ada_colorsel_dialog_get_reset_button (GtkColorSelectionDialog* dialog)
{
  return dialog->reset_button;
}

GtkWidget*
ada_colorsel_dialog_get_cancel_button (GtkColorSelectionDialog* dialog)
{
  return dialog->cancel_button;
}

GtkWidget*
ada_colorsel_dialog_get_help_button (GtkColorSelectionDialog* dialog)
{
  return dialog->help_button;
}

/********************************************************
 *  Functions to get the fields of a gamma curve
 ********************************************************/

GtkWidget*
ada_gamma_curve_get_curve (GtkGammaCurve* widget)
{
  return widget->curve;
}

gfloat
ada_gamma_curve_get_gamma (GtkGammaCurve* widget)
{
  return widget->gamma;
}

/******************************************
 ** Functions for Alignment
 ******************************************/

gfloat
ada_alignment_get_xalign (GtkAlignment* widget)
{
   return widget->xalign;
}

gfloat
ada_alignment_get_xscale (GtkAlignment* widget)
{
   return widget->xscale;
}

gfloat
ada_alignment_get_yalign (GtkAlignment* widget)
{
   return widget->yalign;
}

gfloat
ada_alignment_get_yscale (GtkAlignment* widget)
{
   return widget->yscale;
}


/******************************************
 ** Functions for Ruler
 ******************************************/

gfloat
ada_ruler_get_lower (GtkRuler* widget)
{
   return widget->lower;
}

gfloat
ada_ruler_get_max_size (GtkRuler* widget)
{
   return widget->max_size;
}

gfloat
ada_ruler_get_position (GtkRuler* widget)
{
   return widget->position;
}

gfloat
ada_ruler_get_upper (GtkRuler* widget)
{
   return widget->upper;
}

/******************************************
 ** Functions for Editable
 ******************************************/

guint
ada_editable_get_editable (GtkEditable* widget)
{
  return widget->editable;
}

void
ada_editable_set_editable (GtkEditable* widget, guint val)
{
  widget->editable = val;
}

gchar*
ada_editable_get_clipboard_text (GtkEditable* widget)
{
   return widget->clipboard_text;
}

guint
ada_editable_get_current_pos (GtkEditable* widget)
{
   return widget->current_pos;
}

guint
ada_editable_get_has_selection (GtkEditable* widget)
{
   return widget->has_selection;
}

guint
ada_editable_get_selection_end_pos (GtkEditable* widget)
{
   return widget->selection_end_pos;
}

guint
ada_editable_get_selection_start_pos (GtkEditable* widget)
{
   return widget->selection_start_pos;
}

/******************************************
 ** Functions for Aspect_Frame
 ******************************************/

gfloat
ada_aspect_frame_get_ratio (GtkAspectFrame* widget)
{
   return widget->ratio;
}

gfloat
ada_aspect_frame_get_xalign (GtkAspectFrame* widget)
{
   return widget->xalign;
}

gfloat
ada_aspect_frame_get_yalign (GtkAspectFrame* widget)
{
   return widget->yalign;
}

/******************************************
 ** Functions for Text
 ******************************************/

guint
ada_text_get_gap_position (GtkText* widget)
{
   return widget->gap_position;
}

guint
ada_text_get_gap_size (GtkText* widget)
{
   return widget->gap_size;
}

guchar*
ada_text_get_text (GtkText* widget)
{
   return widget->text;
}

guint
ada_text_get_text_end (GtkText* widget)
{
   return widget->text_end;
}

GtkAdjustment*
ada_text_get_hadj (GtkText* widget)
{
  return widget->hadj;
}

GtkAdjustment*
ada_text_get_vadj (GtkText* widget)
{
  return widget->vadj;
}

/******************************************
 ** Functions for File_Selection
 ******************************************/

GtkWidget*
ada_file_selection_get_action_area (GtkFileSelection* widget)
{
   return widget->action_area;
}
GtkWidget*
ada_file_selection_get_button_area (GtkFileSelection* widget)
{
   return widget->button_area;
}
GtkWidget*
ada_file_selection_get_cancel_button (GtkFileSelection* widget)
{
   return widget->cancel_button;
}

GtkWidget*
ada_file_selection_get_dir_list (GtkFileSelection* widget)
{
   return widget->dir_list;
}

GtkWidget*
ada_file_selection_get_file_list (GtkFileSelection* widget)
{
   return widget->file_list;
}

GtkWidget*
ada_file_selection_get_help_button (GtkFileSelection* widget)
{
   return widget->help_button;
}

GtkWidget*
ada_file_selection_get_history_pulldown (GtkFileSelection* widget)
{
   return widget->history_pulldown;
}

GtkWidget*
ada_file_selection_get_ok_button (GtkFileSelection* widget)
{
   return widget->ok_button;
}

GtkWidget*
ada_file_selection_get_selection_entry (GtkFileSelection* widget)
{
   return widget->selection_entry;
}

GtkWidget*
ada_file_selection_get_selection_text (GtkFileSelection* widget)
{
   return widget->selection_text;
}

/******************************************
 ** Functions for Dialog
 ******************************************/

GtkWidget*
ada_dialog_get_action_area (GtkDialog* widget)
{
   return widget->action_area;
}

GtkWidget*
ada_dialog_get_vbox (GtkDialog* widget)
{
   return widget->vbox;
}

/******************************************
 ** Functions for Toggle_Button
 ******************************************/

guint
ada_toggle_button_get_active (GtkToggleButton* widget)
{
   return widget->active;
}

/******************************************
 ** Functions for Combo
 ******************************************/

GtkWidget*
ada_combo_get_entry (GtkCombo* widget)
{
  return widget->entry;
}

GtkWidget*
ada_combo_get_list (GtkCombo* widget)
{
  return widget->list;
}

/*******************************************
 ** Functions for Style
 *******************************************/

GdkColor*
ada_style_get_bg (GtkStyle* style, gint state)
{
  return &(style->bg [state]);
}

GdkColor*
ada_style_get_black (GtkStyle* style)
{
  return &(style->black);
}

GdkColor*
ada_style_get_white (GtkStyle* style)
{
  return &(style->white);
}

/********************************************
 ** Functions for Widget
 ********************************************/

GtkStyle*
ada_widget_get_style (GtkWidget* widget)
{
  return widget->style;
}

GdkWindow*
ada_widget_get_window (GtkWidget* widget)
{
  return widget->window;
}

GtkWidget*
ada_widget_get_parent (GtkWidget* widget)
{
  return widget->parent;
}

GtkSignalFunc
ada_widget_get_motion_notify (GtkWidget* widget)
{
  return (GtkSignalFunc)(GTK_WIDGET_CLASS (GTK_OBJECT (widget)->klass)
			 ->motion_notify_event);
}

/******************************************
 ** Functions for Pixmap
 ******************************************/

GdkBitmap*
ada_pixmap_get_mask (GtkPixmap* widget)
{
   return widget->mask;
}

GdkPixmap*
ada_pixmap_get_pixmap (GtkPixmap* widget)
{
   return widget->pixmap;
}

/*******************************************
 ** Functions for Notebook
 *******************************************/

gint
ada_notebook_get_tab_pos (GtkNotebook* widget)
{
   return widget->tab_pos;
}

GList*
ada_notebook_get_children (GtkNotebook* widget)
{
  return widget->children;
}

GtkNotebookPage*
ada_notebook_get_cur_page (GtkNotebook* widget)
{
  return widget->cur_page;
}

GtkWidget*
ada_notebook_get_menu_label (GtkNotebookPage* widget)
{
  return widget->menu_label;
}

GtkWidget*
ada_notebook_get_tab_label (GtkNotebookPage* widget)
{
  return widget->tab_label;
}

/**********************************************
 ** Functions for Box
 **********************************************/

GtkWidget*
ada_box_get_child (GtkBox* widget, gint num)
{
  if (num < g_list_length (widget->children))
    return ((GtkBoxChild*)(g_list_nth_data (widget->children, num)))->widget;
  else
    return NULL;
}

/**********************************************
 ** Functions for Progress_Bar
 **********************************************/

gfloat
ada_progress_bar_get_percentage (GtkProgressBar* widget)
{
  return widget->percentage;
}

/**********************************************
 ** Functions for Glib.Glist
 **********************************************/

GList*
ada_list_next (GList* list)
{
  if (list)
    return list->next;
  else
    return NULL;
}


GList*
ada_list_prev (GList* list)
{
  if (list)
    return list->prev;
  else
    return NULL;
}

gpointer
ada_list_get_data (GList* list)
{
  return list->data;
}

/**********************************************
 ** Functions for Glib.GSlist
 **********************************************/

GSList*
ada_gslist_next (GSList* list)
{
  if (list)
    return list->next;
  else
    return NULL;
}

gpointer
ada_gslist_get_data (GSList* list)
{
  return list->data;
}

/******************************************
 ** Functions for Fixed
 ******************************************/

GList*
ada_fixed_get_children (GtkFixed* widget)
{
   return widget->children;
}

/******************************************
 ** Functions for Status bar
 ******************************************/

GSList *
ada_status_get_messages (GtkStatusbar* widget)
{
  return widget->messages;
}


/******************************************
 ** Functions for GtkList
 ******************************************/

GList*
ada_list_get_children (GtkList* widget)
{
   return widget->children;
}

GList*
ada_list_get_selection (GtkList* widget)
{
   return widget->selection;
}

/******************************************
 ** Functions for Tree
 ******************************************/

GList*
ada_tree_get_children (GtkTree* widget)
{
   return widget->children;
}

GList*
ada_tree_get_selection (GtkTree* widget)
{
   return widget->selection;
}

/*******************************************
 ** Functions for Tree_Item
 *******************************************/

GtkWidget*
ada_tree_item_get_subtree (GtkTreeItem* widget)
{
  return GTK_TREE_ITEM_SUBTREE (widget);
}


/******************************************
 ** Functions for CList
 ******************************************/

GList*
ada_clist_get_selection (GtkCList* widget)
{
   return widget->selection;
}

GtkWidget*
ada_clist_get_column_button (GtkCList* widget,
			     gint      column)
{
  if (widget->columns < column)
    return widget->column[column].button;
  else
    return NULL;
}

GdkWindow*
ada_clist_get_clist_window (GtkCList* widget)
{
  return widget->clist_window;
}


