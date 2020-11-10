# MSAM-Kaleidoscope

This a MSAM Kaledidoscope Project 

THIS PROJECT WILL NOT RUN WITHOUT THE IRVINE32.INC LIBRARY 

This is a simple MSAM project where we will output a 24x24 grid of colors with 4 fold symmetry. The project will do this forever

The code works like this, we will populate an array length of 24 with random BYTE values between 1-12. We will fill the first 12 spots and then mirror the 12 spots 
in the remaining 12 spots. Then we will print out this array using our inputed BYTE values. Each number correlates with a color. The print function will print the first
color at the top, and then move to the bottom of the screen and print off the same color. The x value will then increase and print off the next set of colors untill we 
have 2 matching lines at the top and bottom. The y val will be incremented by 1 and the next 2 lines will printed off below the top line and above the bottom most line. 
The program will repeat itself untill all lines are filled up and the Kaledidoscope is created


<h1>Here is what the Kalediscope looks like </h1>

![example](https://github.com/georgebjork/MSAM-Kaleidoscope/blob/master/Images/example.png)

<h1>Here is a sample output</h1>

![examplegif](https://github.com/georgebjork/MSAM-Kaleidoscope/blob/master/Images/exampleVid.gif)
