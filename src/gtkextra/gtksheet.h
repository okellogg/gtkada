/* GtkSheet widget for Gtk+.
 * Copyright (C) 1999-2001 Adrian E. Feiguin <adrian@ifir.ifir.edu.ar>
 *
 * Based on GtkClist widget by Jay Painter, but major changes.
 * Memory allocation routines inspired on SC (Spreadsheet Calculator)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#ifndef __GTK_SHEET_H__
#define __GTK_SHEET_H__


#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


typedef enum{GTK_SHEET_FOREGROUND,
	     GTK_SHEET_BACKGROUND,
             GTK_SHEET_FONT,
	     GTK_SHEET_JUSTIFICATION,
	     GTK_SHEET_BORDER,
             GTK_SHEET_BORDER_COLOR,
             GTK_SHEET_IS_EDITABLE,
             GTK_SHEET_IS_VISIBLE} GtkSheetAttrType;

/* sheet->state */

enum {GTK_SHEET_NORMAL,
      GTK_SHEET_ROW_SELECTED,
      GTK_SHEET_COLUMN_SELECTED,
      GTK_SHEET_RANGE_SELECTED};
     
enum
{
  GTK_SHEET_LEFT_BORDER     = 1 << 0, 
  GTK_SHEET_RIGHT_BORDER    = 1 << 1, 
  GTK_SHEET_TOP_BORDER      = 1 << 2, 
  GTK_SHEET_BOTTOM_BORDER   = 1 << 3 
}; 

/* sheet flags */
enum                    
{
  GTK_SHEET_IS_LOCKED       = 1 << 0,
  GTK_SHEET_IS_FROZEN       = 1 << 1,                                     
  GTK_SHEET_IN_XDRAG        = 1 << 2,                                        
  GTK_SHEET_IN_YDRAG        = 1 << 3,                                        
  GTK_SHEET_IN_DRAG         = 1 << 4,                                        
  GTK_SHEET_IN_SELECTION    = 1 << 5,
  GTK_SHEET_IN_RESIZE       = 1 << 6,
  GTK_SHEET_IN_CLIP         = 1 << 7,
  GTK_SHEET_ROW_FROZEN      = 1 << 8,  /* set rows to be resizeable */
  GTK_SHEET_COLUMN_FROZEN   = 1 << 9,  /* set cols to be resizeable */
  GTK_SHEET_AUTORESIZE      = 1 << 10, /* resize column if text width is great than column width */
  GTK_SHEET_CLIP_TEXT     = 1 << 11, /* clip text to cell */
  GTK_SHEET_ROW_TITLES_VISIBLE = 1 << 12,
  GTK_SHEET_COL_TITLES_VISIBLE = 1 << 13,
  GTK_SHEET_AUTO_SCROLL     = 1 << 14,
  GTK_SHEET_JUSTIFY_ENTRY    = 1 << 15
}; 

#define GTK_TYPE_SHEET_RANGE (gtk_sheet_range_get_type ())
#define GTK_TYPE_SHEET (gtk_sheet_get_type ())

#define GTK_SHEET(obj)          GTK_CHECK_CAST (obj, gtk_sheet_get_type (), GtkSheet)
#define GTK_SHEET_CLASS(klass)  GTK_CHECK_CLASS_CAST (klass, gtk_sheet_get_type (), GtkSheetClass)
#define GTK_IS_SHEET(obj)       GTK_CHECK_TYPE (obj, gtk_sheet_get_type ())

#define GTK_SHEET_FLAGS(sheet)             (GTK_SHEET (sheet)->flags)
#define GTK_SHEET_SET_FLAGS(sheet,flag)    (GTK_SHEET_FLAGS (sheet) |= (flag))
#define GTK_SHEET_UNSET_FLAGS(sheet,flag)  (GTK_SHEET_FLAGS (sheet) &= ~(flag))

