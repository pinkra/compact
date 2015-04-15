compact
=======

JS and CSS useful compacter

Example
=======

What follows is the index_dev.html file with all js and css imports and some
operative comments that will be parsed by compact.
In the following example all js and css without comments will be minimized and
replaced by a prod.js and prod.css that will be imported in index.html
All js and css files followed by <!-- @minimize skip --> comments are not
minimized and will be reported in the index.html as they are.
All js and css files followed by <!-- @minimize replace with <string> --> are
replaced in index.html with the included string.

<html>
  <head>
    ...

    <link rel="stylesheet" href="css/main.css" type="text/css" />
    <link rel="stylesheet" href="css/smoothness/jquery-ui.min.css" type="text/css" /> <!-- @minimize skip -->
    <script src="vendor/jquery.min.js"></script> <!-- @minimize skip -->
    <script src="vendor/jquery-ui/jquery-ui.min.js"></script> <!-- @minimize skip -->
    <script src="vendor/candy/candy.bundle.js"></script> <!-- @minimize replace with vendor/candy/candy.min.js -->
    ...

Configuration
=============

All input and output files are read from config.compact configuration file.
Copy the sample file config.compact.sample and edit it.
You can specify a different config file with '-c' option.
