// SGridArithmeticCell.h
@class SGridNumberCell;

/** SGridArithmeticCell subclasses SGridNumberCell in a way which provides an
 easy mechanism for doing simple calculations in a grid cell.
 The SGridArithmeticCell object will evaulate an expression beginning with an
 '=' character, and display the result.  SGridArithmeticCells can be double
 tapped to bring up an editing keyboard which will display the current formula
 in the cell - see the canEditCellsViaDoubleTap property of SGrid to enable
 this.*/

@interface SGridArithmeticCell : SGridNumberCell {
    NSString *formula;
    struct token *currentToken;
}

@end