#define GTK_SHEET_IS_LOCKED(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_IS_LOCKED)
#define GTK_SHEET_IS_FROZEN(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_IS_FROZEN)
#define GTK_SHEET_IN_XDRAG(sheet)    (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_IN_XDRAG)
#define GTK_SHEET_IN_YDRAG(sheet)    (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_IN_YDRAG)
#define GTK_SHEET_IN_DRAG(sheet)     (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_IN_DRAG)
#define GTK_SHEET_IN_SELECTION(sheet) (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_IN_SELECTION)
#define GTK_SHEET_IN_RESIZE(sheet) (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_IN_RESIZE)
#define GTK_SHEET_IN_CLIP(sheet) (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_IN_CLIP)
#define GTK_SHEET_ROW_FROZEN(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_ROW_FROZEN)
#define GTK_SHEET_COLUMN_FROZEN(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_COLUMN_FROZEN)
#define GTK_SHEET_AUTORESIZE(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_AUTORESIZE)
#define GTK_SHEET_CLIP_TEXT(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_CLIP_TEXT)
#define GTK_SHEET_ROW_TITLES_VISIBLE(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_ROW_TITLES_VISIBLE)
#define GTK_SHEET_COL_TITLES_VISIBLE(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_COL_TITLES_VISIBLE)
#define GTK_SHEET_AUTO_SCROLL(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_AUTO_SCROLL)
#define GTK_SHEET_JUSTIFY_ENTRY(sheet)   (GTK_SHEET_FLAGS (sheet) & GTK_SHEET_JUSTIFY_ENTRY)

typedef struct _GtkSheet GtkSheet;
typedef struct _GtkSheetClass GtkSheetClass;
typedef struct _GtkSheetChild GtkSheetChild;
typedef struct _GtkSheetRow GtkSheetRow;
typedef struct _GtkSheetColumn GtkSheetColumn;
typedef struct _GtkSheetCell GtkSheetCell;
typedef struct _GtkSheetRange GtkSheetRange;
typedef struct _GtkSheetButton       GtkSheetButton;
typedef struct _GtkSheetCellAttr     GtkSheetCellAttr;
typedef struct _GtkSheetCellBorder     GtkSheetCellBorder;

struct _GtkSheetChild
{
  GtkWidget *widget;
  GdkWindow *window;
  gint x,y ;
  gboolean attached_to_cell;
  gint row, col;
  gfloat x_align, y_align;
};

struct _GtkSheetButton
{
  gint state;
  gchar *label;

  gboolean label_visible;
  GtkSheetChild *child;

  GtkJustification justification;
};

struct _GtkSheetCellBorder
{
  gint8 mask;
  gint width;
  GdkLineStyle line_style;
  GdkCapStyle cap_style;
  GdkJoinStyle join_style;
  GdkColor color;
};

struct _GtkSheetCellAttr
{
  GtkJustification justification;
  GdkFont *font;
  GdkColor foreground;
  GdkColor background;
  GtkSheetCellBorder border;
  gboolean is_editable;
  gboolean is_visible;
};

struct _GtkSheetCell
{
  GdkRectangle area;
  gint row;
  gint col;

  GtkSheetCellAttr *attributes;

  gchar *text;
  gpointer link;
};

struct _GtkSheetRange
{
  gint row0,col0; /* upper-left cell */
  gint rowi,coli; /* lower-right cell */
};


struct _GtkSheetRow
{
 gchar *name;
 gint height;
 gint top_ypixel;

 GtkSheetButton button;
 gboolean is_sensitive;
 gboolean is_visible;
};

struct _GtkSheetColumn
{
 gchar *name;
 gint width;
 gint left_xpixel;

 GtkSheetButton button;

 gint left_text_column; /* min left column displaying text on this column */
 gint right_text_column; /* max right column displaying text on this column */

 GtkJustification justification;
 gboolean is_sensitive;
 gboolean is_visible;
};


struct _GtkSheet{
  GtkContainer container;

  guint16 flags;

  GtkSelectionMode selection_mode;

  guint freeze_count;

  /* sheet children */
  GList *children;

  /* allocation rectangle after the container_border_width
     and the width of the shadow border */
  GdkRectangle internal_allocation;

  gchar *name;

  GtkSheetRow *row;
  GtkSheetColumn *column;

  /* max number of diplayed cells */
  gint maxrow;
  gint maxcol;

  /* Displayed range */

  GtkSheetRange view; 

  /* sheet data: dynamically allocated array of cell pointers */
  GtkSheetCell ***data;

  /* max number of allocated cells */
  gint maxallocrow;
  gint maxalloccol;

