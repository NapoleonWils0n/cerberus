# Cheat sheet

## Pandoc’s markdown

### Paragraphs

A paragraph is one or more lines of text followed by one or more blank lines. Newlines are treated as spaces, so you can reflow your paragraphs as you like. If you need a hard line break, put two or more spaces at the end of a line.

### Headers

There are two kinds of headers, Setext and atx.

#### Setext-style headers

A setext-style header is a line of text “underlined” with a row of = signs (for a level one header) or - signs (for a level two header):

	A level-one header
	==================

A level-one header
==================

	A level-two header
	------------------

A level-two header
------------------


#### Atx-style headers

An Atx-style header consists of one to six # signs and a line of text, optionally followed by any number of # signs. The number of # signs at the beginning of the line is the header level:

	# A level-one header

# A level-one header

	## A level-two header 

## A level-two header 

As with setext-style headers, the header text can contain formatting:

	# A level-one header with a [link](/url) and *emphasis*

# A level-one header with a [link](/url) and *emphasis*


### Block quotations

Markdown uses email conventions for quoting blocks of text. A block quotation is one or more paragraphs or other block elements (such as lists or headers), with each line preceded by a > character and a space. (The > need not start at the left margin, but it should not be indented more than three spaces.)


	> This is a block quote. This
	> paragraph has two lines.
	>
	> 1. This is a list inside a block quote.
	> 2. Second item.
		
> This is a block quote. This
> paragraph has two lines.
>
> 1. This is a list inside a block quote.
> 2. Second item.

A “lazy” form, which requires the > character only on the first line of each block, is also allowed:

	> This is a block quote. This
	paragraph has two lines.

	> 1. This is a list inside a block quote.
	2. Second item.

> This is a block quote. This
paragraph has two lines.

> 1. This is a list inside a block quote.
2. Second item.

Among the block elements that can be contained in a block quote are other block quotes. That is, block quotes can be nested:

	> This is a block quote.
	>
	> > A block quote within a block quote.

> This is a block quote.
>
> > A block quote within a block quote.

### Verbatim (code) blocks

#### Indented code blocks

A block of text indented four spaces (or one tab) is treated as verbatim text: that is, special characters do not trigger special formatting, and all spaces and line breaks are preserved. For example,

    if (a > 3) {
	       moveShip(5 * gravity, DOWN);
			     }

The initial (four space or one tab) indentation is not considered part of the verbatim text, and is removed in the output.

Note: blank lines in the verbatim text need not begin with four spaces.

### Line blocks

A line block is a sequence of lines beginning with a vertical bar (|) followed by a space. The division into lines will be preserved in the output, as will any leading spaces; otherwise, the lines will be formatted as markdown. This is useful for verse and addresses:

	| The limerick packs laughs anatomical
	| In space that is quite economical.
	|    But the good ones I've seen
	|    So seldom are clean
	| And the clean ones so seldom are comical

	| 200 Main St.
	| Berkeley, CA 94718

| The limerick packs laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are clean
| And the clean ones so seldom are comical

| 200 Main St.
| Berkeley, CA 94718

The lines can be hard-wrapped if needed, but the continuation line must begin with a space.

	| The Right Honorable Most Venerable and Righteous Samuel L.
	  Constable, Jr.
	| 200 Main St.
	| Berkeley, CA 94718

| The Right Honorable Most Venerable and Righteous Samuel L.
  Constable, Jr.
| 200 Main St.
| Berkeley, CA 94718

### Lists

#### Bullet lists

A bullet list is a list of bulleted list items. A bulleted list item begins with a bullet (\*, +, or -). Here is a simple example:

	* one
	* two
	* three

* one
* two
* three

This will produce a “compact” list. If you want a “loose” list, in which each item is formatted as a paragraph, put spaces between the items:

	* one

	* two

	* three

* one

* two

* three

The bullets need not be flush with the left margin; they may be indented one, two, or three spaces. The bullet must be followed by whitespace.

List items look best if subsequent lines are flush with the first line (after the bullet):

	* here is my first
	  list item.
	* and my second.	

* here is my first
  list item.
* and my second.

But markdown also allows a “lazy” format:

	* here is my first
	list item.
	* and my second.

* here is my first
list item.
* and my second.

#### The four-space rule

A list item may contain multiple paragraphs and other block-level content. However, subsequent paragraphs must be preceded by a blank line and indented four spaces or a tab. The list will look better if the first paragraph is aligned with the rest:

		  * First paragraph.

		    Continued.

		  * Second paragraph. With a code block, which must be indented
		    eight spaces:

     		   { code }


  * First paragraph.

    Continued.

  * Second paragraph. With a code block, which must be indented
    eight spaces:

        { code }

List items may include other lists. In this case the preceding blank line is optional. The nested list must be indented four spaces or one tab:
	
	* fruits
		 + apples
			  - macintosh
			  - red delicious
		 + pears
		 + peaches
	* vegetables
		 + broccoli
		 + chard
		
* fruits
    + apples
        - macintosh
        - red delicious
    + pears
    + peaches
* vegetables
    + broccoli
    + chard

As noted above, markdown allows you to write list items “lazily,” instead of indenting continuation lines. However, if there are multiple paragraphs or other blocks in a list item, the first line of each must be indented.

	+ A lazy, lazy, list
	item.

	+ Another one; this looks
	bad but is legal.

		 Second paragraph of second
	list item.

+ A lazy, lazy, list
item.

+ Another one; this looks
bad but is legal.

    Second paragraph of second
list item.

### Ordered lists

Ordered lists work just like bulleted lists, except that the items begin with enumerators rather than bullets.

