require 'listen'

def rename_file_extension(source, extension)
  dirname  = File.dirname(source)
  basename = File.basename(source, ".*")
  extname  = File.extname(source)
  if extname == ""
    if basename[0,1]=="."
      target = dirname + "/." + extension
    else
      target = source + "." + extension
    end
  else
    target = dirname + "/" + basename + "." + extension
  end
  target
end

Listen.to('.', :filter => /\.haml$/) do |modified, added, removed|
  for changed in (modified + added)
    system "haml #{changed} #{rename_file_extension(changed, 'html')}"
    p "#{changed} updated"
  end
end