  /* active cell */
  GtkSheetCell active_cell;
  GtkWidget *sheet_entry;
  GdkWindow *sheet_entry_window; /* for NO_WINDOW entry widgets(ala GtkLayout) */

  GtkType entry_type;

  /* expanding selection */
  GtkSheetCell selection_cell;

  /* timer for automatic scroll during selection */  
  gint32 timer;
  /* timer for flashing clipped range */
  gint32 clip_timer;
  gint interval;

  /* global selection button */
  GtkWidget *button;

  /* sheet state */
  gint state;

  /* selected range */
  GtkSheetRange range;

  /*the scrolling window and it's height and width to
   * make things a little speedier */
  GdkWindow *sheet_window;
  gint sheet_window_width;
  gint sheet_window_height;

  /* sheet backing pixmap */  
  GdkWindow *pixmap;    

  /* offsets for scrolling */
  gint hoffset;
  gint voffset;
  gfloat old_hadjustment;
  gfloat old_vadjustment;
  
  /* border shadow style */
  GtkShadowType shadow_type;
  
  /* Column Titles */
  GdkRectangle column_title_area;
  GdkWindow *column_title_window;

  /* Row Titles */
  GdkRectangle row_title_area;
  GdkWindow *row_title_window;

  /*scrollbars*/
  GtkAdjustment *hadjustment;
  GtkAdjustment *vadjustment;

  /* xor GC for the verticle drag line */
  GdkGC *xor_gc;

  /* gc for drawing unselected cells */
  GdkGC *fg_gc;
  GdkGC *bg_gc;

  /* cursor used to indicate dragging */
  GdkCursor *cursor_drag;

  /* the current x-pixel location of the xor-drag vline */
  gint x_drag;

  /* the current y-pixel location of the xor-drag hline */
  gint y_drag;

  /* current cell being dragged */
  GtkSheetCell drag_cell;
  /* current range being dragged */
  GtkSheetRange drag_range;

  /* clipped range */
  GtkSheetRange clip_range;
};

struct _GtkSheetClass
{
 GtkContainerClass parent_class;
 
 void (*set_scroll_adjustments) (GtkSheet *sheet,
				 GtkAdjustment *hadjustment,
				 GtkAdjustment *vadjustment);

 void (*select_row) 		(GtkSheet *sheet, gint row);

 void (*select_column) 		(GtkSheet *sheet, gint column);

 void (*select_range) 		(GtkSheet *sheet, GtkSheetRange *range);

 void (*clip_range) 		(GtkSheet *sheet, GtkSheetRange *clip_range);

 void (*resize_range)		(GtkSheet *sheet,
	                	GtkSheetRange *old_range,
                        	GtkSheetRange *new_range);

 void (*move_range)    		(GtkSheet *sheet,
	                	GtkSheetRange *old_range,
                        	GtkSheetRange *new_range);

 gboolean (*traverse)       	(GtkSheet *sheet,
                         	gint row, gint column,
                         	gint *new_row, gint *new_column);

 gboolean (*deactivate)	 	(GtkSheet *sheet,
	                  	gint row, gint column);

 gboolean (*activate) 		(GtkSheet *sheet,
	                	gint row, gint column);

 void (*set_cell) 		(GtkSheet *sheet,
	           		gint row, gint column);

 void (*clear_cell) 		(GtkSheet *sheet,
	           		gint row, gint column);

 void (*changed) 		(GtkSheet *sheet,
	          		gint row, gint column);

 void (*new_column_width)       (GtkSheet *sheet,
                                 gint col,
                                 gint width);

 void (*new_row_height)       	(GtkSheet *sheet,
                                 gint row,
                                 gint height);

};
  
GtkType gtk_sheet_get_type (void);
GtkType gtk_sheet_range_get_type (void);

/* create a new sheet */
GtkWidget *
gtk_sheet_new 				(gint rows, gint columns, const gchar *title);

/* create a new browser sheet. It cells can not be edited */
GtkWidget *
gtk_sheet_new_browser 			(gint rows, gint columns, const gchar *title);

/* create a new sheet with custom entry */
GtkWidget *
gtk_sheet_new_with_custom_entry 	(gint rows, gint columns, const gchar *title,
                                 	GtkType entry_type);