In standard markdown, enumerators are decimal numbers followed by a period and a space. The numbers themselves are ignored, so there is no difference between this list:

	1.  one
	2.  two
	3.  three

1.  one
2.  two
3.  three

and this one:

	5.  one
	7.  two
	1.  three

5.  one
7.  two
1.  three

### Extension: startnum

Pandoc also pays attention to the type of list marker used, and to the starting number, and both of these are preserved where possible in the output format. Thus, the following yields a list with numbers followed by a single parenthesis, starting with 9, and a sublist with lowercase roman numerals:

	9)  Ninth
	10)  Tenth
	11)  Eleventh
			 i. subone
			ii. subtwo
		  iii. subthree

9)  Ninth
10)  Tenth
11)  Eleventh
       i. subone
      ii. subtwo
     iii. subthree

Pandoc will start a new list each time a different type of list marker is used. So, the following will create three lists:

	(2) Two
	(5) Three
	1.  Four
	*   Five

(2) Two
(5) Three
1.  Four
*   Five

If default list markers are desired, use #.:

	#.  one
	#.  two
	#.  three

#.  one
#.  two
#.  three

### Definition lists

Pandoc supports definition lists, using the syntax of PHP Markdown Extra with some extensions.

	Term 1

	:   Definition 1

	Term 2 with *inline markup*

	:   Definition 2

			  { some code, part of Definition 2 }

		 Third paragraph of definition 2.

Term 1

:   Definition 1

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

Each term must fit on one line, which may optionally be followed by a blank line, and must be followed by one or more definitions. A definition begins with a colon or tilde, which may be indented one or two spaces.

A term may have multiple definitions, and each definition may consist of one or more block elements (paragraph, code block, list, etc.), each indented four spaces or one tab stop. The body of the definition (including the first line, aside from the colon or tilde) should be indented four spaces. However, as with other markdown lists, you can “lazily” omit indentation except at the beginning of a paragraph or other block element:

	Term 1

	:   Definition
	with lazy continuation.

		 Second paragraph of the definition.

Term 1

:   Definition
with lazy continuation.

    Second paragraph of the definition.

If you leave space before the definition (as in the example above), the text of the definition will be treated as a paragraph. In some output formats, this will mean greater spacing between term/definition pairs. For a more compact definition list, omit the space before the definition:

	Term 1
	  ~ Definition 1

	Term 2
	  ~ Definition 2a
	  ~ Definition 2b

Term 1
  ~ Definition 1

Term 2
  ~ Definition 2a
  ~ Definition 2b

### Ending a list

What if you want to put an indented code block after a list?

	-   item one
	-   item two

		 { my code block }

-   item one
-   item two

    { my code block }

Trouble! Here pandoc (like other markdown implementations) will treat { my code block } as the second paragraph of item two, and not as a code block.

To “cut off” the list after item two, you can insert some non-indented content, like an HTML comment, which won’t produce visible output in any format:

	-   item one
	-   item two

	<!-- end of list -->

		 { my code block }

-   item one
-   item two

<!-- end of list -->

    { my code block }

You can use the same trick if you want two consecutive lists instead of one big list:

	1.  one
	2.  two
	3.  three

	<!-- -->

	1.  uno
	2.  dos
	3.  tres

1.  one
2.  two
3.  three

<!-- -->

1.  uno
2.  dos
3.  tres

### Horizontal rules

A line containing a row of three or more -, or _ characters (optionally separated by spaces) produces a horizontal rule:

	---------------

---------------

### Emphasis

To emphasize some text, surround it with \*s or \_, like this:

	This text is _emphasized with underscores_, and this
	is *emphasized with asterisks*.

This text is _emphasized with underscores_, and this
is *emphasized with asterisks*.

Double * or _ produces strong emphasis:

	This is **strong emphasis** and __with underscores__.

This is **strong emphasis** and __with underscores__.

### Links

Markdown allows links to be specified in several ways.

#### Automatic links

If you enclose a URL or email address in pointy brackets, it will become a link:

	<http://google.com>

<http://google.com>

#### Inline links

An inline link consists of the link text in square brackets, followed by the URL in parentheses. (Optionally, the URL can be followed by a link title, in quotes.)

	This is an [inline link](/url), and here's [one with
	a title](http://fsf.org "click here for a good time!").

This is an [inline link](/url), and here's [one with
a title](http://fsf.org "click here for a good time!").

There can be no space between the bracketed part and the parenthesized part. The link text can contain formatting (such as emphasis), but the title cannot.

### Page links

	[Networks](/networks/index)

[Networks](/networks/index)


### Images

A link immediately preceded by a ! will be treated as an image. The link text will be used as the image’s alt text:

	![alt text](http://mediablends.org.uk/uploads/barryandpatricia.png)

![alt text](http://mediablends.org.uk/uploads/barryandpatricia.png)

#### Extension: implicit_figures

An image occurring by itself in a paragraph will be rendered as a figure with a caption. (In LaTeX, a figure environment will be used; in HTML, the image will be placed in a div with class figure, together with a caption in a p with class caption.) The image’s alt text will be used as the caption.

	![alt text](http://mediablends.org.uk/uploads/barryandpatricia.png)

![alt text](http://mediablends.org.uk/uploads/barryandpatricia.png)

If you just want a regular inline image, just make sure it is not the only thing in the paragraph. One way to do this is to insert a nonbreaking space after the image:

	![alt text](http://mediablends.org.uk/uploads/barryandpatricia.png)\

![alt text](http://mediablends.org.uk/uploads/barryandpatricia.png)\

