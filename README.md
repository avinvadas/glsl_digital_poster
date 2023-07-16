# glsl_digital_poster
## what is this?
a boiler-plate test to combine glsl shader graphics in web-design projects.
The .glsl shadeer file ( shader01_frgmt.glsl ) draws values from CSS Variables stored in :root at style.css, through index.js file.

## How to run?
- install Three.js
- Install Parcel.js or an alternative
Clone the repository to your local machine and compile the index.html file through Parcel.js or similar. You can change the :root vars in style.css:
--color_primary (color)
--unit_column (grid column width in vmin units)
Refresh the page and see the updates.

## What else?
Live sample of the graphics can be seen at:
https://codepen.io/avinvadas/pen/wvQyawG

(Variables can't be read there, because the glsl must be included as inline markup).