/* change scroll adjustments */
void
gtk_sheet_set_hadjustment		(GtkSheet *sheet,
					 GtkAdjustment *adjustment); 
void
gtk_sheet_set_vadjustment		(GtkSheet *sheet,
					 GtkAdjustment *adjustment); 
/* Change entry */
void
gtk_sheet_change_entry			(GtkSheet *sheet, GtkType entry_type);

/* Returns sheet's entry widget */
GtkWidget *
gtk_sheet_get_entry			(GtkSheet *sheet);

/* Returns sheet->state 
 * Added by Steven Rostedt <steven.rostedt@lmco.com> */
gint
gtk_sheet_get_state 			(GtkSheet *sheet);

/* Returns sheet's ranges 
 * Added by Murray Cumming */
gint
gtk_sheet_get_columns_count 		(GtkSheet *sheet);

gint
gtk_sheet_get_rows_count 		(GtkSheet *sheet);

gint
gtk_sheet_get_max_alloc_col 		(GtkSheet *sheet);

gint
gtk_sheet_get_max_alloc_row		(GtkSheet *sheet);

void
gtk_sheet_get_visible_range		(GtkSheet *sheet,
					 GtkSheetRange *range);
void
gtk_sheet_set_selection_mode		(GtkSheet *sheet, gint mode);
/* set sheet title */
void
gtk_sheet_set_title 			(GtkSheet *sheet, const gchar *title);

/* freeze all visual updates of the sheet.
 * Then thaw the sheet after you have made a number of changes.
 * The updates will occure in a more efficent way than if
 * you made them on a unfrozen sheet */
void
gtk_sheet_freeze			(GtkSheet *sheet);
void
gtk_sheet_thaw				(GtkSheet *sheet);

/* set column title */ 
void
gtk_sheet_set_column_title 		(GtkSheet * sheet,
			    		gint column,
			    		const gchar * title);

/* set row title */
void
gtk_sheet_set_row_title 		(GtkSheet * sheet,
			    		gint row,
			    		const gchar * title);

/* set button label */
void
gtk_sheet_row_button_add_label		(GtkSheet *sheet, 
					gint row, const gchar *label);
void
gtk_sheet_column_button_add_label	(GtkSheet *sheet, 
					gint column, const gchar *label);
void
gtk_sheet_row_button_justify		(GtkSheet *sheet, 
					gint row, GtkJustification justification);
void
gtk_sheet_column_button_justify		(GtkSheet *sheet, 
					gint column, GtkJustification justification);

/* scroll the viewing area of the sheet to the given column
 * and row; row_align and col_align are between 0-1 representing the
 * location the row should appear on the screnn, 0.0 being top or left,
 * 1.0 being bottom or right; if row or column is negative then there
 * is no change */
void
gtk_sheet_moveto (GtkSheet * sheet,
		  gint row,
		  gint column,
	          gfloat row_align,
                  gfloat col_align);

/* resize column/row titles window */
void 
gtk_sheet_set_row_titles_width(GtkSheet *sheet, gint width);
void 
gtk_sheet_set_column_titles_height(GtkSheet *sheet, gint height);

/* show/hide column/row titles window */
void
gtk_sheet_show_column_titles		(GtkSheet *sheet);
void
gtk_sheet_show_row_titles		(GtkSheet *sheet);
void
gtk_sheet_hide_column_titles		(GtkSheet *sheet);
void
gtk_sheet_hide_row_titles		(GtkSheet *sheet);

/* set column button sensitivity. If sensitivity is TRUE it can be toggled,  
 *  otherwise it acts as a title */
void 
gtk_sheet_column_set_sensitivity	(GtkSheet *sheet, 
					gint column, gboolean sensitive);

/* set sensitivity for all column buttons */
void
gtk_sheet_columns_set_sensitivity	(GtkSheet *sheet, gboolean sensitive);


/* set row button sensitivity. If sensitivity is TRUE can be toggled, 
 * otherwise it acts as a title */
void 
gtk_sheet_row_set_sensitivity		(GtkSheet *sheet, 
					gint row,  gboolean sensitive);

/* set sensitivity for all row buttons */
void
gtk_sheet_rows_set_sensitivity		(GtkSheet *sheet, gboolean sensitive);

