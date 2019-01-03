#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "tinify" # gem install tinify

DIR_PATH = "/Users/husor1/Desktop/XXX"
#500次,用完自行注册
TINIFY_KEY = "sftdcfvkg3TGH1sGKD0JmHK1GdV6TJb2"  #https://tinypng.com/dashboard/api
Tinify.key = TINIFY_KEY

class ImageManager
   
    def initialize(path = "") 
        @root_path = path
        @imageSize_total = 0
        @all_imagePaths = []
        traverse(@root_path ) 
        puts "\033[31m------------ begin ------------\033[0m\n"
        puts "准备压缩文件列表:"
        @all_imagePaths.each { |filePath|
            puts File.basename(filePath).to_s 
        }
     
    end
    
    def calculate_image_total
        @imageSize_total = 0
        @all_imagePaths.each { |filePath|
            @imageSize_total = @imageSize_total + File.size(filePath)/1024.0            
        }
    end

    def handle_image(filePath)
        puts "\033[32m >>>>正在压缩图片 : #{File.basename(filePath) } \033[0m\n"
        old_size = (File.size(filePath)/1024.0).to_s
        source = Tinify.from_file(filePath)
        source.to_file(filePath)
        new_size = (File.size(filePath)/1024.0).to_s
        puts "压缩前: #{old_size} 压缩后: #{new_size}"        
    end

    def traverse(filepath)
        if File.directory?(filepath)
            Dir.foreach(filepath) do |filename|
                if filename != "." and filename != ".."
                  traverse(filepath + "/" + filename)
                end
            end
        else
            if File.extname(filepath) == ".png"
                @all_imagePaths << filepath
            end            
        end
    end
    #compress_pictures
    def run
        puts "---------------->"
           calculate_image_total        
        puts "压缩前图片总大小: " + format("%.2f", @imageSize_total) + " KB"
        
        @all_imagePaths.each { |filePath|
           handle_image(filePath)         
        }
        calculate_image_total        
        puts "压缩后图片总大小: " + format("%.2f", @imageSize_total) + " KB"
      
        puts "<----------------"
        self.end
    end
    def end
        puts "\033[31m------------ end ------------\033[0m\n"        
    end
    
end

imgM = ImageManager.new(DIR_PATH)
imgM.run
