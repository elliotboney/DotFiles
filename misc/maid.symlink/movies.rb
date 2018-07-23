Maid.rules do
  rule 'Clean Up Movies' do
    dir('~/Downloads/02 Movies/*').each do |path|
      if File.directory?(path)
        # Start the sizeof
        dir(path+"/*").each do |file|
          puts "#{file}\n"
          begin
            if (size_of(file) < 100000000 && !File.directory?(file))
              puts "Killing sample or garbage file #{file}\n"
              trash(file)
              next
            end
          rescue
            puts "\033[31mError getting path size of: #{file}\n\033[0m"
          end
        end
      end
    end
  end
end