/* set column visibility. The default value is TRUE. If FALSE, the 
 * column is hidden */
void
gtk_sheet_column_set_visibility		(GtkSheet *sheet, 
					gint column, gboolean visible);
void
gtk_sheet_column_label_set_visibility	(GtkSheet *sheet, 
					gint column, gboolean visible);
void
gtk_sheet_columns_labels_set_visibility	(GtkSheet *sheet, gboolean visible);

/* set row visibility. The default value is TRUE. If FALSE, the 
 * row is hidden */
void
gtk_sheet_row_set_visibility		(GtkSheet *sheet, 
					 gint row, gboolean visible);
void
gtk_sheet_row_label_set_visibility	(GtkSheet *sheet, 
					 gint row, gboolean visible);
void
gtk_sheet_rows_labels_set_visibility	(GtkSheet *sheet, gboolean visible);


/* select the row. The range is then highlighted, and the bounds are stored
 * in sheet->range  */
void
gtk_sheet_select_row 			(GtkSheet * sheet,
		      			gint row);

/* select the column. The range is then highlighted, and the bounds are stored
 * in sheet->range  */
void
gtk_sheet_select_column 		(GtkSheet * sheet,
		         		gint column);

/* save selected range to "clipboard" */
void
gtk_sheet_clip_range 			(GtkSheet *sheet, GtkSheetRange *range);
/* free clipboard */
void
gtk_sheet_unclip_range			(GtkSheet *sheet);

/* get scrollbars adjustment */
GtkAdjustment *
gtk_sheet_get_vadjustment 		(GtkSheet * sheet);
GtkAdjustment *
gtk_sheet_get_hadjustment 		(GtkSheet * sheet);

/* highlight the selected range and store bounds in sheet->range */
void gtk_sheet_select_range		(GtkSheet *sheet, 
					 const GtkSheetRange *range); 

/* obvious */
void gtk_sheet_unselect_range		(GtkSheet *sheet); 

/* set active cell where the entry will be displayed 
 * returns FALSE if current cell can't be deactivated or
 * requested cell can't be activated */
gint
gtk_sheet_set_active_cell 		(GtkSheet *sheet, 
					gint row, gint column);
void
gtk_sheet_get_active_cell 		(GtkSheet *sheet, 
					gint *row, gint *column);

/* set cell contents and allocate memory if needed */
void 
gtk_sheet_set_cell			(GtkSheet *sheet, 
					int row, gint col, 
                                        GtkJustification justification,
                   			const gchar *text);
void 
gtk_sheet_set_cell_text			(GtkSheet *sheet, 
					int row, gint col,
                   			const gchar *text);

/* get cell contents */
gchar *     
gtk_sheet_cell_get_text 		(GtkSheet *sheet, gint row, gint col);


/* clear cell contents */
void 
gtk_sheet_cell_clear			(GtkSheet *sheet, gint row, gint col);
/* clear cell contents and remove links */
void 
gtk_sheet_cell_delete			(GtkSheet *sheet, gint row, gint col);

/* clear range contents. If range==NULL the whole sheet will be cleared */
void 
gtk_sheet_range_clear			(GtkSheet *sheet, 
					 const GtkSheetRange *range);
/* clear range contents and remove links */
void 
gtk_sheet_range_delete			(GtkSheet *sheet, 
					 const GtkSheetRange *range);

/* get cell state: GTK_STATE_NORMAL, GTK_STATE_SELECTED */
int
gtk_sheet_cell_get_state 		(GtkSheet *sheet, gint row, gint col);

/* Handles cell links */
void
gtk_sheet_link_cell			(GtkSheet *sheet, gint row, gint col,
 					 gpointer link);

gpointer
gtk_sheet_get_link			(GtkSheet *sheet, gint row, gint col);
void
gtk_sheet_remove_link			(GtkSheet *sheet, gint row, gint col);

/* get row and column correspondig to the given position in the screen */
gint
gtk_sheet_get_pixel_info (GtkSheet * sheet,
			  gint x,
			  gint y,
			  gint * row,
			  gint * column);

/* get area of a given cell */
gint
gtk_sheet_get_cell_area (GtkSheet *sheet,
                         gint row,
                         gint column,
                         GdkRectangle *area);

