# Developing iOS Apps with Swift - Assignment 1 - Calculator

Completed Assignment 1 from Paul Hegarty's CS193P iOS Application Development Course.

The base of the code is from the [video lectures](https://www.youtube.com/channel/UCYVp6suz7ztKAKY8jpfACXA/videos) with my additions for the tasks. Code was written then i came back and added the tests, so not TDD.

 I'm unsure if there are some tests that are unnecessary as they seem to overlap from the UI tests? Also unsure if for loops in tests are good or not, noticeable downside when they fail is that you don't get an output of why but just that the test failed.

Some noticeable areas that need to be refactored are around the description output within the calculator brain. I'm sure i've approached it in the wrong way but am yet to see the light.

## Required Tasks

1. Get the Calculator working as demonstrated in lectures 1 and 2.
2. Your Calculator already works with floating point numbers (e.g. if you touch 3 ÷ 4 =, it will properly show 0.75), however, there is no way for the user to enter a floating point number directly. Fix this by allowing legal floating point numbers to be entered (e.g. “192.168.0.1” is not a legal floating point number!). You will need to have a “.” button in your calculator. Don’t worry too much about precision or significant digits in this assignment (doing so is Extra Credit).
3. Add some more operations buttons to your calculator such that it has at least a dozen operations total (it can have even more if you like). You can choose whatever operations appeal to you. The buttons must arrange themselves nicely in portrait and landscape modes on all iPhone 6’s and 7’s.
4. Use color to make your UI look nice. At the very least, your operations buttons must be a different color than your keypad buttons, but otherwise you can use color in whatever way you think looks nice.
5. Add a Bool property to your CalculatorBrain called resultIsPending which returns whether there is a binary operation pending.
6. Add a String property to your CalculatorBrain called description which returns a description of the sequence of operands and operations that led to the value returned by result (or the result so far if resultIsPending). The character = (the equals sign) should never appear in this description, nor should ... (ellipses).
7. Implement a UILabel in your UI which shows the sequence of operands and operations that led to (or is leading to if resultIsPending) what is (or “will be” if resultIsPending) showing in the display. If resultIsPending is true, put . . . on the end of the UILabel, else put =. If the userIsInTheMiddleOfTyping, you can leave the UILabel showing whatever was there before the user started typing the number. Examples ...

      a. touching 7 + would show “7 + ...” (with 7 still in the display)

      b. 7 + 9 would show “7 + ...” (9 in the display)

      c. 7 + 9 = would show “7 + 9 =” (16 in the display)

      d. 7 + 9 = √ would show “√(7 + 9) =” (4 in the display)

      e. 7 + 9 = √ + 2 = would show “√(7 + 9) + 2 =” (6 in the display)

      f. 7 + 9 √ would show “7 + √(9) ...” (3 in the display)

      g. 7 + 9 √ = would show “7 + √(9) =“ (10 in the display)

      h. 7 + 9 = + 6 = + 3 = would show “7 + 9 + 6 + 3 =” (25 in the display)

      i. 7 + 9 = √ 6 + 3 = would show “6 + 3 =” (9 in the display)

      j. 5 + 6 = 7 3 would show “5 + 6 =” (73 in the display)

      k. 4 × π = would show “4 × π =“ (12.5663706143592 in the display)

8. Add a C button that clears everything (your display, the new UILabel you added above, any pending binary operations, etc.). Ideally, this should leave your Calculator in the same state it was in when you launched it.

## Extra Credit

1. Implement a “backspace” button for the user to touch if they hit the wrong digit button. This is not intended to be “undo,” so if the user hits the wrong operation button, he or she is out of luck! It is up to you to decide how to handle the case where the user backspaces away the entire number they are in the middle of typing. You will probably find the Strings and Characters section of the Swift Reference Guide to be helpful here.
2. Figure out from the documentation how to use the iOS struct NumberFormatter to format your display so that it only shows 6 digits after the decimal point (instead of showing all digits that can be represented in a Double). This will eliminate (or at least reduce) the need for Autoshrink in your display. While you’re at it, make it so that numbers that are integers don’t have an unnecessary “.0” attached to them (e.g. show “4” rather than “4.0” as the result of the square root of sixteen). You can do all this for your description in the CalculatorBrain as well.
3. Make one of your operation buttons be“generate a random double-precision floating point number between 0 and 1”. This operation button is not a constant (since it changes each time you invoke it). Nor is it a unary operation (since it does not operate on anything). Probably the easiest way to generate a random number in iOS is the global Swift function arc4random() which generates a random number between 0 and the largest possible 32-bit integer (UInt32.max). You’ll have to get to double precision floating point number from there, of course.
