// SGridAutoCell.h
#import "UIKit/UIKit.h"
#import "SGridCell.h"

@interface SGridAutoCell : SGridCell <UITextFieldDelegate> {
    @private
    BOOL useOwnTextColor;
    BOOL useOwnFont;
}

/** SGridAutoCell subclasses SGridCell in a way which provides an easy mechanism for populating your cells with text content. The SGridAutoCell object has a textField property for convenience. Set the text of this property (`[textField setText:stringObject]`) to quickly generate content for a SGridAutoCell object. SGridAutoCells are editable by the user via double tapping - see the canEditCellsViaDoubleTap property of SGrid to enable this.*/

/** Any text provided to this textfield will be automatically displayed for this cell.*/
@property (nonatomic, retain) UITextField *textField;

@end