/* set column width */
void
gtk_sheet_set_column_width (GtkSheet * sheet,
			    gint column,
			    gint width);

/* set row height */
void
gtk_sheet_set_row_height (GtkSheet * sheet,
			  gint row,
			  gint height);

/* append ncols columns to the end of the sheet */
void
gtk_sheet_add_column			(GtkSheet *sheet, gint ncols);

/* append nrows row to the end of the sheet */
void
gtk_sheet_add_row			(GtkSheet *sheet, gint nrows);

/* insert nrows rows before the given row and pull right */
void
gtk_sheet_insert_rows			(GtkSheet *sheet, gint row, gint nrows);

/* insert ncols columns before the given col and pull down */
 void
gtk_sheet_insert_columns		(GtkSheet *sheet, gint col, gint ncols);

/* delete nrows rows starting in row */
void
gtk_sheet_delete_rows			(GtkSheet *sheet, gint row, gint nrows);

/* delete ncols columns starting in col */
void
gtk_sheet_delete_columns		(GtkSheet *sheet, gint col, gint ncols);

/* set abckground color of the given range */
void
gtk_sheet_range_set_background		(GtkSheet *sheet, 
					GtkSheetRange *range, 
					GdkColor *color);

/* set foreground color (text color) of the given range */
void
gtk_sheet_range_set_foreground		(GtkSheet *sheet, 
					GtkSheetRange *range, 
					GdkColor *color);

/* set text justification (GTK_JUSTIFY_LEFT, RIGHT, CENTER) of the given range.
 * The default value is GTK_JUSTIFY_LEFT. If autoformat is on, the
 * default justification for numbers is GTK_JUSTIFY_RIGHT */
void
gtk_sheet_range_set_justification	(GtkSheet *sheet, 
					GtkSheetRange *range, 
					GtkJustification justification);
void
gtk_sheet_column_set_justification      (GtkSheet *sheet,
                                        gint column,
                                        GtkJustification justification);
/* set if cell contents can be edited or not in the given range:
 * accepted values are TRUE or FALSE. */
void
gtk_sheet_range_set_editable		(GtkSheet *sheet, 
					GtkSheetRange *range, 
					gint editable);

/* set if cell contents are visible or not in the given range:
 * accepted values are TRUE or FALSE.*/
void
gtk_sheet_range_set_visible		(GtkSheet *sheet, 
					GtkSheetRange *range, 
					gint visible);

/* set cell border style in the given range.
 * mask values are CELL_LEFT_BORDER, CELL_RIGHT_BORDER, CELL_TOP_BORDER,
 * CELL_BOTTOM_BORDER
 * width is the width of the border line in pixels 
 * line_style is the line_style for the border line */
void
gtk_sheet_range_set_border		(GtkSheet *sheet, 
					GtkSheetRange *range, 
					gint mask, 
					gint width, 
					gint line_style);

/* set border color for the given range */
void
gtk_sheet_range_set_border_color	(GtkSheet *sheet, 
					GtkSheetRange *range, 
					GdkColor *color);

/* set font for the given range */
void
gtk_sheet_range_set_font		(GtkSheet *sheet, 
					GtkSheetRange *range, 
					GdkFont *font);

/* get cell attributes of the given cell */
/* TRUE means that the cell is currently allocated */
gboolean
gtk_sheet_get_attributes		(GtkSheet *sheet, 
					gint row, gint col, 
					GtkSheetCellAttr *attributes);


GtkSheetChild *
gtk_sheet_put 				(GtkSheet *sheet, 
					 GtkWidget *widget, 
					 gint x, gint y);

void
gtk_sheet_attach			(GtkSheet *sheet,
					 GtkWidget *widget,
					 gint row, gint col,
					 gfloat x_align, gfloat y_align);

void
gtk_sheet_move_child 			(GtkSheet *sheet, 
					 GtkWidget *widget, 
					 gint x, gint y);

GtkSheetChild *
gtk_sheet_get_child_at			(GtkSheet *sheet, 
					 gint row, gint col);

void
gtk_sheet_button_attach			(GtkSheet *sheet,
					 GtkWidget *widget,
					 gint row, gint col,
					 gfloat x_align, gfloat y_align);
                       

#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* __GTK_SHEET_H__ */


