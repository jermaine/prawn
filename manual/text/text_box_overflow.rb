# encoding: utf-8
#
# The <code>text_box</code> method accepts both <code>:width</code> and
# <code>:height</code> options. So what happens if the text doesn't fit the box?
#
# The default behavior is to truncate the text but this can be changed with
# the <code>:overflow</code> option. Available modes are <code>:ellipses</code>
# (will truncate and show ellipses at the end of the box), <code>:expand</code>
# (the box will increase to fit the text) and <code>:shrink_to_fit</code>
# (the text font size will be shrunk to fit).
#
# If <code>:shrink_to_fit</code> mode is used with the
# <code>:min_font_size</code> option set. The font size will not be reduced to
# less than the value provided even if it means truncating some text.
#
require File.expand_path(File.join(File.dirname(__FILE__),
                                   %w[.. example_helper]))

filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::Example.generate(filename) do
  string = "This is the sample text used for the text boxes. See how it " +
           "behave with the various overflow options used."

  text string
  
  y_position = cursor - 20
  [:truncate, :ellipses, :expand, :shrink_to_fit].each_with_index do |mode, i|
    text_box string, :at => [i * 150, y_position],
             :width => 100, :height => 50,
             :overflow => mode
  end
  
  string = "If the box is too small for the text, :shrink_to_fit " +
           "can render the text in a really small font size."
  
  move_down 120
  text string
  y_position = cursor - 20
  [nil, 8, 10, 12].each_with_index do |value, index|
    text_box string, :at => [index * 150, y_position],
             :width => 50, :height => 50,
             :overflow => :shrink_to_fit,
             :min_font_size => value
  end
end
